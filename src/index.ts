import { Hono } from 'hono'
import { cors } from 'hono/cors'

type Bindings = {
  DB: D1Database
}

const app = new Hono<{ Bindings: Bindings }>()

app.use('*', cors())

app.get('/', (c) => {
  return c.text('iRAM Backend API is running on Cloudflare Workers!')
})

// === PUBLICATIONS ENDPOINTS ===

app.get('/api/publications', async (c) => {
  try {
    const { results } = await c.env.DB.prepare(`
      SELECT p.*, 
             (SELECT json_group_array(json_object('name', a.authorName, 'isCorresponding', a.isCorresponding, 'isNuAffiliated', a.isNuAffiliated))
              FROM irPublicationAuthor a WHERE a.publicationId = p.id) as authors
      FROM irPublication p 
      ORDER BY p.createdAt DESC
    `).all()
    return c.json(results)
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

app.post('/api/publications/import', async (c) => {
  try {
    const body = await c.req.json()
    const { doi, title, journal, year, coverDate, citations, quartile, status, authors, databases } = body
    const sourceDbStr = databases ? JSON.stringify(databases) : '["Scopus"]'

    // 1. Duplicate Check
    const existing = await c.env.DB.prepare('SELECT id, sourceDatabases FROM irPublication WHERE doi = ? OR title = ?').bind(doi || null, title).first()
    
    if (existing) {
      // Merge databases if needed
      let existingDbs: string[] = []
      try {
        existingDbs = JSON.parse((existing as any).sourceDatabases || '["Scopus"]')
      } catch (e) {}
      
      const newDbs = databases || ["Scopus"]
      const mergedDbs = Array.from(new Set([...existingDbs, ...newDbs]))
      const mergedDbStr = JSON.stringify(mergedDbs)

      // Update year, coverDate, citations, and sourceDatabases for existing publication
      await c.env.DB.prepare('UPDATE irPublication SET year = COALESCE(?, year), coverDate = COALESCE(?, coverDate), citations = COALESCE(?, citations), sourceDatabases = ? WHERE id = ?').bind(year || null, coverDate || null, citations ?? null, mergedDbStr, existing.id).run()
      
      return c.json({ status: 'skipped', id: existing.id, message: 'Publication already exists, updated year/coverDate/citations/databases if provided' })
    }

    // 2. Identify claimingAuthorId based on eligibility rules
    let claimingAuthorId: string | null = null;
    let authorsWithUserId = [];

    // First pass: resolve userIds
    for (const auth of authors) {
      const user = await c.env.DB.prepare('SELECT id FROM irUser WHERE name LIKE ? COLLATE NOCASE').bind(`%${auth.name}%`).first()
      authorsWithUserId.push({
        ...auth,
        userId: user ? (user as any).id : null
      });
    }

    // Evaluate eligibility
    let medNuAuthorsBefore = 0;
    for (const auth of authorsWithUserId) {
      if (auth.userId) {
        // Is MedNU researcher
        const isFirstAuthor = auth.order === 1;
        const isCorresponding = auth.isCorresponding;
        const isFirstMedNuOnPaper = (medNuAuthorsBefore === 0);

        if (isFirstAuthor || isCorresponding || isFirstMedNuOnPaper) {
          claimingAuthorId = auth.userId;
          break; // The first one who qualifies gets the claiming spot
        }
        medNuAuthorsBefore++;
      }
    }

    // 3. Insert into irPublication
    const pubId = crypto.randomUUID()
    await c.env.DB.prepare(`
      INSERT INTO irPublication (id, doi, title, journal, year, coverDate, citations, quartile, uniRewardStatus, uniRewardAmount, facultyRewardStatus, facultyRewardAmount, status, projectId, claimingAuthorId, sourceDatabases)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'PENDING', 0, 'PENDING', 0, ?, NULL, ?, ?)
    `).bind(pubId, doi || null, title, journal || '', year || null, coverDate || null, citations ?? 0, quartile || '', status || 'PUBLISHED', claimingAuthorId, sourceDbStr).run()

    // 4. Insert into irPublicationAuthor
    for (const auth of authorsWithUserId) {
      const authId = crypto.randomUUID()
      await c.env.DB.prepare(`
        INSERT INTO irPublicationAuthor (id, publicationId, authorName, userId, authorOrder, isCorresponding, isNuAffiliated)
        VALUES (?, ?, ?, ?, ?, ?, ?)
      `).bind(authId, pubId, auth.name, auth.userId, auth.order, auth.isCorresponding ? 1 : 0, auth.isNuAffiliated ?? 1).run()
    }

    return c.json({ status: 'inserted', id: pubId, claimingAuthorId })
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

app.put('/api/publications/:id', async (c) => {
  try {
    const id = c.req.param('id');
    const body = await c.req.json();
    const { quartile } = body;

    if (quartile !== undefined) {
      await c.env.DB.prepare(`
        UPDATE irPublication 
        SET quartile = ? 
        WHERE id = ?
      `).bind(quartile, id).run();
    }
    
    return c.json({ status: 'updated', id });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
})

// === RESEARCHERS ENDPOINTS ===

app.get('/api/researchers', async (c) => {
  try {
    const { results: researchers } = await c.env.DB.prepare(`
      SELECT 
        u.id, 
        u.name, 
        u.joinDate,
        u.resignDate,
        COALESCE(p.department, 'Faculty of Medicine') as department,
        COALESCE(p.status, 'Active') as status,
        p.orcid,
        (SELECT COUNT(DISTINCT pa.publicationId) FROM irPublicationAuthor pa WHERE pa.userId = u.id) as publications_count,
        (SELECT COUNT(rp.id) FROM irResearchProject rp WHERE rp.leaderId = u.id) as projects_count
      FROM irUser u
      LEFT JOIN irResearcherProfile p ON u.id = p.userId
      WHERE u.role = 'RESEARCHER'
      ORDER BY u.name ASC
    `).all()
    
    return c.json(researchers)
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

app.post('/api/researchers', async (c) => {
  // Keeping old researcher sync code intact
  return c.json({ status: 'deprecated', message: 'Use direct DB imports' })
})

app.put('/api/researchers/:id', async (c) => {
  try {
    const id = c.req.param('id');
    const body = await c.req.json();
    const { orcid, joinDate, resignDate } = body;
    
    if (joinDate !== undefined || resignDate !== undefined) {
      const updates = [];
      const bindings = [];
      if (joinDate !== undefined) { updates.push('joinDate = ?'); bindings.push(joinDate); }
      if (resignDate !== undefined) { updates.push('resignDate = ?'); bindings.push(resignDate); }
      bindings.push(id);
      
      await c.env.DB.prepare(`
        UPDATE irUser 
        SET ${updates.join(', ')}
        WHERE id = ?
      `).bind(...bindings).run();
    }

    if (orcid !== undefined) {
      // Find the researcher profile by id (which maps to u.id in the GET request, but let's check if the ID passed is user id or profile id)
      // In the GET request: SELECT u.id ... FROM irUser u LEFT JOIN irResearcherProfile p ON u.id = p.userId
      // So the id being passed is irUser.id. We need to update irResearcherProfile where userId = id
      await c.env.DB.prepare(`
        UPDATE irResearcherProfile 
        SET orcid = ? 
        WHERE userId = ?
      `).bind(orcid, id).run();
    }
    
    return c.json({ status: 'updated', id });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
})

// === PROJECTS ENDPOINTS ===

app.get('/api/projects', async (c) => {
  try {
    const { results } = await c.env.DB.prepare(`
      SELECT p.id, p.title, p.status, p.startDate, p.endDate, p.department, p.budgetInitial, p.budgetSpent,
             u.name as piName 
      FROM irResearchProject p 
      LEFT JOIN irUser u ON p.leaderId = u.id
      ORDER BY p.createdAt DESC
    `).all();
    return c.json(results);
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// === FUNDING ENDPOINTS ===

app.get('/api/funding', async (c) => {
  try {
    const { results } = await c.env.DB.prepare(`
      SELECT p.id, p.title as projectTitle, p.status, 
             p.budgetInitial as amount, p.budgetSpent,
             u.name as piName
      FROM irResearchProject p 
      LEFT JOIN irUser u ON p.leaderId = u.id
      WHERE p.budgetInitial > 0
      ORDER BY p.createdAt DESC
    `).all();
    return c.json(results);
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// === CONFERENCES ENDPOINTS ===

app.get('/api/conferences', async (c) => {
  try {
    const { results } = await c.env.DB.prepare(`
      SELECT c.id, c.title, c.conference, c.type, c.status,
             u.name as presenterName 
      FROM irPresentation c 
      LEFT JOIN irUser u ON c.presenterId = u.id
      ORDER BY c.createdAt DESC
    `).all();
    return c.json(results);
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// === ANALYTICS ENDPOINTS ===

app.post('/api/analytics/view', async (c) => {
  try {
    const body = await c.req.json();
    const { domain, path, sessionId, userAgent, resolution, language, referrer, deviceType: clientDeviceType } = body;
    
    if (!domain || !path || !sessionId) {
      return c.json({ error: 'Missing required fields' }, 400);
    }
    
    const ipAddress = c.req.header('cf-connecting-ip') || c.req.header('x-forwarded-for') || 'unknown';
    const country = c.req.header('cf-ipcountry') || 'unknown';

    // Parse device type if not provided explicitly by frontend
    let deviceType = clientDeviceType || 'Desktop';
    if (!clientDeviceType && userAgent) {
        const ua = userAgent.toLowerCase();
        if (/(tablet|ipad|playbook|silk)|(android(?!.*mobi))/i.test(ua)) {
            deviceType = 'Tablet';
        } else if (/Mobile|iP(hone|od)|Android|BlackBerry|IEMobile|Kindle|Silk-Accelerated|(hpw|web)OS|Opera M(obi|ini)/.test(ua)) {
            deviceType = 'Mobile';
        }
    }

    // Check if same session visited same path in last 30 minutes
    const recentView = await c.env.DB.prepare(`
      SELECT id FROM irPageViews 
      WHERE sessionId = ? AND domain = ? AND path = ? 
      AND timestamp >= datetime('now', '-30 minutes')
    `).bind(sessionId, domain, path).first();

    if (recentView) {
      return c.json({ status: 'skipped', message: 'Already recorded recently for this session' });
    }

    const viewId = crypto.randomUUID();
    await c.env.DB.prepare(`
      INSERT INTO irPageViews (id, domain, path, sessionId, userAgent, ipAddress, country, deviceType, resolution, language, referrer)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).bind(
      viewId, 
      domain, 
      path, 
      sessionId, 
      userAgent || null,
      ipAddress,
      country,
      deviceType,
      resolution || null,
      language || null,
      referrer || null
    ).run();

    return c.json({ status: 'recorded', id: viewId });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

app.get('/api/analytics/summary', async (c) => {
  try {
    // Return aggregate counts (total, today, this month) grouped by domain and path
    const { results } = await c.env.DB.prepare(`
      SELECT domain, path, 
             COUNT(id) as totalViews,
             SUM(CASE WHEN date(timestamp) = date('now') THEN 1 ELSE 0 END) as viewsToday,
             SUM(CASE WHEN strftime('%Y-%m', timestamp) = strftime('%Y-%m', 'now') THEN 1 ELSE 0 END) as viewsThisMonth
      FROM irPageViews
      GROUP BY domain, path
      ORDER BY totalViews DESC
    `).all();
    
    return c.json(results);
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

  app.get('/api/analytics/dashboard', async (c) => {
    try {
      const db = c.env.DB;
      
      const deviceStats = await db.prepare(`SELECT deviceType as label, COUNT(id) as count FROM irPageViews GROUP BY deviceType ORDER BY count DESC`).all();
      const countryStats = await db.prepare(`SELECT country as label, COUNT(id) as count FROM irPageViews GROUP BY country ORDER BY count DESC LIMIT 10`).all();
      const resolutionStats = await db.prepare(`SELECT resolution as label, COUNT(id) as count FROM irPageViews WHERE resolution IS NOT NULL GROUP BY resolution ORDER BY count DESC LIMIT 10`).all();
      const referrerStats = await db.prepare(`SELECT referrer as label, COUNT(id) as count FROM irPageViews WHERE referrer IS NOT NULL AND referrer != '' GROUP BY referrer ORDER BY count DESC LIMIT 10`).all();
      const trendStats = await db.prepare(`SELECT date(timestamp) as date, COUNT(id) as count FROM irPageViews WHERE timestamp >= datetime('now', '-30 days') GROUP BY date(timestamp) ORDER BY date(timestamp) ASC`).all();

      return c.json({
        devices: deviceStats.results,
        countries: countryStats.results,
        resolutions: resolutionStats.results,
        referrers: referrerStats.results,
        trend: trendStats.results
      });
    } catch (e: any) {
      return c.json({ error: e.message }, 500);
    }
  });

// === PROJECTS ENDPOINTS ===

app.get('/api/projects', async (c) => {
  try {
    const { results } = await c.env.DB.prepare(`
      SELECT p.id, p.title, p.status, p.startDate, p.endDate, p.budgetInitial,
             u.name as leaderName 
      FROM irResearchProject p
      LEFT JOIN irUser u ON p.leaderId = u.id
      ORDER BY p.startDate DESC
    `).all();
    return c.json(results);
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

export default app
