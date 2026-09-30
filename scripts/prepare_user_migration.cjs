const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('Fetching users and profiles from Cloudflare D1...');

// Run D1 query to fetch users and profiles
const cmd = `npx wrangler d1 execute iram-db --remote --json --command="SELECT u.id, u.name, u.email, u.title, u.firstName, u.lastName, u.academicPosition, p.nameTh, p.titleTh, p.firstNameTh, p.lastNameTh, p.titleEn, p.firstNameEn, p.lastNameEn, p.shortNameEn, p.department, p.scopusAuthorId, p.orcid, p.wosResearcherId FROM irUser u LEFT JOIN irResearcherProfile p ON u.id = p.userId;"`;

let rawOutput;
try {
  rawOutput = execSync(cmd, { cwd: path.join(__dirname, '..'), encoding: 'utf-8', maxBuffer: 10 * 1024 * 1024 });
} catch (e) {
  console.error('Failed to execute query:', e.message);
  process.exit(1);
}

const parsed = JSON.parse(rawOutput);
const rows = parsed[0]?.results || [];
console.log(`Fetched ${rows.length} rows.`);

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

function isThai(text) {
  return /[\u0E00-\u0E7F]/.test(text || '');
}

function cleanStr(s) {
  return (s || '').trim();
}

function escapeSql(s) {
  if (s === null || s === undefined) return 'NULL';
  return `'${String(s).replace(/'/g, "''").trim()}'`;
}

const updateStatements = [];

for (const row of rows) {
  let {
    id, name, email, title, firstName, lastName, academicPosition,
    nameTh, titleTh, firstNameTh, lastNameTh,
    titleEn, firstNameEn, lastNameEn, shortNameEn,
    department, scopusAuthorId, orcid, wosResearcherId
  } = row;

  // 1. Process Thai Names & Titles
  let finalTitleTh = cleanStr(titleTh);
  let finalFirstNameTh = cleanStr(firstNameTh);
  let finalLastNameTh = cleanStr(lastNameTh);

  let rawTh = cleanStr(nameTh);
  if (!rawTh && isThai(name)) {
    rawTh = cleanStr(name);
  }

  if (rawTh) {
    let matchedTitle = '';
    for (const t of THAI_TITLES) {
      if (rawTh.startsWith(t)) {
        matchedTitle = t;
        rawTh = rawTh.slice(t.length).trim();
        break;
      }
    }
    if (!finalTitleTh && matchedTitle) {
      finalTitleTh = matchedTitle;
    }
    const parts = rawTh.split(/\s+/).filter(Boolean);
    if (!finalFirstNameTh && parts.length > 0) {
      finalFirstNameTh = parts[0];
    }
    if (!finalLastNameTh && parts.length > 1) {
      finalLastNameTh = parts.slice(1).join(' ');
    }
  }

  // 2. Process English Names & Titles
  let finalTitleEn = cleanStr(titleEn);
  let finalFirstNameEn = cleanStr(firstNameEn);
  let finalLastNameEn = cleanStr(lastNameEn);

  let rawEn = cleanStr(name);
  if (!isThai(rawEn)) {
    let matchedTitle = '';
    for (const t of ENG_TITLES) {
      if (rawEn.startsWith(t)) {
        matchedTitle = t;
        rawEn = rawEn.slice(t.length).trim();
        break;
      }
    }
    if (!finalTitleEn && matchedTitle) {
      finalTitleEn = matchedTitle;
    }
    const parts = rawEn.split(/\s+/).filter(Boolean);
    if (!finalFirstNameEn && parts.length > 0) {
      finalFirstNameEn = parts[0];
    }
    if (!finalLastNameEn && parts.length > 1) {
      finalLastNameEn = parts.slice(1).join(' ');
    }
  }

  // 3. Fallback titleTh from academicPosition or title if still empty
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

  // 4. Generate shortNameEn: [LastName] [FirstInitial].
  let finalShortNameEn = cleanStr(shortNameEn);
  if (!finalShortNameEn && finalLastNameEn && finalFirstNameEn) {
    const initial = finalFirstNameEn.charAt(0).toUpperCase();
    finalShortNameEn = `${finalLastNameEn} ${initial}.`;
  }

  // 5. Clean department and identifiers
  const finalDept = cleanStr(department) || 'คณะแพทยศาสตร์ มหาวิทยาลัยนเรศวร';
  const finalScopus = cleanStr(scopusAuthorId) || null;
  const finalOrcid = cleanStr(orcid) || null;
  const finalWos = cleanStr(wosResearcherId) || null;

  // 6. Aliases JSON
  const aliases = [];
  if (finalShortNameEn) {
    aliases.push({ shortName: finalShortNameEn, type: 'primary' });
  }

  const sql = `UPDATE "irUser" SET ` +
    `"titleTh" = ${escapeSql(finalTitleTh || null)}, ` +
    `"firstNameTh" = ${escapeSql(finalFirstNameTh || null)}, ` +
    `"lastNameTh" = ${escapeSql(finalLastNameTh || null)}, ` +
    `"titleEn" = ${escapeSql(finalTitleEn || null)}, ` +
    `"firstNameEn" = ${escapeSql(finalFirstNameEn || null)}, ` +
    `"lastNameEn" = ${escapeSql(finalLastNameEn || null)}, ` +
    `"shortNameEn" = ${escapeSql(finalShortNameEn || null)}, ` +
    `"department" = ${escapeSql(finalDept)}, ` +
    `"scopusAuthorId" = ${escapeSql(finalScopus)}, ` +
    `"orcid" = ${escapeSql(finalOrcid)}, ` +
    `"wosResearcherId" = ${escapeSql(finalWos)}, ` +
    `"aliasesJson" = ${escapeSql(JSON.stringify(aliases))} ` +
    `WHERE "id" = ${escapeSql(id)};`;

  updateStatements.push(sql);
}

const outSqlPath = path.join(__dirname, '..', 'populate_users_consolidated.sql');
fs.writeFileSync(outSqlPath, updateStatements.join('\n'), 'utf-8');
console.log(`Generated ${updateStatements.length} UPDATE statements in ${outSqlPath}`);
