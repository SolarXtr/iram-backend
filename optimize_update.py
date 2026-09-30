import re

path = r'D:\.gemini\antigravity\scratch\iram-services\src\lib\apiDb.ts'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace the update method in apiDb.ts to dynamically build UPDATE statement for irUser as well
old_update_block = """    update: async (id: string, data: any, performedBy?: string | null) => {
      const current = await realDbHandlers.users.findUnique(id);
      if (!current) throw new Error('User not found');
      
      // Check if updating irUser
      const title = data.title !== undefined ? data.title : current.title;
      const firstName = data.firstName !== undefined ? data.firstName : current.firstName;
      const lastName = data.lastName !== undefined ? data.lastName : current.lastName;
      const name = data.name || `${title} ${firstName} ${lastName}`.trim().replace(/\\s+/, ' ');
      const email = data.email !== undefined ? data.email : current.email;
      const role = data.role !== undefined ? data.role : current.role;
      const employeeId = data.employeeId !== undefined ? data.employeeId : current.employeeId;
      const isDeleted = data.isDeleted !== undefined ? (data.isDeleted ? 1 : 0) : (current.isDeleted ? 1 : 0);

      await dbQuery(
        'UPDATE "irUser" SET name = $1, email = $2, role = $3, title = $4, "firstName" = $5, "lastName" = $6, "isDeleted" = $7, "employeeId" = $8, "updatedAt" = CURRENT_TIMESTAMP WHERE id = $9',
        [name, email, role, title, firstName, lastName, isDeleted, employeeId, id]
      );"""

new_update_block = """    update: async (id: string, data: any, performedBy?: string | null) => {
      const current = await realDbHandlers.users.findUnique(id);
      if (!current) throw new Error('User not found');
      
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
      }"""

content = content.replace(old_update_block, new_update_block)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print("apiDb.ts optimized for dynamic single-field updates!")
