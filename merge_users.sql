-- 1. ย้ายข้อมูลจาก ID: 641aa6d2-b891-4a39-a803-09019ab2e771 ไปยัง ID เดิม: 61362b4f-8788-42a9-a81c-203c229bc38f (กาญจ์รวี สังเปรม)
UPDATE irPublicationAuthor SET userId = '61362b4f-8788-42a9-a81c-203c229bc38f' WHERE userId = '641aa6d2-b891-4a39-a803-09019ab2e771';
UPDATE irPublication SET claimingAuthorId = '61362b4f-8788-42a9-a81c-203c229bc38f' WHERE claimingAuthorId = '641aa6d2-b891-4a39-a803-09019ab2e771';
UPDATE irResearchProject SET leaderId = '61362b4f-8788-42a9-a81c-203c229bc38f' WHERE leaderId = '641aa6d2-b891-4a39-a803-09019ab2e771';
UPDATE irPresentation SET presenterId = '61362b4f-8788-42a9-a81c-203c229bc38f' WHERE presenterId = '641aa6d2-b891-4a39-a803-09019ab2e771';
DELETE FROM irResearcherProfile WHERE userId = '641aa6d2-b891-4a39-a803-09019ab2e771';
DELETE FROM irUser WHERE id = '641aa6d2-b891-4a39-a803-09019ab2e771';

-- 2. ย้ายข้อมูลจาก ID: bbb0df09-fffa-43f3-8b37-930e166d79bf ไปยัง ID เดิม: 329afdf0-2a63-4d03-b1b6-16775bead2c5 (ณัฐรุจน์ ชัยพุทธานุกูล)
UPDATE irPublicationAuthor SET userId = '329afdf0-2a63-4d03-b1b6-16775bead2c5' WHERE userId = 'bbb0df09-fffa-43f3-8b37-930e166d79bf';
UPDATE irPublication SET claimingAuthorId = '329afdf0-2a63-4d03-b1b6-16775bead2c5' WHERE claimingAuthorId = 'bbb0df09-fffa-43f3-8b37-930e166d79bf';
UPDATE irResearchProject SET leaderId = '329afdf0-2a63-4d03-b1b6-16775bead2c5' WHERE leaderId = 'bbb0df09-fffa-43f3-8b37-930e166d79bf';
UPDATE irPresentation SET presenterId = '329afdf0-2a63-4d03-b1b6-16775bead2c5' WHERE presenterId = 'bbb0df09-fffa-43f3-8b37-930e166d79bf';
DELETE FROM irResearcherProfile WHERE userId = 'bbb0df09-fffa-43f3-8b37-930e166d79bf';
DELETE FROM irUser WHERE id = 'bbb0df09-fffa-43f3-8b37-930e166d79bf';
