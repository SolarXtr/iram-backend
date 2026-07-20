DROP TABLE IF EXISTS "irPublicationAuthor";
DROP TABLE IF EXISTS "irPublication";

CREATE TABLE "irPublication" (
    "id" TEXT PRIMARY KEY,
    "doi" TEXT UNIQUE,
    "title" TEXT NOT NULL,
    "journal" TEXT NOT NULL,
    "quartile" TEXT NOT NULL, -- 'Q1', 'Q2', 'Q3', 'Q4'
    "uniRewardStatus" TEXT DEFAULT 'PENDING', -- 'PENDING', 'APPROVED', 'REJECTED'
    "uniRewardAmount" REAL DEFAULT 0.0,
    "facultyRewardStatus" TEXT DEFAULT 'PENDING', -- 'PENDING', 'APPROVED', 'REJECTED'
    "facultyRewardAmount" REAL DEFAULT 0.0,
    "status" TEXT NOT NULL, -- 'WRITING', 'SUBMITTED', 'UNDER_REVIEW', 'PUBLISHED', 'REWARDED'
    "projectId" TEXT,
    "claimingAuthorId" TEXT,
    "isDeleted" INTEGER DEFAULT 0,
    "createdAt" TEXT DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    "updatedAt" TEXT DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY ("projectId") REFERENCES "irResearchProject" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY ("claimingAuthorId") REFERENCES "irUser" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "irPublicationAuthor" (
    "id" TEXT PRIMARY KEY,
    "publicationId" TEXT NOT NULL,
    "authorName" TEXT NOT NULL,
    "userId" TEXT,
    "authorOrder" INTEGER NOT NULL,
    "isCorresponding" INTEGER DEFAULT 0,
    FOREIGN KEY ("publicationId") REFERENCES "irPublication" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userId") REFERENCES "irUser" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- Mock Data for Publications
INSERT INTO "irPublication" ("id", "title", "journal", "quartile", "uniRewardStatus", "uniRewardAmount", "facultyRewardStatus", "facultyRewardAmount", "status", "projectId", "claimingAuthorId") VALUES
('pub-1', 'Deep Learning Application in Early Detection of Coronary Artery Disease', 'Journal of Medical Systems', 'Q1', 'APPROVED', 50000.0, 'APPROVED', 20000.0, 'REWARDED', 'project-1', 'user-1'),
('pub-2', 'Antioxidant activities of Thai traditional herbs for skincare application', 'Cosmetics & Dermatology Research', 'Q2', 'PENDING', 30000.0, 'PENDING', 10000.0, 'PUBLISHED', 'project-3', 'user-1'),
('pub-3', 'Novel tropical virus structures analysis in Southeast Asia', 'Asia-Pacific Journal of Virology', 'Q1', 'PENDING', 50000.0, 'PENDING', 20000.0, 'UNDER_REVIEW', 'project-2', 'user-2');

-- Mock Data for Publication Authors
INSERT INTO "irPublicationAuthor" ("id", "publicationId", "authorName", "userId", "authorOrder", "isCorresponding") VALUES
('pub-1-auth-1', 'pub-1', 'สมเกียรติ รักเรียน', 'user-1', 1, 1),
('pub-2-auth-1', 'pub-2', 'สมเกียรติ รักเรียน', 'user-1', 1, 0),
('pub-3-auth-1', 'pub-3', 'วิภา จิตวิทยา', 'user-2', 2, 1);
