-- Migration to extend irUser for Reward System User Profile & PDPA Data
-- Table: irUser
ALTER TABLE "irUser" ADD COLUMN "phone" TEXT;
ALTER TABLE "irUser" ADD COLUMN "bankName" TEXT DEFAULT 'ธนาคารกรุงศรีอยุธยา สาขามหาวิทยาลัยนเรศวร';
ALTER TABLE "irUser" ADD COLUMN "bankAccountNo" TEXT;
ALTER TABLE "irUser" ADD COLUMN "idCardNo" TEXT;
ALTER TABLE "irUser" ADD COLUMN "academicPosition" TEXT;
ALTER TABLE "irUser" ADD COLUMN "administrativePosition" TEXT;
ALTER TABLE "irUser" ADD COLUMN "rolesJson" TEXT DEFAULT '["researcher"]';
ALTER TABLE "irUser" ADD COLUMN "lastLoginAt" TEXT;
