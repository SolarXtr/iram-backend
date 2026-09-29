-- Migration: Consolidate Researcher Profile into irUser (Single Source of Truth)
-- Adding Thai/Eng structured names, citation short name (e.g. Srisingh K.), and academic IDs

ALTER TABLE "irUser" ADD COLUMN "titleTh" TEXT;
ALTER TABLE "irUser" ADD COLUMN "firstNameTh" TEXT;
ALTER TABLE "irUser" ADD COLUMN "lastNameTh" TEXT;
ALTER TABLE "irUser" ADD COLUMN "titleEn" TEXT;
ALTER TABLE "irUser" ADD COLUMN "firstNameEn" TEXT;
ALTER TABLE "irUser" ADD COLUMN "lastNameEn" TEXT;
ALTER TABLE "irUser" ADD COLUMN "shortNameEn" TEXT;
ALTER TABLE "irUser" ADD COLUMN "aliasesJson" TEXT DEFAULT '[]';
ALTER TABLE "irUser" ADD COLUMN "department" TEXT;
ALTER TABLE "irUser" ADD COLUMN "scopusAuthorId" TEXT;
ALTER TABLE "irUser" ADD COLUMN "orcid" TEXT;
ALTER TABLE "irUser" ADD COLUMN "wosResearcherId" TEXT;

CREATE INDEX IF NOT EXISTS idx_user_shortNameEn ON "irUser"(shortNameEn);
CREATE INDEX IF NOT EXISTS idx_user_scopusAuthorId ON "irUser"(scopusAuthorId);
CREATE INDEX IF NOT EXISTS idx_user_email ON "irUser"(email);
