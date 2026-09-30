path = r'D:\.gemini\antigravity\scratch\iram-services\src\lib\apiDb.ts'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Let's locate the entire update function block in users: { ... }
# We want to replace everything from "update: async (id: string, data: any, performedBy?: string | null) => {"
# up to "delete: async (id: string, performedBy?: string | null) => {"

old_update_function = """    update: async (id: string, data: any, performedBy?: string | null) => {
      const current = await realDbHandlers.users.findUnique(id);
      if (!current) throw new Error('User not found');
      
      const role = data.role !== undefined ? data.role : current.role;

      // 1. Build dynamic UPDATE for irUser
      const userFields = ['email', 'role', 'title', 'firstName', 'lastName', 'employeeId'];
      const userUpdates = [];
      const userParams = [];
      let uIndex = 1;

      // Handle name concatenation if any name part changed
      const title = data.title !== undefined ? data.title : current.title;
      const firstName = data.firstName !== undefined ? data.firstName : current.firstName;
      const lastName = data.lastName !== undefined ? data.lastName : current.lastName;
      const newName = `${title || ''} ${firstName || ''} ${lastName || ''}`.trim().replace(/\\s+/, ' ');
      
      if (newName !== current.name) {
        userUpdates.push(`"name" = $${uIndex}`);
        userParams.push(newName);
        uIndex++;
      }

      for (const field of userFields) {
        if (data[field] !== undefined && isDifferent(data[field], current[field])) {
          userUpdates.push(`"${field}" = $${uIndex}`);
          userParams.push(data[field] || null);
          uIndex++;
        }
      }

      const isDeleted = data.isDeleted !== undefined ? (data.isDeleted ? 1 : 0) : (current.isDeleted ? 1 : 0);
      const currentIsDeletedNum = current.isDeleted ? 1 : 0;
      if (isDeleted !== currentIsDeletedNum) {
        userUpdates.push(`"isDeleted" = $${uIndex}`);
        userParams.push(isDeleted);
        uIndex++;
      }

      if (userUpdates.length > 0) {
        userUpdates.push(`"updatedAt" = CURRENT_TIMESTAMP`);
        userParams.push(id);
        await dbQuery(
          `UPDATE "irUser" SET ${userUpdates.join(', ')} WHERE id = $${uIndex}`,
          userParams
        );
      }

      // Check if profile details changed and write to irResearcherProfile History
      const profileFields = ['titleTh', 'firstNameTh', 'lastNameTh', 'titleEn', 'firstNameEn', 'lastNameEn', 'orcid', 'scopusAuthorId', 'wosResearcherId', 'shortNameEn'];
      let profileUpdated = false;
      
      // Check if profile exists
      const profileCheck = await dbQuery('SELECT id FROM "irResearcherProfile" WHERE userId = $1', [id]);
      const hasProfile = profileCheck.rows.length > 0;
      
      if (hasProfile) {
        // Build update statement dynamically
        const updates = [];
        const params = [];
        let pIndex = 1;
        for (const field of profileFields) {
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
        }
        if (updates.length > 0) {
          params.push(id);
          await dbQuery(`UPDATE "irResearcherProfile" SET ${updates.join(', ')} WHERE userId = $${pIndex}`, params);
        }
      } else if (role === 'RESEARCHER') {
        // Create profile if it didn't exist
        const profileId = crypto.randomUUID();
        await dbQuery(
          'INSERT INTO "irResearcherProfile" (id, userId, orcid, scopusAuthorId, wosResearcherId, titleTh, firstNameTh, lastNameTh, titleEn, firstNameEn, lastNameEn, shortNameEn) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)',
          [
            profileId, id, data.orcid || null, data.scopusAuthorId || null, data.wosResearcherId || null,
            data.titleTh || null, data.firstNameTh || null, data.lastNameTh || null,
            data.titleEn || null, data.firstNameEn || null, data.lastNameEn || null, data.shortNameEn || null
          ]
        );
      }

      const result = await realDbHandlers.users.findUnique(id);
      await writeRealAuditLog('irUser', id, 'UPDATE', current, result, performedBy);
      return result;
    },"""

