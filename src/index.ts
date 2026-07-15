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
    const { results } = await c.env.DB.prepare('SELECT * FROM irPublication ORDER BY createdAt DESC LIMIT 100').all()
    return c.json(results)
  } catch (e: any) {
    return c.json({ error: e.message }, 500)
  }
})

app.post('/api/publications', async (c) => {
  try {
    const body = await c.req.json()
    // Upsert logic based on Title
    const existing = await c.env.DB.prepare('SELECT id, rewardStatus, rewardAmount FROM irPublication WHERE title = ?').bind(body.title).first()
    
    if (existing) {
      // Update statistics and authorship (e.g. quartile, authorId) but DO NOT touch financial/status fields
      await c.env.DB.prepare(`
        UPDATE irPublication 
        SET quartile = ?, authorId = ?, updatedAt = strftime('%Y-%m-%dT%H:%M:%fZ', 'now')
        WHERE id = ?
      `).bind(body.quartile || '', body.authorId || '', existing.id).run()
      
      return c.json({ status: 'updated', id: existing.id, message: 'Existing publication updated (Reward status preserved).' })
    } else {
      // Insert new publication
      const id = crypto.randomUUID()
      await c.env.DB.prepare(`
        INSERT INTO irPublication (id, title, journal, quartile, authorId, status, rewardStatus, rewardAmount)
        VALUES (?, ?, ?, ?, ?, ?, 'PENDING', 0)
      `).bind(
        id, 
        body.title, 
        body.journal || '', 
        body.quartile || '', 
        body.authorId || '',
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
