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
             (SELECT json_group_array(json_object('name', a.authorName, 'isCorresponding', a.isCorresponding))
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
    const { doi, title, journal, year, coverDate, quartile, status, authors } = body

    // 1. Duplicate Check
    const existing = await c.env.DB.prepare('SELECT id FROM irPublication WHERE doi = ? OR title = ?').bind(doi || null, title).first()
    
    if (existing) {
      // Update year and coverDate if missing for existing publication
      if (year || coverDate) {
        await c.env.DB.prepare('UPDATE irPublication SET year = COALESCE(?, year), coverDate = COALESCE(?, coverDate) WHERE id = ?').bind(year || null, coverDate || null, existing.id).run()
      }
      return c.json({ status: 'skipped', id: existing.id, message: 'Publication already exists, updated year/coverDate if provided' })
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
      INSERT INTO irPublication (id, doi, title, journal, year, coverDate, quartile, uniRewardStatus, uniRewardAmount, facultyRewardStatus, facultyRewardAmount, status, projectId, claimingAuthorId)
      VALUES (?, ?, ?, ?, ?, ?, ?, 'PENDING', 0, 'PENDING', 0, ?, NULL, ?)
    `).bind(pubId, doi || null, title, journal || '', year || null, coverDate || null, quartile || '', status || 'PUBLISHED', claimingAuthorId).run()

    // 4. Insert into irPublicationAuthor
    for (const auth of authorsWithUserId) {
      const authId = crypto.randomUUID()
      await c.env.DB.prepare(`
        INSERT INTO irPublicationAuthor (id, publicationId, authorName, userId, authorOrder, isCorresponding)
        VALUES (?, ?, ?, ?, ?, ?)
      `).bind(authId, pubId, auth.name, auth.userId, auth.order, auth.isCorresponding ? 1 : 0).run()
    }

    return c.json({ status: 'inserted', id: pubId, claimingAuthorId })
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

// === RESEARCHERS ENDPOINTS ===

app.get('/api/researchers', async (c) => {
  try {
    const { results: researchers } = await c.env.DB.prepare(`
      SELECT 
        u.id, 
        u.name, 
        COALESCE(p.department, 'Faculty of Medicine') as department,
        COALESCE(p.status, 'Active') as status,
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

export default app
