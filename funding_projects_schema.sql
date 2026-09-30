CREATE TABLE IF NOT EXISTS funding_projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    project_name TEXT NOT NULL,
    researcher_name TEXT NOT NULL,
    status TEXT NOT NULL,
    updated_date TEXT NOT NULL
);

INSERT INTO funding_projects (project_name, researcher_name, status, updated_date) VALUES 
('การพัฒนาระบบคัดกรองโรค', 'นพ. สมชาย รักดี', 'อนุมัติทุน', '15 ส.ค. 2567'),
('ศึกษาแนวโน้มผู้ป่วยนอก', 'พญ. สมหญิง เก่งมาก', 'รอพิจารณา', '20 ส.ค. 2567'),
('ประเมินผลการรักษาด้วยยาใหม่', 'ดร. สมศักดิ์ มานะ', 'แก้ไขเอกสาร', '22 ส.ค. 2567');
