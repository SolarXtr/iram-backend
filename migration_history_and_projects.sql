-- Add employeeId to irUser
ALTER TABLE "irUser" ADD COLUMN "employeeId" TEXT;

-- Add split names to irResearcherProfile
ALTER TABLE "irResearcherProfile" ADD COLUMN "firstNameTh" TEXT;
ALTER TABLE "irResearcherProfile" ADD COLUMN "lastNameTh" TEXT;
ALTER TABLE "irResearcherProfile" ADD COLUMN "titleEn" TEXT;
ALTER TABLE "irResearcherProfile" ADD COLUMN "firstNameEn" TEXT;
ALTER TABLE "irResearcherProfile" ADD COLUMN "lastNameEn" TEXT;

-- Create Profile Change History table
CREATE TABLE IF NOT EXISTS "irResearcherProfileHistory" (
    "id" TEXT PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "changedField" TEXT NOT NULL,
    "oldValue" TEXT,
    "newValue" TEXT,
    "effectiveDate" TEXT NOT NULL,
    "recordedAt" TEXT DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    "recordedBy" TEXT,
    "reason" TEXT,
    FOREIGN KEY ("userId") REFERENCES "irUser" ("id") ON DELETE CASCADE,
    FOREIGN KEY ("recordedBy") REFERENCES "irUser" ("id") ON DELETE SET NULL
);
