import re

path = r'D:\.gemini\antigravity\scratch\iram-services\src\lib\apiDb.ts'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace performedBy || 'admin' with a check that uses a valid user ID or null for recordedBy
old_history_insert = """            await dbQuery(
              'INSERT INTO "irResearcherProfileHistory" (id, userId, changedField, oldValue, newValue, effectiveDate, recordedBy, reason) VALUES ($1, $2, $3, $4, $5, date(\\'now\\'), $6, $7)',
              [crypto.randomUUID(), id, field, String(current[field] || ''), String(data[field] || ''), performedBy || 'admin', data.changeReason || 'Profile update']
            );"""

new_history_insert = """            // Resolve recordedBy to a valid UUID or null to satisfy SQLite FK constraints
            const recorderId = (performedBy && performedBy !== 'admin' && performedBy !== 'system') ? performedBy : null;
            await dbQuery(
              'INSERT INTO "irResearcherProfileHistory" (id, userId, changedField, oldValue, newValue, effectiveDate, recordedBy, reason) VALUES ($1, $2, $3, $4, $5, date(\\'now\\'), $6, $7)',
              [crypto.randomUUID(), id, field, String(current[field] || ''), String(data[field] || ''), recorderId, data.changeReason || 'Profile update']
            );"""

content = content.replace(old_history_insert, new_history_insert)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print("apiDb.ts history FK constraint fixed successfully!")
