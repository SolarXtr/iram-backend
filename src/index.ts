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

    // Tier 1 Cache: Cache at Cloudflare Edge & Browser for 24 Hours
    c.header('Cache-Control', 'public, max-age=86400, s-maxage=86400');
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

    // Tier 2 Cache: Edge caching for 5 minutes, serve stale up to 10 minutes while revalidating
    c.header('Cache-Control', 'public, max-age=300, s-maxage=300, stale-while-revalidate=600');
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
      const cleanAuthName = (auth.name || '').trim();
      const user = await db.prepare(`
        SELECT id FROM irUser 
        WHERE shortNameEn = ? COLLATE NOCASE 
           OR name = ? COLLATE NOCASE
           OR name LIKE ? COLLATE NOCASE
           OR aliasesJson LIKE ?
        LIMIT 1
      `).bind(cleanAuthName, cleanAuthName, `%${cleanAuthName}%`, `%"${cleanAuthName}"%`).first();
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
        u.shortNameEn,
        u.aliasesJson,
        u.joinDate,
        u.resignDate,
        COALESCE(u.department, p.department, 'Faculty of Medicine') as department,
        COALESCE(p.status, 'Active') as status,
        COALESCE(u.orcid, p.orcid) as orcid,
        COALESCE(u.scopusAuthorId, p.scopusAuthorId) as author_id,
        COALESCE(u.wosResearcherId, p.wosResearcherId) as wosResearcherId,
        (SELECT COUNT(DISTINCT pa.publicationId) FROM irPublicationAuthor pa WHERE pa.userId = u.id) as publications_count,
        (SELECT COUNT(rp.id) FROM irResearchProject rp WHERE rp.leaderId = u.id) as projects_count
      FROM irUser u
      LEFT JOIN irResearcherProfile p ON u.id = p.userId
      WHERE u.role = 'RESEARCHER'
      ORDER BY u.name ASC
    `).all()
    
    // Tier 2 Cache: Edge caching for 5 minutes, serve stale up to 10 minutes while revalidating
    c.header('Cache-Control', 'public, max-age=300, s-maxage=300, stale-while-revalidate=600');
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
    const { name, author_id, orcid, department, joinDate, resignDate, status } = body;
    
    // --- Update irUser fields ---
    const userUpdates: string[] = [];
    const userBindings: any[] = [];

    if (name !== undefined) { userUpdates.push('name = ?'); userBindings.push(name); }
    if (joinDate !== undefined) { userUpdates.push('joinDate = ?'); userBindings.push(joinDate || null); }
    if (resignDate !== undefined) { userUpdates.push('resignDate = ?'); userBindings.push(resignDate || null); }
    if (department !== undefined) { userUpdates.push('department = ?'); userBindings.push(department || null); }
    if (orcid !== undefined) { userUpdates.push('orcid = ?'); userBindings.push(orcid || null); }
    if (author_id !== undefined) { userUpdates.push('scopusAuthorId = ?'); userBindings.push(author_id || null); }

    if (userUpdates.length > 0) {
      userBindings.push(id);
      await c.env.DB.prepare(`
        UPDATE irUser 
        SET ${userUpdates.join(', ')}
        WHERE id = ?
      `).bind(...userBindings).run();
    }

    // --- Update irResearcherProfile fields (for backwards compatibility) ---
    const profileUpdates: string[] = [];
    const profileBindings: any[] = [];

    if (orcid !== undefined) { profileUpdates.push('orcid = ?'); profileBindings.push(orcid || null); }
    if (author_id !== undefined) { profileUpdates.push('scopusAuthorId = ?'); profileBindings.push(author_id || null); }
    if (department !== undefined) { profileUpdates.push('department = ?'); profileBindings.push(department || null); }
    if (status !== undefined) { profileUpdates.push('status = ?'); profileBindings.push(status || 'Active'); }

    if (profileUpdates.length > 0) {
      profileBindings.push(id);
      await c.env.DB.prepare(`
        UPDATE irResearcherProfile 
        SET ${profileUpdates.join(', ')}
        WHERE userId = ?
      `).bind(...profileBindings).run();
    }
    
    return c.json({ status: 'updated', id });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
})

// === DELETE ENDPOINTS ===

app.delete('/api/publications/:id', async (c) => {
  try {
    const id = c.req.param('id');
    const userRole = c.req.header('X-User-Role') || 'USER';

    if (userRole !== 'ADMIN') {
      return c.json({ error: 'Unauthorized: Admin access required' }, 403);
    }

    // Soft delete: mark as deleted without removing from DB to preserve referential integrity
    await c.env.DB.prepare(`
      UPDATE irPublication SET isDeleted = 1 WHERE id = ?
    `).bind(id).run();

    return c.json({ status: 'deleted', id });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
})

app.delete('/api/researchers/:id', async (c) => {
  try {
    const id = c.req.param('id');
    const userRole = c.req.header('X-User-Role') || 'USER';

    if (userRole !== 'ADMIN') {
      return c.json({ error: 'Unauthorized: Admin access required' }, 403);
    }

    // Soft delete: mark user as deleted without removing from DB
    await c.env.DB.prepare(`
      UPDATE irUser SET isDeleted = 1 WHERE id = ?
    `).bind(id).run();

    return c.json({ status: 'deleted', id });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
})

// === PROJECTS ENDPOINTS ===

app.get('/api/projects', async (c) => {
  try {
    const { results } = await c.env.DB.prepare(`
      SELECT p.id, p.title, p.status, p.startDate, p.endDate, p.department, p.budgetInitial, p.budgetSpent,
             u.name as piName, u.name as leaderName 
      FROM irResearchProject p 
      LEFT JOIN irUser u ON p.leaderId = u.id
      ORDER BY p.createdAt DESC
    `).all();
    // Tier 2 Cache: Edge caching for 5 minutes, serve stale up to 10 minutes while revalidating
    c.header('Cache-Control', 'public, max-age=300, s-maxage=300, stale-while-revalidate=600');
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
    c.header('Cache-Control', 'public, max-age=300, s-maxage=300, stale-while-revalidate=600');
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
    c.header('Cache-Control', 'public, max-age=300, s-maxage=300, stale-while-revalidate=600');
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

// === FUNDING STATUS ENDPOINT ===
app.get('/api/funding-status', async (c) => {
    try {
      const { results } = await c.env.DB.prepare(`
        SELECT p.id, p.title as name, 
               COALESCE(u.name, p.leaderId) as researcher, 
               p.status, 
               p.updatedAt as date
        FROM irResearchProject p
        LEFT JOIN irUser u ON p.leaderId = u.id
        ORDER BY p.updatedAt DESC
      `).all();
      c.header('Cache-Control', 'public, max-age=300, s-maxage=300, stale-while-revalidate=600');
      return c.json(results);
    } catch (e: any) {
      return c.json({ error: e.message }, 500);
    }
  });

// === REWARD APPLICATIONS ENDPOINTS (Med NU Research Reward System) ===

// 1. Duplicate & Previous Claim Check Endpoint
app.get('/api/rewards/check-duplicate', async (c) => {
  try {
    const doi = (c.req.query('doi') || '').trim();
    const title = (c.req.query('title') || '').trim();

    if (!doi && !title) {
      return c.json({ isDuplicate: false, message: 'No DOI or title provided' });
    }

    // A. Check in irRewardApplication (Pending, Approved, or Paid claims)
    let rewardMatch: any = null;
    if (doi) {
      rewardMatch = await c.env.DB.prepare(`
        SELECT id, trackingNo, applicantName, authorRole, status, requestType, totalClaimedAmount, createdAt
        FROM irRewardApplication
        WHERE (LOWER(TRIM(doi)) = LOWER(TRIM(?))) AND status != 'rejected'
        ORDER BY createdAt DESC
        LIMIT 1
      `).bind(doi).first();
    }

    if (!rewardMatch && title && title.length >= 10) {
      rewardMatch = await c.env.DB.prepare(`
        SELECT id, trackingNo, applicantName, authorRole, status, requestType, totalClaimedAmount, createdAt
        FROM irRewardApplication
        WHERE (LOWER(TRIM(articleTitle)) = LOWER(TRIM(?)) OR articleTitle LIKE ?) AND status != 'rejected'
        ORDER BY createdAt DESC
        LIMIT 1
      `).bind(title, `%${title}%`).first();
    }

    if (rewardMatch) {
      return c.json({
        isDuplicate: true,
        source: 'reward_application',
        match: rewardMatch,
        message: `บทความนี้เคยมีการยื่นขอรับเงินรางวัล/ค่าตีพิมพ์แล้วในคำขอเลขที่ ${rewardMatch.trackingNo} โดย ${rewardMatch.applicantName} (สถานะ: ${rewardMatch.status}) ตามหลักเกณฑ์ประกาศฯ 1 บทความสามารถยื่นขอรับการสนับสนุนได้เพียงครั้งเดียวในคราวเดียวกัน`
      });
    }

    // B. Check in irPublication (Faculty Historical Publications - PAID / APPROVED)
    let pubMatch: any = null;
    if (doi) {
      pubMatch = await c.env.DB.prepare(`
        SELECT id, title, doi, facultyRewardStatus, facultyRewardAmount, uniRewardStatus, uniRewardAmount
        FROM irPublication
        WHERE (LOWER(TRIM(doi)) = LOWER(TRIM(?)))
        LIMIT 1
      `).bind(doi).first();
    }

    if (!pubMatch && title && title.length >= 10) {
      pubMatch = await c.env.DB.prepare(`
        SELECT id, title, doi, facultyRewardStatus, facultyRewardAmount, uniRewardStatus, uniRewardAmount
        FROM irPublication
        WHERE (LOWER(TRIM(title)) = LOWER(TRIM(?)))
        LIMIT 1
      `).bind(title).first();
    }

    if (pubMatch && (pubMatch.facultyRewardStatus === 'APPROVED' || pubMatch.facultyRewardStatus === 'PAID' || pubMatch.facultyRewardAmount > 0)) {
      return c.json({
        isDuplicate: true,
        source: 'publication_history',
        match: pubMatch,
        message: `บทความนี้มีประวัติการเบิกจ่ายเงินรางวัลของคณะแพทยศาสตร์แล้ว (ยอดเงินรางวัล: ${(pubMatch.facultyRewardAmount || 0).toLocaleString()} บาท) จึงไม่สามารถยื่นขอรับเงินรางวัลซ้ำซ้อนได้อีก`
      });
    }

    return c.json({
      isDuplicate: false,
      message: 'ผ่านการตรวจสอบ: บทความนี้ยังไม่เคยมีประวัติการขอรับเงินรางวัลหรือค่าตีพิมพ์ในระบบ'
    });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// 2. Get All Reward Applications
app.get('/api/rewards', async (c) => {
  try {
    const fiscalYear = c.req.query('fiscalYear');
    let query = `SELECT * FROM irRewardApplication`;
    const params: any[] = [];

    if (fiscalYear) {
      query += ` WHERE fiscalYear = ?`;
      params.push(Number(fiscalYear));
    }
    query += ` ORDER BY createdAt DESC`;

    const stmt = c.env.DB.prepare(query);
    const { results } = params.length > 0 ? await stmt.bind(...params).all() : await stmt.all();

    // Parse JSON fields
    const parsed = (results || []).map((row: any) => ({
      ...row,
      timeline: row.timelineJson ? JSON.parse(row.timelineJson) : [],
      attachments: row.attachmentsJson ? JSON.parse(row.attachmentsJson) : []
    }));

    // Tier 3 Cache: Real-time with no-cache, must-revalidate
    c.header('Cache-Control', 'no-cache, no-store, must-revalidate');
    return c.json(parsed);
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// 3. Create New Reward Application
app.post('/api/rewards', async (c) => {
  try {
    const body = await c.req.json();
    const {
      id = `app-${Date.now()}-${Math.random().toString(36).substring(2, 7)}`,
      trackingNo,
      fiscalYear = 2570,
      applicantName,
      academicPosition = '',
      department = '',
      phone = '',
      email = '',
      bankName = 'ธนาคารกรุงศรีอยุธยา สาขามหาวิทยาลัยนเรศวร',
      bankAccountNo = '',
      idCardNo = '',
      pdpaConsentAccepted = 1,
      pdpaConsentDate = new Date().toISOString(),
      requestType = 'both',
      articleTitle,
      journalName = '',
      journalScope = 'international',
      database,
      databaseName,
      quartile = 'Q1',
      isTier1Top10 = 0,
      authorRole = 'first_author',
      articleType = 'research_article',
      issn = '',
      doi = '',
      volumeIssue = '',
      publishedDate = new Date().toISOString().split('T')[0],
      claimedRewardAmount = 0,
      claimedPageChargeAmount = 0,
      approvedPageChargeAmount = 0,
      totalClaimedAmount = 0,
      currentStep = 1,
      status = 'submitted',
      timeline = [],
      attachments = []
    } = body;

    const resolvedDatabase = databaseName || database || 'Scopus';

    if (!trackingNo || !applicantName || !articleTitle) {
      return c.json({ error: 'Missing required fields: trackingNo, applicantName, articleTitle' }, 400);
    }

    // Double-check duplicate before insert
    if (doi && doi.trim()) {
      const existing = await c.env.DB.prepare(`
        SELECT id, trackingNo FROM irRewardApplication 
        WHERE LOWER(TRIM(doi)) = LOWER(TRIM(?)) AND status != 'rejected'
      `).bind(doi.trim()).first();
      if (existing) {
        return c.json({ error: `บทความที่มี DOI นี้มีคำขออยู่ในระบบแล้ว (${(existing as any).trackingNo})` }, 409);
      }
    }

    await c.env.DB.prepare(`
      INSERT INTO irRewardApplication (
        id, trackingNo, fiscalYear, applicantName, academicPosition, department, phone, email,
        bankName, bankAccountNo, idCardNo, pdpaConsentAccepted, pdpaConsentDate,
        requestType, articleTitle, journalName, journalScope, databaseName, quartile, isTier1Top10,
        authorRole, articleType, issn, doi, volumeIssue, publishedDate,
        claimedRewardAmount, claimedPageChargeAmount, approvedPageChargeAmount, totalClaimedAmount,
        currentStep, status, timelineJson, attachmentsJson, createdAt, updatedAt
      ) VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?,
        ?, ?, ?, ?, ?,
        ?, ?, ?, ?, ?, ?, ?,
        ?, ?, ?, ?, ?, ?,
        ?, ?, ?, ?,
        ?, ?, ?, ?, datetime('now'), datetime('now')
      )
    `).bind(
      id ?? null,
      trackingNo ?? null,
      Number(fiscalYear) || 2570,
      applicantName ?? '',
      academicPosition ?? '',
      department ?? '',
      phone ?? '',
      email ?? '',
      bankName ?? 'ธนาคารกรุงศรีอยุธยา สาขามหาวิทยาลัยนเรศวร',
      bankAccountNo ?? '',
      idCardNo ?? '',
      pdpaConsentAccepted ? 1 : 0,
      pdpaConsentDate ?? new Date().toISOString(),
      requestType ?? 'both',
      articleTitle ?? '',
      journalName ?? '',
      journalScope ?? 'international',
      resolvedDatabase ?? 'Scopus',
      quartile ?? 'Q1',
      isTier1Top10 ? 1 : 0,
      authorRole ?? 'first_author',
      articleType ?? 'research_article',
      issn ?? '',
      doi ?? '',
      volumeIssue ?? '',
      publishedDate ?? '',
      Number(claimedRewardAmount) || 0,
      Number(claimedPageChargeAmount) || 0,
      Number(approvedPageChargeAmount) || 0,
      Number(totalClaimedAmount) || 0,
      Number(currentStep) || 1,
      status ?? 'submitted',
      JSON.stringify(timeline || []),
      JSON.stringify(attachments || [])
    ).run();

    return c.json({ status: 'success', id, trackingNo }, 201);
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// 4. Update Application Status & Workflow Documents
app.put('/api/rewards/:id', async (c) => {
  try {
    const id = c.req.param('id');
    const body = await c.req.json();

    const {
      status,
      currentStep,
      internalDocNo,
      researchDocRecNo,
      financeDocRecNo,
      disbursementVoucherNo,
      blueSlipNo,
      budgetExpenseCode,
      actualPaidAmount,
      paymentStatus,
      paymentDate,
      paymentTransferSlipUrl,
      coordinatorNotes,
      timeline,
      attachments
    } = body;

    let updates: string[] = ["updatedAt = datetime('now')"];
    const params: any[] = [];

    if (status !== undefined) { updates.push('status = ?'); params.push(status); }
    if (currentStep !== undefined) { updates.push('currentStep = ?'); params.push(currentStep); }
    if (internalDocNo !== undefined) { updates.push('internalDocNo = ?'); params.push(internalDocNo); }
    if (researchDocRecNo !== undefined) { updates.push('researchDocRecNo = ?'); params.push(researchDocRecNo); }
    if (financeDocRecNo !== undefined) { updates.push('financeDocRecNo = ?'); params.push(financeDocRecNo); }
    if (disbursementVoucherNo !== undefined) { updates.push('disbursementVoucherNo = ?'); params.push(disbursementVoucherNo); }
    if (blueSlipNo !== undefined) { updates.push('blueSlipNo = ?'); params.push(blueSlipNo); }
    if (budgetExpenseCode !== undefined) { updates.push('budgetExpenseCode = ?'); params.push(budgetExpenseCode); }
    if (actualPaidAmount !== undefined) { updates.push('actualPaidAmount = ?'); params.push(actualPaidAmount); }
    if (paymentStatus !== undefined) { updates.push('paymentStatus = ?'); params.push(paymentStatus); }
    if (paymentDate !== undefined) { updates.push('paymentDate = ?'); params.push(paymentDate); }
    if (paymentTransferSlipUrl !== undefined) { updates.push('paymentTransferSlipUrl = ?'); params.push(paymentTransferSlipUrl); }
    if (coordinatorNotes !== undefined) { updates.push('coordinatorNotes = ?'); params.push(coordinatorNotes); }
    if (timeline !== undefined) { updates.push('timelineJson = ?'); params.push(JSON.stringify(timeline)); }
    if (attachments !== undefined) { updates.push('attachmentsJson = ?'); params.push(JSON.stringify(attachments)); }

    params.push(id);
    const sql = `UPDATE irRewardApplication SET ${updates.join(', ')} WHERE id = ?`;
    await c.env.DB.prepare(sql).bind(...params).run();

    return c.json({ status: 'updated', id });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// 5. Delete Application
app.delete('/api/rewards/:id', async (c) => {
  try {
    const id = c.req.param('id');
    await c.env.DB.prepare(`DELETE FROM irRewardApplication WHERE id = ?`).bind(id).run();
    return c.json({ status: 'deleted', id });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// === REWARD USER REGISTRY & PROFILE ENDPOINTS ===

function normalizeRole(roleStr?: string): 'researcher' | 'coordinator' | 'finance' | 'executive' | 'admin' {
  if (!roleStr) return 'researcher';
  const r = roleStr.toLowerCase().trim();
  if (r === 'admin') return 'admin';
  if (r === 'coordinator' || r === 'staff') return 'coordinator';
  if (r === 'finance') return 'finance';
  if (r === 'executive') return 'executive';
  return 'researcher';
}

function parseRoles(rolesJson?: string | null, primaryRole?: string): ('researcher' | 'coordinator' | 'finance' | 'executive' | 'admin')[] {
  const normPrimary = normalizeRole(primaryRole);
  if (rolesJson) {
    try {
      const parsed = JSON.parse(rolesJson);
      if (Array.isArray(parsed) && parsed.length > 0) {
        return parsed.map((x: string) => normalizeRole(x));
      }
    } catch (e) {}
  }
  return [normPrimary];
}

// 1. Get All Users (for Admin Console & Profile Selectors)
app.get('/api/users', async (c) => {
  try {
    const { results } = await c.env.DB.prepare(`
      SELECT 
        u.id, 
        u.name, 
        u.email, 
        u.role, 
        u.title, 
        u.firstName, 
        u.lastName, 
        u.titleTh,
        u.firstNameTh,
        u.lastNameTh,
        u.titleEn,
        u.firstNameEn,
        u.lastNameEn,
        u.shortNameEn,
        u.aliasesJson,
        u.employeeId, 
        u.phone, 
        u.bankName, 
        u.bankAccountNo, 
        u.idCardNo, 
        u.academicPosition, 
        u.administrativePosition, 
        u.rolesJson, 
        u.lastLoginAt, 
        u.isDeleted,
        COALESCE(u.department, p.department, 'คณะแพทยศาสตร์ มหาวิทยาลัยนเรศวร') as department,
        COALESCE(u.scopusAuthorId, p.scopusAuthorId) as scopusAuthorId,
        COALESCE(u.orcid, p.orcid) as orcid,
        COALESCE(p.status, 'active') as status
      FROM irUser u
      LEFT JOIN irResearcherProfile p ON u.id = p.userId
      WHERE u.isDeleted = 0 OR u.isDeleted IS NULL
      ORDER BY 
        CASE 
          WHEN LOWER(u.role) = 'admin' THEN 1
          WHEN LOWER(u.role) = 'coordinator' OR LOWER(u.role) = 'staff' THEN 2
          WHEN LOWER(u.role) = 'finance' THEN 3
          WHEN LOWER(u.role) = 'executive' THEN 4
          ELSE 5
        END,
        u.name ASC
    `).all();

    const users = (results || []).map((row: any) => {
      const primaryRole = normalizeRole(row.role);
      const roles = parseRoles(row.rolesJson, primaryRole);
      return {
        id: row.id,
        name: row.name,
        titleTh: row.titleTh || undefined,
        firstNameTh: row.firstNameTh || undefined,
        lastNameTh: row.lastNameTh || undefined,
        titleEn: row.titleEn || undefined,
        firstNameEn: row.firstNameEn || undefined,
        lastNameEn: row.lastNameEn || undefined,
        shortNameEn: row.shortNameEn || undefined,
        aliases: row.aliasesJson ? JSON.parse(row.aliasesJson) : [],
        academicPosition: row.academicPosition || row.titleTh || row.title || 'อาจารย์ / นักวิจัย',
        administrativePosition: row.administrativePosition || '',
        department: row.department || 'คณะแพทยศาสตร์ มหาวิทยาลัยนเรศวร',
        scopusAuthorId: row.scopusAuthorId || undefined,
        orcid: row.orcid || undefined,
        phone: row.phone || '',
        email: row.email,
        bankName: row.bankName || 'ธนาคารกรุงศรีอยุธยา สาขามหาวิทยาลัยนเรศวร',
        bankAccountNo: row.bankAccountNo || '',
        idCardNo: row.idCardNo || '',
        role: primaryRole,
        roles: roles,
        isNuAccount: row.email?.toLowerCase().endsWith('@nu.ac.th') ?? true,
        status: (row.status === 'suspended' ? 'suspended' : 'active'),
        lastLoginAt: row.lastLoginAt || undefined,
        createdAt: row.createdAt || undefined,
      };
    });

    c.header('Cache-Control', 'no-cache, no-store, must-revalidate');
    return c.json(users);
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// 2. Get User Profile by Email (e.g. for Google SSO login)
app.get('/api/users/profile/:email', async (c) => {
  try {
    const email = c.req.param('email').trim().toLowerCase();
    const row: any = await c.env.DB.prepare(`
      SELECT 
        u.id, 
        u.name, 
        u.email, 
        u.role, 
        u.title, 
        u.titleTh,
        u.firstNameTh,
        u.lastNameTh,
        u.titleEn,
        u.firstNameEn,
        u.lastNameEn,
        u.shortNameEn,
        u.aliasesJson,
        u.phone, 
        u.bankName, 
        u.bankAccountNo, 
        u.idCardNo, 
        u.academicPosition, 
        u.administrativePosition, 
        u.rolesJson, 
        u.lastLoginAt, 
        COALESCE(u.department, p.department, 'คณะแพทยศาสตร์ มหาวิทยาลัยนเรศวร') as department,
        COALESCE(u.scopusAuthorId, p.scopusAuthorId) as scopusAuthorId,
        COALESCE(u.orcid, p.orcid) as orcid,
        COALESCE(p.status, 'active') as status
      FROM irUser u
      LEFT JOIN irResearcherProfile p ON u.id = p.userId
      WHERE LOWER(u.email) = ?
      LIMIT 1
    `).bind(email).first();

    if (!row) {
      return c.json({ error: 'User not found' }, 404);
    }

    const primaryRole = normalizeRole(row.role);
    const roles = parseRoles(row.rolesJson, primaryRole);

    return c.json({
      id: row.id,
      name: row.name,
      titleTh: row.titleTh || undefined,
      firstNameTh: row.firstNameTh || undefined,
      lastNameTh: row.lastNameTh || undefined,
      titleEn: row.titleEn || undefined,
      firstNameEn: row.firstNameEn || undefined,
      lastNameEn: row.lastNameEn || undefined,
      shortNameEn: row.shortNameEn || undefined,
      aliases: row.aliasesJson ? JSON.parse(row.aliasesJson) : [],
      academicPosition: row.academicPosition || row.titleTh || row.title || 'อาจารย์ / นักวิจัย',
      administrativePosition: row.administrativePosition || '',
      department: row.department || 'คณะแพทยศาสตร์ มหาวิทยาลัยนเรศวร',
      scopusAuthorId: row.scopusAuthorId || undefined,
      orcid: row.orcid || undefined,
      phone: row.phone || '',
      email: row.email,
      bankName: row.bankName || 'ธนาคารกรุงศรีอยุธยา สาขามหาวิทยาลัยนเรศวร',
      bankAccountNo: row.bankAccountNo || '',
      idCardNo: row.idCardNo || '',
      role: primaryRole,
      roles: roles,
      isNuAccount: row.email?.toLowerCase().endsWith('@nu.ac.th') ?? true,
      status: (row.status === 'suspended' ? 'suspended' : 'active'),
      lastLoginAt: row.lastLoginAt || undefined,
    });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// 3. Upsert / Create User
app.post('/api/users', async (c) => {
  try {
    const body = await c.req.json();
    const {
      id = `user-${Date.now()}-${Math.random().toString(36).substring(2, 6)}`,
      name,
      email,
      academicPosition = 'อาจารย์ / นักวิจัย',
      administrativePosition = '',
      department = 'คณะแพทยศาสตร์ มหาวิทยาลัยนเรศวร',
      phone = '',
      bankName = 'ธนาคารกรุงศรีอยุธยา สาขามหาวิทยาลัยนเรศวร',
      bankAccountNo = '',
      idCardNo = '',
      role = 'researcher',
      roles = ['researcher'],
      status = 'active',
      lastLoginAt = new Date().toISOString(),
      titleTh,
      firstNameTh,
      lastNameTh,
      titleEn,
      firstNameEn,
      lastNameEn,
      shortNameEn,
      scopusAuthorId,
      orcid
    } = body;

    if (!email) {
      return c.json({ error: 'Email is required' }, 400);
    }

    const cleanEmail = email.trim().toLowerCase();
    const cleanRole = normalizeRole(role);
    const rolesJson = JSON.stringify(roles || [cleanRole]);

    // Check existing
    const existing: any = await c.env.DB.prepare('SELECT * FROM irUser WHERE LOWER(email) = ?').bind(cleanEmail).first();
    const userId = existing ? existing.id : id;

    let computedShortName = shortNameEn;
    if (!computedShortName && lastNameEn && firstNameEn) {
      computedShortName = `${lastNameEn.trim()} ${firstNameEn.trim()[0].toUpperCase()}.`;
    }

    if (existing) {
      await c.env.DB.prepare(`
        UPDATE irUser SET
          name = COALESCE(?, name),
          titleTh = COALESCE(?, titleTh),
          firstNameTh = COALESCE(?, firstNameTh),
          lastNameTh = COALESCE(?, lastNameTh),
          titleEn = COALESCE(?, titleEn),
          firstNameEn = COALESCE(?, firstNameEn),
          lastNameEn = COALESCE(?, lastNameEn),
          shortNameEn = COALESCE(?, shortNameEn),
          academicPosition = ?,
          administrativePosition = ?,
          department = COALESCE(?, department),
          scopusAuthorId = COALESCE(?, scopusAuthorId),
          orcid = COALESCE(?, orcid),
          phone = ?,
          bankName = ?,
          bankAccountNo = ?,
          idCardNo = ?,
          role = ?,
          rolesJson = ?,
          lastLoginAt = COALESCE(?, lastLoginAt)
        WHERE id = ?
      `).bind(
        name ?? null,
        titleTh ?? null,
        firstNameTh ?? null,
        lastNameTh ?? null,
        titleEn ?? null,
        firstNameEn ?? null,
        lastNameEn ?? null,
        computedShortName ?? null,
        academicPosition,
        administrativePosition,
        department,
        scopusAuthorId ?? null,
        orcid ?? null,
        phone,
        bankName,
        bankAccountNo,
        idCardNo,
        cleanRole,
        rolesJson,
        lastLoginAt,
        userId
      ).run();
    } else {
      await c.env.DB.prepare(`
        INSERT INTO irUser (
          id, name, email, role, academicPosition, administrativePosition, phone,
          bankName, bankAccountNo, idCardNo, rolesJson, lastLoginAt, isDeleted,
          titleTh, firstNameTh, lastNameTh, titleEn, firstNameEn, lastNameEn,
          shortNameEn, department, scopusAuthorId, orcid
        ) VALUES (
          ?, ?, ?, ?, ?, ?, ?,
          ?, ?, ?, ?, ?, 0,
          ?, ?, ?, ?, ?, ?,
          ?, ?, ?, ?
        )
      `).bind(
        userId,
        name || cleanEmail.split('@')[0],
        cleanEmail,
        cleanRole,
        academicPosition,
        administrativePosition,
        phone,
        bankName,
        bankAccountNo,
        idCardNo,
        rolesJson,
        lastLoginAt,
        titleTh ?? null,
        firstNameTh ?? null,
        lastNameTh ?? null,
        titleEn ?? null,
        firstNameEn ?? null,
        lastNameEn ?? null,
        computedShortName ?? null,
        department,
        scopusAuthorId ?? null,
        orcid ?? null
      ).run();
    }

    return c.json({ status: 'success', id: userId, email: cleanEmail });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// 4. Update User Profile by ID (with Progression & Audit History Logging)
app.put('/api/users/profile/:id', async (c) => {
  try {
    const id = c.req.param('id');
    const body = await c.req.json();
    const {
      name,
      titleTh,
      firstNameTh,
      lastNameTh,
      titleEn,
      firstNameEn,
      lastNameEn,
      shortNameEn,
      academicPosition,
      administrativePosition,
      department,
      scopusAuthorId,
      orcid,
      phone,
      bankName,
      bankAccountNo,
      idCardNo,
      role,
      roles,
      status,
      lastLoginAt,
      effectiveDate = new Date().toISOString().split('T')[0],
      changeReason = 'การปรับปรุงข้อมูลประวัติ/การเลื่อนตำแหน่งทางวิชาการ'
    } = body;

    // Fetch existing user to detect promotions and changes
    const existing: any = await c.env.DB.prepare('SELECT * FROM irUser WHERE id = ?').bind(id).first();
    if (!existing) {
      return c.json({ error: 'User not found' }, 404);
    }

    // 1. Audit Log: Academic Position Promotion (ผศ. -> รศ. -> ศ.)
    if (academicPosition !== undefined && existing.academicPosition && existing.academicPosition !== academicPosition) {
      const historyId = crypto.randomUUID();
      await c.env.DB.prepare(`
        INSERT INTO irResearcherProfileHistory (id, userId, changedField, oldValue, newValue, effectiveDate, reason)
        VALUES (?, ?, 'academicPosition', ?, ?, ?, ?)
      `).bind(historyId, id, existing.academicPosition, academicPosition, effectiveDate, changeReason).run();
    }

    // 2. Audit Log: Title Change
    if (titleTh !== undefined && existing.titleTh && existing.titleTh !== titleTh) {
      const historyId = crypto.randomUUID();
      await c.env.DB.prepare(`
        INSERT INTO irResearcherProfileHistory (id, userId, changedField, oldValue, newValue, effectiveDate, reason)
        VALUES (?, ?, 'titleTh', ?, ?, ?, ?)
      `).bind(historyId, id, existing.titleTh, titleTh, effectiveDate, changeReason).run();
    }

    // 3. Audit Log: Name/Surname Change & Short Name Alias Preservation
    let aliases = [];
    try {
      if (existing.aliasesJson) aliases = JSON.parse(existing.aliasesJson);
    } catch (e) {}

    let computedShortName = shortNameEn !== undefined ? shortNameEn : existing.shortNameEn;
    const finalFirstEn = firstNameEn !== undefined ? firstNameEn : existing.firstNameEn;
    const finalLastEn = lastNameEn !== undefined ? lastNameEn : existing.lastNameEn;
    if (finalFirstEn && finalLastEn) {
      const newCalc = `${finalLastEn.trim()} ${finalFirstEn.trim()[0].toUpperCase()}.`;
      if (shortNameEn === undefined) {
        computedShortName = newCalc;
      }
    }

    if (existing.shortNameEn && computedShortName && existing.shortNameEn !== computedShortName) {
      // Archive old shortName into aliasesJson
      if (!aliases.some((a: any) => a.shortName === existing.shortNameEn)) {
        aliases.push({ shortName: existing.shortNameEn, type: 'former_name', archivedAt: effectiveDate });
      }
    }

    const updates: string[] = ["updatedAt = datetime('now')"];
    const params: any[] = [];

    if (name !== undefined) { updates.push('name = ?'); params.push(name); }
    if (titleTh !== undefined) { updates.push('titleTh = ?'); params.push(titleTh); }
    if (firstNameTh !== undefined) { updates.push('firstNameTh = ?'); params.push(firstNameTh); }
    if (lastNameTh !== undefined) { updates.push('lastNameTh = ?'); params.push(lastNameTh); }
    if (titleEn !== undefined) { updates.push('titleEn = ?'); params.push(titleEn); }
    if (firstNameEn !== undefined) { updates.push('firstNameEn = ?'); params.push(firstNameEn); }
    if (lastNameEn !== undefined) { updates.push('lastNameEn = ?'); params.push(lastNameEn); }
    if (computedShortName !== undefined) { updates.push('shortNameEn = ?'); params.push(computedShortName); }
    if (aliases.length > 0) { updates.push('aliasesJson = ?'); params.push(JSON.stringify(aliases)); }
    if (academicPosition !== undefined) { updates.push('academicPosition = ?'); params.push(academicPosition); }
    if (administrativePosition !== undefined) { updates.push('administrativePosition = ?'); params.push(administrativePosition); }
    if (department !== undefined) { updates.push('department = ?'); params.push(department); }
    if (scopusAuthorId !== undefined) { updates.push('scopusAuthorId = ?'); params.push(scopusAuthorId); }
    if (orcid !== undefined) { updates.push('orcid = ?'); params.push(orcid); }
    if (phone !== undefined) { updates.push('phone = ?'); params.push(phone); }
    if (bankName !== undefined) { updates.push('bankName = ?'); params.push(bankName); }
    if (bankAccountNo !== undefined) { updates.push('bankAccountNo = ?'); params.push(bankAccountNo); }
    if (idCardNo !== undefined) { updates.push('idCardNo = ?'); params.push(idCardNo); }
    if (role !== undefined) { updates.push('role = ?'); params.push(normalizeRole(role)); }
    if (roles !== undefined) { updates.push('rolesJson = ?'); params.push(JSON.stringify(roles)); }
    if (lastLoginAt !== undefined) { updates.push('lastLoginAt = ?'); params.push(lastLoginAt); }

    params.push(id);
    await c.env.DB.prepare(`UPDATE irUser SET ${updates.join(', ')} WHERE id = ?`).bind(...params).run();

    return c.json({ status: 'updated', id, shortNameEn: computedShortName });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

// 5. Admin: Consolidate Researcher Profiles into irUser (Zero CLI Timeout)
app.post('/api/admin/consolidate-users', async (c) => {
  try {
    const { results: users } = await c.env.DB.prepare(`
      SELECT u.id, u.name, u.email, u.title, u.firstName, u.lastName, u.academicPosition,
             p.nameTh, p.titleTh, p.firstNameTh, p.lastNameTh, p.titleEn, p.firstNameEn, p.lastNameEn,
             p.shortNameEn, p.department, p.scopusAuthorId, p.orcid, p.wosResearcherId
      FROM irUser u
      LEFT JOIN irResearcherProfile p ON u.id = p.userId
    `).all();

    const THAI_TITLES = [
      'ศ.ดร.นพ.', 'ศ.ดร.พญ.', 'ศ.ดร.', 'ศ.นพ.', 'ศ.พญ.', 'ศ.',
      'รศ.ดร.นพ.', 'รศ.ดร.พญ.', 'รศ.ดร.', 'รศ.นพ.', 'รศ.พญ.', 'รศ.',
      'ผศ.ดร.นพ.', 'ผศ.ดร.พญ.', 'ผศ.ดร.', 'ผศ.นพ.', 'ผศ.พญ.', 'ผศ.',
      'อ.ดร.นพ.', 'อ.ดร.', 'อ.นพ.', 'อ.พญ.', 'อาจารย์ แพทย์หญิง', 'อาจารย์ นายแพทย์', 'อาจารย์',
      'ผู้ช่วยศาสตราจารย์ แพทย์หญิง', 'ผู้ช่วยศาสตราจารย์ นายแพทย์', 'ผู้ช่วยศาสตราจารย์ ดร.', 'ผู้ช่วยศาสตราจารย์',
      'รองศาสตราจารย์ แพทย์หญิง', 'รองศาสตราจารย์ นายแพทย์', 'รองศาสตราจารย์ ดร.', 'รองศาสตราจารย์',
      'ศาสตราจารย์ แพทย์หญิง', 'ศาสตราจารย์ นายแพทย์', 'ศาสตราจารย์ ดร.', 'ศาสตราจารย์',
      'นายแพทย์', 'แพทย์หญิง', 'นพ.', 'พญ.', 'ดร.', 'นาย', 'นางสาว', 'นาง'
    ];

    const ENG_TITLES = [
      'Assoc. Prof. Dr.', 'Asst. Prof. Dr.', 'Prof. Dr.', 'Assoc. Prof.', 'Asst. Prof.', 'Prof.',
      'Dr.', 'MD', 'Ph.D.', 'Mr.', 'Mrs.', 'Miss', 'Ms.'
    ];

    const isThai = (t: string) => /[\u0E00-\u0E7F]/.test(t || '');
    const clean = (s: any) => (s || '').toString().trim();

    const statements = [];
    const samples = [];

    for (const row of (users || [])) {
      let {
        id, name, title, academicPosition,
        nameTh, titleTh, firstNameTh, lastNameTh,
        titleEn, firstNameEn, lastNameEn, shortNameEn,
        department, scopusAuthorId, orcid, wosResearcherId
      } = row as any;

      // 1. Thai
      let finalTitleTh = clean(titleTh);
      let finalFirstNameTh = clean(firstNameTh);
      let finalLastNameTh = clean(lastNameTh);

      let rawTh = clean(nameTh);
      if (!rawTh && isThai(name)) rawTh = clean(name);

      if (rawTh) {
        for (const t of THAI_TITLES) {
          if (rawTh.startsWith(t)) {
            if (!finalTitleTh) finalTitleTh = t;
            rawTh = rawTh.slice(t.length).trim();
            break;
          }
        }
        const parts = rawTh.split(/\s+/).filter(Boolean);
        if (!finalFirstNameTh && parts.length > 0) finalFirstNameTh = parts[0];
        if (!finalLastNameTh && parts.length > 1) finalLastNameTh = parts.slice(1).join(' ');
      }

      // 2. English
      let finalTitleEn = clean(titleEn);
      let finalFirstNameEn = clean(firstNameEn);
      let finalLastNameEn = clean(lastNameEn);

      let rawEn = clean(name);
      if (!isThai(rawEn)) {
        for (const t of ENG_TITLES) {
          if (rawEn.startsWith(t)) {
            if (!finalTitleEn) finalTitleEn = t;
            rawEn = rawEn.slice(t.length).trim();
            break;
          }
        }
        const parts = rawEn.split(/\s+/).filter(Boolean);
        if (!finalFirstNameEn && parts.length > 0) finalFirstNameEn = parts[0];
        if (!finalLastNameEn && parts.length > 1) finalLastNameEn = parts.slice(1).join(' ');
      }

      // 3. Fallback titleTh
      if (!finalTitleTh) {
        if (academicPosition) {
          if (academicPosition.includes('ศาสตราจารย์')) finalTitleTh = 'ศ.';
          else if (academicPosition.includes('รองศาสตราจารย์')) finalTitleTh = 'รศ.';
          else if (academicPosition.includes('ผู้ช่วยศาสตราจารย์')) finalTitleTh = 'ผศ.';
          else if (academicPosition.includes('อาจารย์')) finalTitleTh = 'อ.';
        } else if (title) {
          finalTitleTh = title;
        }
      }

      // 4. shortNameEn: [LastName] [FirstInitial].
      let finalShortNameEn = clean(shortNameEn);
      if (!finalShortNameEn && finalLastNameEn && finalFirstNameEn) {
        finalShortNameEn = `${finalLastNameEn} ${finalFirstNameEn[0].toUpperCase()}.`;
      }

      const finalDept = clean(department) || 'คณะแพทยศาสตร์ มหาวิทยาลัยนเรศวร';
      const finalScopus = clean(scopusAuthorId) || null;
      const finalOrcid = clean(orcid) || null;
      const finalWos = clean(wosResearcherId) || null;

      const aliases = finalShortNameEn ? [{ shortName: finalShortNameEn, type: 'primary' }] : [];

      statements.push(c.env.DB.prepare(`
        UPDATE irUser SET
          titleTh = ?,
          firstNameTh = ?,
          lastNameTh = ?,
          titleEn = ?,
          firstNameEn = ?,
          lastNameEn = ?,
          shortNameEn = ?,
          department = ?,
          scopusAuthorId = ?,
          orcid = ?,
          wosResearcherId = ?,
          aliasesJson = ?
        WHERE id = ?
      `).bind(
        finalTitleTh || null,
        finalFirstNameTh || null,
        finalLastNameTh || null,
        finalTitleEn || null,
        finalFirstNameEn || null,
        finalLastNameEn || null,
        finalShortNameEn || null,
        finalDept,
        finalScopus,
        finalOrcid,
        finalWos,
        JSON.stringify(aliases),
        id
      ));

      if (samples.length < 5 && finalShortNameEn) {
        samples.push({
          id,
          nameTh: `${finalTitleTh || ''} ${finalFirstNameTh || ''} ${finalLastNameTh || ''}`.trim(),
          nameEn: `${finalFirstNameEn || ''} ${finalLastNameEn || ''}`.trim(),
          shortNameEn: finalShortNameEn,
          department: finalDept
        });
      }
    }

    // Execute in chunks of 50 in Cloudflare D1
    const CHUNK_SIZE = 50;
    for (let i = 0; i < statements.length; i += CHUNK_SIZE) {
      const chunk = statements.slice(i, i + CHUNK_SIZE);
      await c.env.DB.batch(chunk);
    }

    return c.json({
      status: 'success',
      totalConsolidated: statements.length,
      samples
    });
  } catch (e: any) {
    return c.json({ error: e.message }, 500);
  }
});

export default app;
