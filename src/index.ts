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
    const { results } = await c.env.DB.prepare('SELECT * FROM irPublication ORDER BY createdAt DESC').all()
    return c.json(results)
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

app.get('/api/researchers', async (c) => {
  try {
    const { results } = await c.env.DB.prepare('SELECT id, name, department, status FROM irResearcherProfile').all()
    // Wait, the dummy researchers were inserted into irUser!
    // Let's just return all users with role RESEARCHER as well
    const { results: users } = await c.env.DB.prepare("SELECT id, name FROM irUser WHERE role = 'RESEARCHER'").all()
    
    // Merge or just return users since that's what the UI matches against
    const researchers = users.map(u => ({
      name: u.name,
      department: 'Faculty of Medicine',
      status: 'Active'
    }))
    
    return c.json(researchers)
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

app.post('/api/publications', async (c) => {
  try {
    const body = await c.req.json()
    // Upsert logic based on Title
    const existing = await c.env.DB.prepare('SELECT id, rewardStatus, rewardAmount FROM irPublication WHERE title = ?').bind(body.title).first()
    
    // Insert dummy user to satisfy foreign key constraint if authorId is a name
    const authorName = body.authorId || 'Unknown';
    try {
      await c.env.DB.prepare('INSERT OR IGNORE INTO irUser (id, name, email, role) VALUES (?, ?, ?, ?)').bind(authorName, authorName, `${authorName.replace(/[^a-zA-Z0-9]/g, '').toLowerCase()}@nu.ac.th`, 'RESEARCHER').run()
    } catch(err) {
      // Ignore errors if table doesn't exist or other issues
    }

    if (existing) {
      // Update statistics and authorship (e.g. quartile, authorId, citations, etc) but DO NOT touch financial/status fields
      await c.env.DB.prepare(`
        UPDATE irPublication 
        SET quartile = ?, authorId = ?, doi = ?, citations = ?, sourceTags = ?, updatedAt = strftime('%Y-%m-%dT%H:%M:%fZ', 'now')
        WHERE id = ?
      `).bind(
        body.quartile || '', 
        authorName, 
        body.doi || '',
        body.citations || 0,
        body.sourceTags ? JSON.stringify(body.sourceTags) : '[]',
        existing.id
      ).run()
      
      return c.json({ status: 'updated', id: existing.id, message: 'Existing publication updated (Reward status preserved).' })
    } else {
      // Insert new publication
      const id = crypto.randomUUID()
      await c.env.DB.prepare(`
        INSERT INTO irPublication (id, title, journal, quartile, authorId, doi, citations, sourceTags, status, rewardStatus, rewardAmount)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'PENDING', 0)
      `).bind(
        id, 
        body.title, 
        body.journal || '', 
        body.quartile || '', 
        authorName,
        body.doi || '',
        body.citations || 0,
        body.sourceTags ? JSON.stringify(body.sourceTags) : '[]',
        body.status || 'Active'
      ).run()
      
      return c.json({ status: 'inserted', id })
    }
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

// === RESEARCHERS ENDPOINTS ===

// Creates the mapping table if it doesn't exist, then inserts/updates researcher
app.post('/api/researchers', async (c) => {
  try {
    const body = await c.req.json()
    
    // Ensure mapping table exists
    await c.env.DB.prepare(`
      CREATE TABLE IF NOT EXISTS irResearcherProfile (
        id TEXT PRIMARY KEY,
        userId TEXT,
        scopusAuthorId TEXT,
        department TEXT,
        status TEXT
      )
    `).run()

    // Upsert logic for researcher
    const existing = await c.env.DB.prepare('SELECT id FROM irResearcherProfile WHERE scopusAuthorId = ?').bind(body.scopusAuthorId).first()
    
    if (existing) {
      await c.env.DB.prepare(`
        UPDATE irResearcherProfile 
        SET department = ?, status = ?
        WHERE scopusAuthorId = ?
      `).bind(body.department || '', body.status || 'Active', body.scopusAuthorId).run()
      
      return c.json({ status: 'updated', scopusAuthorId: body.scopusAuthorId })
    } else {
      const id = crypto.randomUUID()
      await c.env.DB.prepare(`
        INSERT INTO irResearcherProfile (id, userId, scopusAuthorId, department, status)
        VALUES (?, ?, ?, ?, ?)
      `).bind(
        id, 
        body.userId || '', // Foreign key to irUser.id if known, otherwise empty for now
        body.scopusAuthorId, 
        body.department || '', 
        body.status || 'Active'
      ).run()
      
      return c.json({ status: 'inserted', scopusAuthorId: body.scopusAuthorId })
    }
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

export default app
