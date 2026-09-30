path = r'D:\.gemini\antigravity\scratch\iram-services\src\lib\apiDb.ts'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

old_loop = """        for (const field of profileFields) {
          if (data[field] !== undefined && isDifferent(data[field], current[field])) {
            updates.push(`"${field}" = $${pIndex}`);
            params.push(data[field] || null);
            pIndex++;
            
            // Record history log
            // Resolve recordedBy to a valid UUID or null to satisfy SQLite FK constraints
            const recorderId = (performedBy && performedBy !== 'admin' && performedBy !== 'system') ? performedBy : null;
            await dbQuery(
              'INSERT INTO "irResearcherProfileHistory" (id, userId, changedField, oldValue, newValue, effectiveDate, recordedBy, reason) VALUES ($1, $2, $3, $4, $5, date(\\'now\\'), $6, $7)',
              [crypto.randomUUID(), id, field, String(current[field] || ''), String(data[field] || ''), recorderId, data.changeReason || 'Profile update']
            );
            profileUpdated = true;
          }
        }"""

new_loop = """        for (const field of profileFields) {
          let fieldDifferent = isDifferent(data[field], current[field]);

          // Fallback logic to prevent logging initial sync from base irUser fields
          if (field === 'titleEn' && !current.titleEn && !isDifferent(data.titleEn, current.title)) {
            fieldDifferent = false;
          }
          if (field === 'firstNameEn' && !current.firstNameEn && !isDifferent(data.firstNameEn, current.firstName)) {
            fieldDifferent = false;
          }
          if (field === 'lastNameEn' && !current.lastNameEn && !isDifferent(data.lastNameEn, current.lastName)) {
            fieldDifferent = false;
          }

          if (data[field] !== undefined && fieldDifferent) {
            updates.push(`"${field}" = $${pIndex}`);
            params.push(data[field] || null);
            pIndex++;
            
            // Record history log
            // Resolve recordedBy to a valid UUID or null to satisfy SQLite FK constraints
            const recorderId = (performedBy && performedBy !== 'admin' && performedBy !== 'system') ? performedBy : null;
            await dbQuery(
              'INSERT INTO "irResearcherProfileHistory" (id, userId, changedField, oldValue, newValue, effectiveDate, recordedBy, reason) VALUES ($1, $2, $3, $4, $5, date(\\'now\\'), $6, $7)',
              [crypto.randomUUID(), id, field, String(current[field] || ''), String(data[field] || ''), recorderId, data.changeReason || 'Profile update']
            );
            profileUpdated = true;
          }
        }"""

content = content.replace(old_loop, new_loop)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print("apiDb.ts fallback logs condition patched successfully!")
