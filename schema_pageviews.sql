CREATE TABLE IF NOT EXISTS irPageViews (
    id TEXT PRIMARY KEY,
    domain TEXT NOT NULL,
    path TEXT NOT NULL,
    sessionId TEXT NOT NULL,
    userAgent TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_pageviews_domain ON irPageViews(domain);
CREATE INDEX IF NOT EXISTS idx_pageviews_timestamp ON irPageViews(timestamp);
CREATE INDEX IF NOT EXISTS idx_pageviews_session ON irPageViews(sessionId);
