const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const sqlFile = path.join(__dirname, '..', 'populate_users_consolidated.sql');
const content = fs.readFileSync(sqlFile, 'utf-8');
const lines = content.split('\n').map(l => l.trim()).filter(Boolean);

console.log(`Total statements to execute: ${lines.length}`);
const batchSize = 50;
const totalBatches = Math.ceil(lines.length / batchSize);

for (let b = 0; b < totalBatches; b++) {
  const chunk = lines.slice(b * batchSize, (b + 1) * batchSize);
  const chunkFile = path.join(__dirname, '..', `chunk_${b + 1}.sql`);
  fs.writeFileSync(chunkFile, chunk.join('\n'), 'utf-8');

  console.log(`Executing batch ${b + 1}/${totalBatches} (${chunk.length} statements)...`);
  try {
    execSync(`npx wrangler d1 execute iram-db --remote --file=chunk_${b + 1}.sql`, {
      cwd: path.join(__dirname, '..'),
      stdio: 'inherit',
      timeout: 90000
    });
    console.log(`Batch ${b + 1} completed.`);
    fs.unlinkSync(chunkFile);
  } catch (err) {
    console.error(`Error in batch ${b + 1}:`, err.message);
    process.exit(1);
  }
}

console.log('All batches executed successfully!');
