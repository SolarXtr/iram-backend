-- Migration: Create irRewardApplication Table
CREATE TABLE IF NOT EXISTS irRewardApplication (
    id TEXT PRIMARY KEY,
    trackingNo TEXT UNIQUE NOT NULL,
    fiscalYear INTEGER NOT NULL,
    applicantName TEXT NOT NULL,
    academicPosition TEXT,
    department TEXT NOT NULL,
    phone TEXT,
    email TEXT NOT NULL,
    bankName TEXT NOT NULL,
    bankAccountNo TEXT NOT NULL,
    idCardNo TEXT,
    pdpaConsentAccepted INTEGER DEFAULT 1,
    pdpaConsentDate TEXT,
    
    -- ข้อมูลบทความ
    requestType TEXT NOT NULL, -- 'reward_only' | 'page_charge_only' | 'both'
    articleTitle TEXT NOT NULL,
    journalName TEXT NOT NULL,
    journalScope TEXT NOT NULL, -- 'international' | 'national'
    databaseName TEXT NOT NULL,
    quartile TEXT NOT NULL,
    isTier1Top10 INTEGER DEFAULT 0,
    authorRole TEXT NOT NULL, -- 'first_author' | 'corresponding_author' | 'co_author'
    articleType TEXT NOT NULL,
    issn TEXT,
    doi TEXT,
    volumeIssue TEXT,
    publishedDate TEXT NOT NULL,
    
    -- ยอดเงินคำนวณและเบิกจ่าย
    claimedRewardAmount REAL DEFAULT 0,
    claimedPageChargeAmount REAL DEFAULT 0,
    approvedPageChargeAmount REAL DEFAULT 0,
    totalClaimedAmount REAL DEFAULT 0,
    actualPaidAmount REAL DEFAULT 0,
    
    -- ข้อมูลเอกสารราชการ
    internalDocNo TEXT,
    researchDocRecNo TEXT,
    financeDocRecNo TEXT,
    disbursementVoucherNo TEXT,
    blueSlipNo TEXT,
    budgetExpenseCode TEXT,
    
    -- สถานะและขั้นตอน (Workflow 1-12)
    currentStep INTEGER DEFAULT 1,
    status TEXT DEFAULT 'submitted',
    paymentStatus TEXT DEFAULT 'unpaid',
    paymentDate TEXT,
    paymentTransferSlipUrl TEXT,
    
    -- บันทึกและไทม์ไลน์
    coordinatorNotes TEXT,
    attachmentsJson TEXT,
    timelineJson TEXT,
    createdAt TEXT DEFAULT (datetime('now')),
    updatedAt TEXT DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_reward_doi ON irRewardApplication(doi);
CREATE INDEX IF NOT EXISTS idx_reward_title ON irRewardApplication(articleTitle);
CREATE INDEX IF NOT EXISTS idx_reward_fiscalYear ON irRewardApplication(fiscalYear);
CREATE INDEX IF NOT EXISTS idx_reward_applicant ON irRewardApplication(applicantName);