new_update_function = """    update: async (id: string, data: any, performedBy?: string | null) => {
      const current = await realDbHandlers.users.findUnique(id);
      if (!current) throw new Error('User not found');
      
      const role = data.role !== undefined ? data.role : current.role;
      const recorderId = (performedBy && performedBy !== 'admin' && performedBy !== 'system') ? performedBy : null;

      // 1. Build dynamic UPDATE for irUser & Write history logs formatted as fieldName.irUser
      const userFields = ['email', 'role', 'title', 'firstName', 'lastName', 'employeeId'];
      const userUpdates = [];
      const userParams = [];
      let uIndex = 1;

      // Map En profile name fields to base user fields if provided
      const newTitle = data.titleEn !== undefined ? data.titleEn : (data.title !== undefined ? data.title : current.title);
      const newFirstName = data.firstNameEn !== undefined ? data.firstNameEn : (data.firstName !== undefined ? data.firstName : current.firstName);
      const newLastName = data.lastNameEn !== undefined ? data.lastNameEn : (data.lastName !== undefined ? data.lastName : current.lastName);
      const newName = `${newTitle || ''} ${newFirstName || ''} ${newLastName || ''}`.trim().replace(/\\s+/, ' ');
      
      if (newName !== current.name) {
        userUpdates.push(`"name" = $${uIndex}`);
        userParams.push(newName);
        uIndex++;
        // Log name change to history
        await dbQuery(
          'INSERT INTO "irResearcherProfileHistory" (id, userId, changedField, oldValue, newValue, effectiveDate, recordedBy, reason) VALUES ($1, $2, $3, $4, $5, date(\\'now\\'), $6, $7)',
          [crypto.randomUUID(), id, 'name.irUser', String(current.name || ''), String(newName || ''), recorderId, data.changeReason || 'Profile update']
        );
      }

      const mappedNewValues: Record<string, any> = {
        title: newTitle,
        firstName: newFirstName,
        lastName: newLastName,
        email: data.email,
        role: data.role,
        employeeId: data.employeeId
      };

      for (const field of userFields) {
        const newVal = mappedNewValues[field];
        if (newVal !== undefined && isDifferent(newVal, current[field])) {
          userUpdates.push(`"${field}" = $${uIndex}`);
          userParams.push(newVal || null);
          uIndex++;

          // Log field change in irUser table
          await dbQuery(
            'INSERT INTO "irResearcherProfileHistory" (id, userId, changedField, oldValue, newValue, effectiveDate, recordedBy, reason) VALUES ($1, $2, $3, $4, $5, date(\\'now\\'), $6, $7)',
            [crypto.randomUUID(), id, `${field}.irUser`, String(current[field] || ''), String(newVal || ''), recorderId, data.changeReason || 'Profile update']
          );
        }
      }

      const isDeleted = data.isDeleted !== undefined ? (data.isDeleted ? 1 : 0) : (current.isDeleted ? 1 : 0);
      const currentIsDeletedNum = current.isDeleted ? 1 : 0;
      if (isDeleted !== currentIsDeletedNum) {
        userUpdates.push(`"isDeleted" = $${uIndex}`);
        userParams.push(isDeleted);
        uIndex++;
        
        await dbQuery(
          'INSERT INTO "irResearcherProfileHistory" (id, userId, changedField, oldValue, newValue, effectiveDate, recordedBy, reason) VALUES ($1, $2, $3, $4, $5, date(\\'now\\'), $6, $7)',
          [crypto.randomUUID(), id, 'isDeleted.irUser', String(currentIsDeletedNum), String(isDeleted), recorderId, data.changeReason || 'Profile update']
        );
      }

      if (userUpdates.length > 0) {
        userUpdates.push(`"updatedAt" = CURRENT_TIMESTAMP`);
        userParams.push(id);
        await dbQuery(
          `UPDATE "irUser" SET ${userUpdates.join(', ')} WHERE id = $${uIndex}`,
          userParams
        );
      }

      // 2. Build dynamic UPDATE for irResearcherProfile & Log changes as fieldName.irResearcherProfile
      const profileFields = ['titleTh', 'firstNameTh', 'lastNameTh', 'titleEn', 'firstNameEn', 'lastNameEn', 'orcid', 'scopusAuthorId', 'wosResearcherId', 'shortNameEn'];
      
      // Check if profile exists
      const profileCheck = await dbQuery('SELECT id FROM "irResearcherProfile" WHERE userId = $1', [id]);
      const hasProfile = profileCheck.rows.length > 0;
      
      if (hasProfile) {
        const updates = [];
        const params = [];
        let pIndex = 1;
        for (const field of profileFields) {
          if (data[field] !== undefined && isDifferent(data[field], current[field])) {
            updates.push(`"${field}" = $${pIndex}`);
            params.push(data[field] || null);
            pIndex++;
            
            // Record history log formatted as fieldName.irResearcherProfile
            await dbQuery(
              'INSERT INTO "irResearcherProfileHistory" (id, userId, changedField, oldValue, newValue, effectiveDate, recordedBy, reason) VALUES ($1, $2, $3, $4, $5, date(\\'now\\'), $6, $7)',
              [crypto.randomUUID(), id, `${field}.irResearcherProfile`, String(current[field] || ''), String(data[field] || ''), recorderId, data.changeReason || 'Profile update']
            );
          }
        }
        if (updates.length > 0) {
          params.push(id);
          await dbQuery(`UPDATE "irResearcherProfile" SET ${updates.join(', ')} WHERE userId = $${pIndex}`, params);
        }
      } else if (role === 'RESEARCHER') {
        // Create profile if it didn't exist and log the initial values
        const profileId = crypto.randomUUID();
        await dbQuery(
          'INSERT INTO "irResearcherProfile" (id, userId, orcid, scopusAuthorId, wosResearcherId, titleTh, firstNameTh, lastNameTh, titleEn, firstNameEn, lastNameEn, shortNameEn) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)',
          [
            profileId, id, data.orcid || null, data.scopusAuthorId || null, data.wosResearcherId || null,
            data.titleTh || null, data.firstNameTh || null, data.lastNameTh || null,
            data.titleEn || null, data.firstNameEn || null, data.lastNameEn || null, data.shortNameEn || null
          ]
        );
        
        // Log all fields initialized in the profile
        for (const field of profileFields) {
          if (data[field] !== undefined && data[field] !== null && data[field] !== '') {
            await dbQuery(
              'INSERT INTO "irResearcherProfileHistory" (id, userId, changedField, oldValue, newValue, effectiveDate, recordedBy, reason) VALUES ($1, $2, $3, $4, $5, date(\\'now\\'), $6, $7)',
              [crypto.randomUUID(), id, `${field}.irResearcherProfile`, '', String(data[field]), recorderId, data.changeReason || 'Profile initial setup']
            );
          }
        }
      }

      const result = await realDbHandlers.users.findUnique(id);
      await writeRealAuditLog('irUser', id, 'UPDATE', current, result, performedBy);
      return result;
    },"""

content = content.replace(old_update_function, new_update_function)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print("apiDb.ts comprehensive update & history logging format patched successfully!")
