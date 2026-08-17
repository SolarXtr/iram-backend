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

// === REFERENCE DATABASE ENDPOINTS ===

app.get('/api/reference/quartile/:issn', async (c) => {
  try {
    const issn = c.req.param('issn');
    const record = await c.env.DB.prepare(`
      SELECT issn, source, quartile, year
      FROM irJournalQuartile
      WHERE issn = ?
      ORDER BY year DESC
      LIMIT 1
    `).bind(issn).first();

    if (!record) {
      return c.json({ error: 'Not found' }, 404);
    }

    return c.json(record);
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

app.post('/api/reference/journals', async (c) => {
  try {
    const body = await c.req.json();
    if (!Array.isArray(body)) {
      return c.json({ error: 'Body must be an array' }, 400);
    }

    let count = 0;
    for (const j of body) {
      const { issn, source, quartile, year } = j;
      if (!issn || !source) continue;

      const id = `${issn}-${source}`;
      await c.env.DB.prepare(`
        INSERT OR REPLACE INTO irJournalQuartile (id, issn, source, quartile, year, updatedAt)
        VALUES (?, ?, ?, ?, ?, datetime('now'))
      `).bind(id, issn, source, quartile || null, year || null).run();
      count++;
    }

    return c.json({ status: 'inserted', count });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// === PUBLICATIONS ENDPOINTS ===

app.get('/api/publications', async (c) => {
  try {
    const { results } = await c.env.DB.prepare(`
      SELECT p.*, 
             (SELECT json_group_array(json_object('name', a.authorName, 'userId', a.userId, 'isCorresponding', a.isCorresponding, 'isNuAffiliated', a.isNuAffiliated))
              FROM irPublicationAuthor a WHERE a.publicationId = p.id) as authors
      FROM irPublication p 
      ORDER BY p.createdAt DESC
    `).all()
    return c.json(results)
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

async function processSingleImport(db: any, body: any, userRole: string, activeUserId: string, activeUserName: string) {
    const { doi, title, journal, year, coverDate, citations, quartile, quartile_scimago, status, authors, databases } = body

    if (userRole === 'MEMBER') {
      const hasSelf = authors && authors.some((a: any) => 
        (a.userId === activeUserId) || 
        (a.name && a.name.toLowerCase() === activeUserName)
      );
      if (!hasSelf) {
        return { status: 'error', error: 'Unauthorized: You can only import publications that list you as an author' };
      }
    }

    const sourceDbStr = databases ? JSON.stringify(databases) : '["Scopus"]'

    // 1. Duplicate Check
    const existing = await db.prepare('SELECT id, sourceDatabases FROM irPublication WHERE doi = ? OR title = ?').bind(doi || null, title).first()
    
    if (existing) {
      let existingDbs: string[] = []
      try {
        existingDbs = JSON.parse((existing as any).sourceDatabases || '["Scopus"]')
      } catch (e) {}
      
      const newDbs = databases || ["Scopus"]
      const mergedDbs = Array.from(new Set([...existingDbs, ...newDbs]))
      const mergedDbStr = JSON.stringify(mergedDbs)

      await db.prepare('UPDATE irPublication SET year = COALESCE(?, year), coverDate = COALESCE(?, coverDate), citations = COALESCE(?, citations), quartile_scimago = COALESCE(?, quartile_scimago), sourceDatabases = ? WHERE id = ?').bind(year || null, coverDate || null, citations ?? null, quartile_scimago || null, mergedDbStr, existing.id).run()
      
      if (authors && authors.length > 0) {
        await db.prepare('DELETE FROM irPublicationAuthor WHERE publicationId = ?').bind(existing.id).run()
        
        let authorsWithUserId = [];
        for (const auth of authors) {
          const user = await db.prepare('SELECT id FROM irUser WHERE name LIKE ? COLLATE NOCASE').bind(`%${auth.name}%`).first()
          authorsWithUserId.push({
            ...auth,
            userId: user ? (user as any).id : null
          });
        }
        
        let medNuAuthorsBefore = 0;
        let claimingAuthorId: string | null = null;
        for (const auth of authorsWithUserId) {
          const authId = crypto.randomUUID()
          await db.prepare(`
            INSERT INTO irPublicationAuthor (id, publicationId, authorName, userId, authorOrder, isCorresponding, isNuAffiliated)
            VALUES (?, ?, ?, ?, ?, ?, ?)
          `).bind(authId, existing.id, auth.name, auth.userId, auth.order, auth.isCorresponding ? 1 : 0, auth.isNuAffiliated ?? 1).run()
          
          if (auth.userId) {
            const isFirstAuthor = auth.order === 1;
            const isCorresponding = auth.isCorresponding;
            const isFirstMedNuOnPaper = (medNuAuthorsBefore === 0);

            if (isFirstAuthor || isCorresponding || isFirstMedNuOnPaper) {
              claimingAuthorId = auth.userId;
            }
            medNuAuthorsBefore++;
          }
        }
        
        if (claimingAuthorId) {
          await db.prepare('UPDATE irPublication SET claimingAuthorId = ? WHERE id = ?').bind(claimingAuthorId, existing.id).run()
        }
      }
      
      return { status: 'skipped', id: existing.id, message: 'Publication already exists, updated data if provided' }
    }

    // 2. Identify claimingAuthorId
    let claimingAuthorId: string | null = null;
    let authorsWithUserId = [];

    for (const auth of authors) {
      const user = await db.prepare('SELECT id FROM irUser WHERE name LIKE ? COLLATE NOCASE').bind(`%${auth.name}%`).first()
      authorsWithUserId.push({
        ...auth,
        userId: user ? (user as any).id : null
      });
    }

    let medNuAuthorsBefore = 0;
    for (const auth of authorsWithUserId) {
      if (auth.userId) {
        const isFirstAuthor = auth.order === 1;
        const isCorresponding = auth.isCorresponding;
        const isFirstMedNuOnPaper = (medNuAuthorsBefore === 0);

        if (isFirstAuthor || isCorresponding || isFirstMedNuOnPaper) {
          claimingAuthorId = auth.userId;
          break; 
        }
        medNuAuthorsBefore++;
      }
    }

    // 3. Insert into irPublication
    const pubId = crypto.randomUUID()
    await db.prepare(`
      INSERT INTO irPublication (id, doi, title, journal, year, coverDate, citations, quartile, quartile_scimago, uniRewardStatus, uniRewardAmount, facultyRewardStatus, facultyRewardAmount, status, projectId, claimingAuthorId, sourceDatabases)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'PENDING', 0, 'PENDING', 0, ?, NULL, ?, ?)
    `).bind(pubId, doi || null, title, journal || '', year || null, coverDate || null, citations ?? 0, quartile || '', quartile_scimago || 'N/A', status || 'PUBLISHED', claimingAuthorId, sourceDbStr).run()

    // 4. Insert into irPublicationAuthor
    for (const auth of authorsWithUserId) {
      const authId = crypto.randomUUID()
      await db.prepare(`
        INSERT INTO irPublicationAuthor (id, publicationId, authorName, userId, authorOrder, isCorresponding, isNuAffiliated)
        VALUES (?, ?, ?, ?, ?, ?, ?)
      `).bind(authId, pubId, auth.name, auth.userId, auth.order, auth.isCorresponding ? 1 : 0, auth.isNuAffiliated ?? 1).run()
    }

    return { status: 'inserted', id: pubId, claimingAuthorId }
}

app.post('/api/publications/import', async (c) => {
  try {
    const userRole = c.req.header('X-User-Role') || 'USER';
    const activeUserId = c.req.header('X-User-Id') || '';

    if (userRole !== 'ADMIN' && userRole !== 'MEMBER') {
      return c.json({ error: 'Unauthorized' }, 403);
    }

    let activeUserName = '';
    if (userRole === 'MEMBER') {
      const user = await c.env.DB.prepare('SELECT name FROM irUser WHERE id = ?').bind(activeUserId).first();
      if (!user) {
        return c.json({ error: 'Unauthorized' }, 403);
      }
      activeUserName = (user as any).name.toLowerCase();
    }

    const body = await c.req.json()
    const result = await processSingleImport(c.env.DB, body, userRole, activeUserId, activeUserName);
    
    if (result.error) {
      return c.json({ error: result.error }, 403);
    }
    return c.json(result)
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

app.post('/api/publications/bulk-import', async (c) => {
  try {
    const userRole = c.req.header('X-User-Role') || 'USER';
    const activeUserId = c.req.header('X-User-Id') || '';

    if (userRole !== 'ADMIN' && userRole !== 'MEMBER') {
      return c.json({ error: 'Unauthorized' }, 403);
    }

    const items = await c.req.json();
    if (!Array.isArray(items)) {
      return c.json({ error: 'Body must be an array' }, 400);
    }

    let activeUserName = '';
    if (userRole === 'MEMBER') {
      const user = await c.env.DB.prepare('SELECT name FROM irUser WHERE id = ?').bind(activeUserId).first();
      if (!user) {
        return c.json({ error: 'Unauthorized' }, 403);
      }
      activeUserName = (user as any).name.toLowerCase();
    }

    const results = [];
    for (const body of items) {
      try {
        const res = await processSingleImport(c.env.DB, body, userRole, activeUserId, activeUserName);
        results.push(res);
      } catch (err: any) {
        results.push({ status: 'error', error: err.message, title: body.title });
      }
    }
    
    return c.json({ status: 'completed', total: results.length, results })
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

app.put('/api/publications/:id', async (c) => {
  try {
    const userRole = c.req.header('X-User-Role') || 'USER';
    const activeUserId = c.req.header('X-User-Id') || '';
    const id = c.req.param('id');

    if (userRole !== 'ADMIN' && userRole !== 'MEMBER') {
      return c.json({ error: 'Unauthorized' }, 403);
    }

    if (userRole === 'MEMBER') {
      const isAuthor = await c.env.DB.prepare(`
        SELECT 1 FROM irPublicationAuthor 
        WHERE publicationId = ? AND userId = ?
      `).bind(id, activeUserId).first();
      if (!isAuthor) {
        return c.json({ error: 'Unauthorized: You can only edit your own publications' }, 403);
      }
    }

    const body = await c.req.json();
    const { title, journal, year, citations, doi, quartile, quartile_scimago, authors } = body;

    const fields = [];
    const bindings = [];

    if (title !== undefined) { fields.push('title = ?'); bindings.push(title); }
    if (journal !== undefined) { fields.push('journal = ?'); bindings.push(journal); }
    if (year !== undefined) { fields.push('year = ?'); bindings.push(parseInt(year) || null); }
    if (citations !== undefined) { fields.push('citations = ?'); bindings.push(parseInt(citations) || 0); }
    if (doi !== undefined) { fields.push('doi = ?'); bindings.push(doi || null); }
    if (quartile !== undefined) { fields.push('quartile = ?'); bindings.push(quartile || 'N/A'); }
    if (quartile_scimago !== undefined) { fields.push('quartile_scimago = ?'); bindings.push(quartile_scimago || 'N/A'); }

    if (fields.length > 0) {
      bindings.push(id);
      await c.env.DB.prepare(`
        UPDATE irPublication 
        SET ${fields.join(', ')} 
        WHERE id = ?
      `).bind(...bindings).run();
    }

    if (authors && Array.isArray(authors)) {
      await c.env.DB.prepare('DELETE FROM irPublicationAuthor WHERE publicationId = ?').bind(id).run();
      
      let medNuAuthorsBefore = 0;
      let claimingAuthorId: string | null = null;

      for (const auth of authors) {
        const authId = crypto.randomUUID();
        let finalUserId = auth.userId || null;
        
        if (!finalUserId && auth.name) {
          const matchedUser = await c.env.DB.prepare('SELECT id FROM irUser WHERE name LIKE ? COLLATE NOCASE').bind(`%${auth.name}%`).first();
          if (matchedUser) {
            finalUserId = (matchedUser as any).id;
          }
        }

        await c.env.DB.prepare(`
          INSERT INTO irPublicationAuthor (id, publicationId, authorName, userId, authorOrder, isCorresponding, isNuAffiliated)
          VALUES (?, ?, ?, ?, ?, ?, ?)
        `).bind(
          authId, 
          id, 
          auth.name, 
          finalUserId, 
          auth.order || 1, 
          auth.isCorresponding ? 1 : 0, 
          auth.isNuAffiliated ? 1 : 0
        ).run();

        if (finalUserId) {
          const isFirstAuthor = auth.order === 1;
          const isCorresponding = auth.isCorresponding;
          const isFirstMedNuOnPaper = (medNuAuthorsBefore === 0);

          if (isFirstAuthor || isCorresponding || isFirstMedNuOnPaper) {
            claimingAuthorId = finalUserId;
          }
          medNuAuthorsBefore++;
        }
      }

      await c.env.DB.prepare(`
        UPDATE irPublication
        SET claimingAuthorId = ?
        WHERE id = ?
      `).bind(claimingAuthorId, id).run();
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
        p.scopusAuthorId as author_id,
        p.wosResearcherId,
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

app.post('/api/auth/login', async (c) => {
  try {
    const body = await c.req.json();
    const { email } = body;
    
    if (!email) {
      return c.json({ error: 'Email is required' }, 400);
    }

    // Admin Simulation
    if (email.toLowerCase() === 'admin@nu.ac.th' || email.toLowerCase() === 'admin') {
      return c.json({
        user: {
          id: 'admin-id-1234',
          name: 'iRAM Administrator',
          email: 'admin@nu.ac.th',
          role: 'ADMIN'
        }
      });
    }

    // Try finding the researcher in irUser table
    const user = await c.env.DB.prepare('SELECT id, name, email FROM irUser WHERE email = ? COLLATE NOCASE').bind(email).first();
    if (user) {
      return c.json({
        user: {
          id: (user as any).id,
          name: (user as any).name,
          email: (user as any).email,
          role: 'MEMBER'
        }
      });
    }

    // Default User / Guest
    return c.json({
      user: {
        id: 'guest-id-' + Math.random().toString(36).substr(2, 9),
        name: email.split('@')[0],
        email: email,
        role: 'USER'
      }
    });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
})

app.post('/api/researchers', async (c) => {
  try {
    const userRole = c.req.header('X-User-Role') || 'USER';
    if (userRole !== 'ADMIN') {
      return c.json({ error: 'Unauthorized: Admin access required' }, 403);
    }

    const body = await c.req.json();
    const { name, author_id, orcid, department, joinDate, resignDate, status } = body;

    const userId = crypto.randomUUID();
    
    // Split name into first/last name
    const parts = name.trim().split(/\s+/);
    const firstName = parts[0] || '';
    const lastName = parts.slice(1).join(' ') || '';
    const email = `${firstName.toLowerCase()}.${lastName.toLowerCase().replace(/\s+/g, '') || 'researcher'}@nu.ac.th`;

    // Insert into irUser
    await c.env.DB.prepare(`
      INSERT INTO irUser (id, name, email, firstName, lastName, role, joinDate, resignDate)
      VALUES (?, ?, ?, ?, ?, 'RESEARCHER', ?, ?)
    `).bind(userId, name, email, firstName, lastName, joinDate || null, resignDate || null).run();

    // Insert into irResearcherProfile
    await c.env.DB.prepare(`
      INSERT INTO irResearcherProfile (id, userId, department, status, orcid, scopusAuthorId)
      VALUES (?, ?, ?, ?, ?, ?)
    `).bind(crypto.randomUUID(), userId, department || 'Faculty of Medicine', status || 'Active', orcid || null, author_id || null).run();

    return c.json({ status: 'inserted', id: userId });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
})

app.put('/api/researchers/:id', async (c) => {
  try {
    const id = c.req.param('id');
    const userRole = c.req.header('X-User-Role') || 'USER';
    
    if (userRole !== 'ADMIN') {
      return c.json({ error: 'Unauthorized: Admin access required' }, 403);
    }

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
