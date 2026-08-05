CREATE TABLE IF NOT EXISTS "irJournalQuartile" (
    "id" TEXT PRIMARY KEY,
    "issn" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "quartile" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "updatedAt" TEXT DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
);
CREATE INDEX IF NOT EXISTS "idx_irJournalQuartile_issn" ON "irJournalQuartile" ("issn");
