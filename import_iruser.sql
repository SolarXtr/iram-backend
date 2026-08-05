INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('user-1', 'ศ.ดร. สมเกียรติ รักเรียน (นักวิจัย)', 'somkiat.r@iram.edu', 'RESEARCHER', 0, 'ศ.ดร.', 'สมเกียรติ', 'รักเรียน (นักวิจัย)', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('user-2', 'ดร. วิภา จิตวิทยา (นักวิจัย)', 'wipa.j@iram.edu', 'RESEARCHER', 0, 'ดร.', 'วิภา', 'จิตวิทยา (นักวิจัย)', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('user-3', 'คุณ วันดี ทำงานดี (เจ้าหน้าที่)', 'wandee.w@iram.edu', 'STAFF', 0, NULL, 'คุณ', 'วันดี ทำงานดี (เจ้าหน้าที่)', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('user-4', 'รศ.นพ. ทรงพล บริหาร (ผู้บริหาร)', 'songpol.s@iram.edu', 'EXECUTIVE', 0, 'รศ.นพ.', 'ทรงพล', 'บริหาร (ผู้บริหาร)', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('1965cfb0-c73c-44d0-911a-4eeee19519fa', 'Adisuan Kuatrakul', 'non19991@hotmail.com', 'RESEARCHER', 0, NULL, 'Adisuan', 'Kuatrakul', '2019-05-21', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('5d2a9092-6708-49c9-a08f-bd649b80001f', 'Akamon Tapprom', 'tapproma@gmail.com', 'RESEARCHER', 0, NULL, 'Akamon', 'Tapprom', '1998-04-08', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('911f4a47-11e2-4182-8774-abdcf6c6079e', 'Akaworn Mahatthanatrakul', 'akaworn@gmail.com', 'RESEARCHER', 0, NULL, 'Akaworn', 'Mahatthanatrakul', '2014-07-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8e1209f9-9294-4c25-a558-125a1b6c9989', 'Anyarin Wannakittirat', '59461742500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Anyarin', 'Wannakittirat', '2023-06-30', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ae579fa9-7664-40f7-b7ea-a9176aefe3b8', 'Apichaya Sripariwuth', '57202729440@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Apichaya', 'Sripariwuth', '2009-11-23', '2023-10-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('503723c4-f507-41da-92d5-4d30bc5f6dca', 'Apiradee Jirattigalachote', '57211424331@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Apiradee', 'Jirattigalachote', '2002-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ba172345-5518-407a-bcff-e8ba8ec1d1b8', 'Apirak Tewaritruangsri', '59179546500@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Apirak', 'Tewaritruangsri', '2016-05-16', '2024-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b132cddf-46ec-43de-aaf5-8236554ce6e4', 'Apirath Wangteeraprasert', 'apirathw@yahoo.com', 'RESEARCHER', 0, NULL, 'Apirath', 'Wangteeraprasert', '2007-06-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('1addc566-74f1-42ff-b5fd-57b6aeac9fd3', 'Aree Hinphet', 'areeh@nu.ac.th', 'RESEARCHER', 0, NULL, 'Aree', 'Hinphet', '2016-10-20', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d690b8b0-e27f-4bdc-b922-b2f75fd8d813', 'Arisa Duantaweesook', '59975138700@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Arisa', 'Duantaweesook', '2019-06-10', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('68acd919-306e-49aa-a646-8fbac54b720d', 'Artit Laoruengthana', 'artitlao@yahoo.com', 'RESEARCHER', 0, NULL, 'Artit', 'Laoruengthana', '2002-07-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('fb27c74a-c119-40db-8154-595ba5f1465e', 'Arunee Srichaiya', '23569976700@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Arunee', 'Srichaiya', '2011-08-16', '2016-04-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('02d71ad0-3ceb-4110-bf76-84178cb980e0', 'Attapon Junlapan', 'attaponj@nu.ac.th', 'RESEARCHER', 1, NULL, 'Attapon', 'Junlapan', '2013-07-01', '2021-05-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('107a7b35-24e8-414c-97f0-7aca530ed513', 'Atthakorn Jarusriwanna', 'atthakorn.ton@gmail.com', 'RESEARCHER', 0, NULL, 'Atthakorn', 'Jarusriwanna', '2010-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4ab67a7d-05d1-48ee-955a-554f923a316d', 'Bodin Butthum', 'addbodin17@hotmail.com', 'RESEARCHER', 0, NULL, 'Bodin', 'Butthum', '2001-04-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b5b28d9f-6cc3-4ff2-ae8b-33c013b0f3d2', 'Butsakorn Sontham', 'fiesbut02@gmail.com', 'RESEARCHER', 0, NULL, 'Butsakorn', 'Sontham', '2017-07-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('9aa2b62b-f47f-41ce-8710-81d156a157bb', 'Chadarthan Luangsawang', 'Hellotoey@hotmail.com', 'RESEARCHER', 1, NULL, 'Chadarthan', 'Luangsawang', '2008-05-01', '2018-03-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('0208044d-c6ad-4028-a404-3c9940865f8e', 'Chadawan Sriwad', '60021226600@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Chadawan', 'Sriwad', '2025-05-19', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('59e9aeb6-2e85-451d-aa59-953df23990f8', 'Chaiyaporn Virochsangaroon', '59834482200@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Chaiyaporn', 'Virochsangaroon', '2016-10-20', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f88ae32d-a9eb-4d4e-a7a2-577ddc92718f', 'Chanida Chantim', '58772974200@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Chanida', 'Chantim', '2010-07-08', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ef70ffbb-34bd-467b-9308-4ffe23362f14', 'Chao Saenghirunvattana', 'chao_saeng@hotmail.com', 'RESEARCHER', 1, NULL, 'Chao', 'Saenghirunvattana', '2015-06-02', '2020-09-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f9c45e3c-b393-48ed-936d-774cc2b4559e', 'Chatmongkol Phruancharoen', '57825515600@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Chatmongkol', 'Phruancharoen', '2009-07-10', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f643c144-ef13-4905-bbe7-95f19da7e55d', 'Chatrawut Pattaweerakul', '58844385300@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Chatrawut', 'Pattaweerakul', '2005-06-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('fefa21d5-c2bb-49c6-9b01-569c54450cde', 'Chayamon Suwansumrit', 'neptune.cym@gmail.com', 'RESEARCHER', 0, NULL, 'Chayamon', 'Suwansumrit', '2017-05-22', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('7312bf7d-249f-4005-858d-a0bc3a0b6cbb', 'Chinapat Gerawarapong', 'chinapatjqka@gmail.com', 'RESEARCHER', 0, NULL, 'Chinapat', 'Gerawarapong', '2001-04-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('376e08a9-440d-436e-8dbc-7dfd860d1b03', 'Chompoonoot Boonsopa', 'chompoonoot_pednu@outlook.com', 'RESEARCHER', 0, NULL, 'Chompoonoot', 'Boonsopa', '2002-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ddbaa6b2-ce5a-4b39-af57-6f1481869b2f', 'Chutarat Sirichareon', '60124466800@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Chutarat', 'Sirichareon', '2008-06-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('bb68c0a7-2b4f-4042-8b38-64360a478ed7', 'Chutchai Leelasettagool', '10440218400@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Chutchai', 'Leelasettagool', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('0d257095-41bf-4615-b9ef-c306734b0598', 'Chutima Phuaksaman', 'aimyaim1@gmail.com', 'RESEARCHER', 0, NULL, 'Chutima', 'Phuaksaman', '2009-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f317d80a-11c5-4dc4-a1fc-510c93aee3ec', 'Daranee Sirichaisutdhikorn', 'limyon 10@yahoo.com', 'RESEARCHER', 1, NULL, 'Daranee', 'Sirichaisutdhikorn', '2003-06-02', '2019-01-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a61a566f-d4f0-413d-96f5-053894c00257', 'Dhirayudh Yokubol', '23101833300@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Dhirayudh', 'Yokubol', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('dcc6c41e-ce5e-4efb-88af-6cf0cf4709d7', 'Dithawut Khrutmuang', '57189351662@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Dithawut', 'Khrutmuang', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('196fae4e-a8a0-48de-9111-0ea18367794e', 'Duangnapa Roongpiboonsopit', 'duangnapa.ro@gmail.com', 'RESEARCHER', 0, NULL, 'Duangnapa', 'Roongpiboonsopit', '2009-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('5848c605-b234-495f-8a02-d93d953dfc7d', 'Ekawee Sripariwuth', 'ekawesri@gmail.com', 'RESEARCHER', 0, NULL, 'Ekawee', 'Sripariwuth', '1996-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('0c8252d3-65a6-42df-b3ef-057d4e8d1ab2', 'Engcanit Cholkraisuwat', '36464763200@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Engcanit', 'Cholkraisuwat', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b8ab5f3e-7b5e-46a0-a4c1-e784a2184b7e', 'Fasinee Arunrodpanya', 'fasineea@nu.ac.th', 'RESEARCHER', 0, NULL, 'Fasinee', 'Arunrodpanya', '2014-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b649fd31-a032-43ee-a2a0-d8bd7682cb1c', 'Inthiporn Kositanurit', '57933122200@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Inthiporn', 'Kositanurit', '2016-05-16', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('335d1879-6dc2-4102-abb7-b831e66f70c3', 'Janpen Kwansirikul', 'kwansijan@gmail.com', 'RESEARCHER', 1, NULL, 'Janpen', 'Kwansirikul', '2008-06-02', '2023-04-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('57012647-0888-4c1a-9825-03cc9079e6d9', 'Jarun Sayasathid', 'jsayasathid@hotmail.com / jaruns@nu.ac.th', 'RESEARCHER', 0, NULL, 'Jarun', 'Sayasathid', '1996-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('af1275c3-8fc5-466a-b76e-d601562c9629', 'Jaruwat Khunrat', '56659491600@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Jaruwat', 'Khunrat', '1998-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f1db94a7-12e7-4234-8c65-a053efa78249', 'Jeerawat Sawatdiwithayayong', '36554712900@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Jeerawat', 'Sawatdiwithayayong', '2002-07-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c4bde4fa-bd52-4142-9da7-b802064a28e7', 'Jeranan Inpad', '60142790500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Jeranan', 'Inpad', '2019-12-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('3105c3d4-bdc1-4628-b583-8d2eb845ecc1', 'Jiranun Weerakul', 'jiranunw@nu.ac.th/jiranunly@gmail.com', 'RESEARCHER', 0, NULL, 'Jiranun', 'Weerakul', '1996-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d9c4b71b-bbf7-4bf0-b8a3-de196fdc09a4', 'Jiroje Jiranukool', 'jirojej@hotmail.com', 'RESEARCHER', 0, NULL, 'Jiroje', 'Jiranukool', '2007-04-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e223ec79-c124-46fb-8aa1-cc7ad0e9912d', 'Jongchai Tinlapat', '57201061816@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Jongchai', 'Tinlapat', '2016-03-01', '2017-06-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('0b0f29d6-8e31-46e2-8da8-8368d341b889', 'Julintorn Somran', '8508640700@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Julintorn', 'Somran', '1996-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('38b99e53-e49f-4cf3-aa1b-e07b8954de28', 'Kamonchanok Nobphuek', 'paparii.kamon@gmail.com', 'RESEARCHER', 0, NULL, 'Kamonchanok', 'Nobphuek', '2017-07-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('9f327ee9-4b81-4330-bbb7-ec2120aa54f0', 'Kamonnop Sahasoonthorn', 'Tungkamonnop@gmail.com', 'RESEARCHER', 1, NULL, 'Kamonnop', 'Sahasoonthorn', '2020-05-18', '2023-04-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('2e748213-c07b-43d7-894d-a7c44a3961cf', 'Kamontorn Insan', '58865766700@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Kamontorn', 'Insan', '2025-05-19', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('7620a575-4b44-4e4a-bb8f-2151a50946ba', 'Kanin Luangsawang', '55332949100@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Kanin', 'Luangsawang', '2008-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('5fd902da-50a9-4708-8f56-edc79ad09973', 'Kanjanaporn Chuesakul', 'forebbnuh@gmail.com', 'RESEARCHER', 0, NULL, 'Kanjanaporn', 'Chuesakul', '2009-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('80684f4f-efe0-4c72-858e-8d15f846907c', 'Kanokwan Iramaneerat', '37012738200@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Kanokwan', 'Iramaneerat', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('61362b4f-8788-42a9-a81c-203c229bc38f', 'Kanrawee Sungprem', 'kanrawees@nu.ac.th', 'RESEARCHER', 0, NULL, 'Kanrawee', 'Sungprem', '2002-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('da9a8bff-07d0-45d5-9703-53eb847f666f', 'Kanyarat Kongnatthasate', 'kongnatthasate.kanyarat@gmail.com', 'RESEARCHER', 1, NULL, 'Kanyarat', 'Kongnatthasate', '2021-05-17', '2025-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('fb1a01ba-0baa-4504-91e1-033a0325e109', 'Khanittha Lairakdomrong', 'l_khanittha@yahoo.com', 'RESEARCHER', 1, NULL, 'Khanittha', 'Lairakdomrong', '2000-04-18', '2018-12-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('17cf0f66-62c2-47f0-a46f-fd02718662c6', 'Kitsana Utapom', 'todoroki_nuy@hotmail.com', 'RESEARCHER', 1, NULL, 'Kitsana', 'Utapom', '2013-05-20', '2019-08-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('3b33f154-9e4a-4402-b307-ca41612d9f31', 'Kitti Tantrawiwat', 'bank4501009@gmail.com', 'RESEARCHER', 1, NULL, 'Kitti', 'Tantrawiwat', '2011-04-01', '2018-10-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('37a19ddd-168d-4650-a521-e85c4663c5f5', 'Kittiporn Klangsombat', '60021760300@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Kittiporn', 'Klangsombat', '2025-05-19', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('10ef49b7-184a-4dd2-a4ec-7cbdbb7eca41', 'Klaita Srisingh', 'klaitas@nu.ac.th', 'RESEARCHER', 0, NULL, 'Klaita', 'Srisingh', '2001-04-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('9245ef80-7cf8-4fa0-babd-e1cdca6b5a02', 'Kongpob Reosanguanwong', 'reosanguanwong_k@hotmail.com', 'RESEARCHER', 0, NULL, 'Kongpob', 'Reosanguanwong', '2014-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8abc2596-4aba-4bda-99f7-f50fcfafcdf5', 'Kornthip Jeephet', '57191252938@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Kornthip', 'Jeephet', '2018-03-05', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('905b376d-8230-4e26-b2ab-51c61b9243e0', 'Krittaporn Phruksarudee', 'peetty5@hotmail.com', 'RESEARCHER', 1, NULL, 'Krittaporn', 'Phruksarudee', '2020-05-18', '2024-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4258831c-9805-4daf-8907-3b75481b36dc', 'Kullanit Pangwangthong', 'kullanitp@hotmail.com', 'RESEARCHER', 0, NULL, 'Kullanit', 'Pangwangthong', '2003-02-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('dc4b0b26-a7b6-43af-b6be-219f23d9bae4', 'Kwansuda Supalap', 'Kwansudas@nu.ac.th', 'RESEARCHER', 0, NULL, 'Kwansuda', 'Supalap', '2005-10-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e57497b9-12c3-4f62-a9e7-1a140f4d4cc8', 'La-Or Chompuk', '57189381876@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'La-Or', 'Chompuk', '1995-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('3b94bb1c-4974-4ee9-82ec-751b33f6a1ff', 'Manatsanan Kupharangchotsin', 'Thupkaew123@hotmail.com', 'RESEARCHER', 0, NULL, 'Manatsanan', 'Kupharangchotsin', '2010-08-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a177b5e8-6f53-4399-a934-5e21fe3eaee6', 'Mantana Prakassajjatham', '57190178640@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Mantana', 'Prakassajjatham', '2010-05-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('5d327767-538e-47a7-81bf-0273f2d367df', 'Matanaporn Jungmankong', 'mint.matanaporn@gmail.com', 'RESEARCHER', 0, NULL, 'Matanaporn', 'Jungmankong', '2022-05-23', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('12e4192b-6bd8-40f2-87e2-c8bb5ed31631', 'Mathayan Sanjaiban', 'mathayan1351@gmail.com', 'RESEARCHER', 0, NULL, 'Mathayan', 'Sanjaiban', '2014-02-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('86c9b2db-b12f-4392-843f-7dd96bd77c1e', 'Mayuree Montriwet', '56925514800@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Mayuree', 'Montriwet', '2010-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('34133cdd-1667-49f9-a799-08d33a09fe5a', 'Mayuree Saksiriyadakun', '58365223600@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Mayuree', 'Saksiriyadakun', '2004-04-02', '2025-06-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8ae342bc-aae1-400a-8cb4-68662002660b', 'Monthira Samaisombat', '59271731300@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Monthira', 'Samaisombat', '2016-10-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('33bde7e0-34b7-41ad-b767-5d4b46373808', 'Monton Galassi', 'bombynog@yahoo.com', 'RESEARCHER', 0, NULL, 'Monton', 'Galassi', '1994-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('44dfce07-bd14-4feb-9f1a-50601b413b98', 'Muanchanok Surit', '57218658698@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Muanchanok', 'Surit', '2008-04-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('5c245818-8292-4c4c-abc0-f94df55f44f6', 'Nadda Padsee', '57219878074@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Nadda', 'Padsee', '2014-01-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('bb695909-87cf-4bcf-ab9b-22a25c367213', 'Napat Vimtrimate', 'napat.vim@gmail.com', 'RESEARCHER', 1, NULL, 'Napat', 'Vimtrimate', '2020-05-18', '2024-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('1395aab4-351e-491d-8a7f-7fbfa58d68f8', 'Natapol Supanatsetakul', '57188649690@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Natapol', 'Supanatsetakul', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('7ed2992c-cbba-4759-ab08-2194984f0c3e', 'Natpatsorn Mongkolareepong', '57609620200@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Natpatsorn', 'Mongkolareepong', '2018-05-21', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('26459b62-62c5-4204-b852-f47d0d78d465', 'Nattamol Kosaiyaganonth', '57958606400@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Nattamol', 'Kosaiyaganonth', '2018-05-21', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f793aec8-addd-44fd-ad38-73f9cc7efecb', 'Nattapong Mekhasingharak', '56436610100@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Nattapong', 'Mekhasingharak', '2009-06-08', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('329afdf0-2a63-4d03-b1b6-16775bead2c5', 'Nattharut Chaibhuddanugul', '57209221111@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Nattharut', 'Chaibhuddanugul', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('802a79fb-8dfa-4d46-b33f-da5d73e84487', 'Nisakorn Deesaen', 'fang_bodin2@hotmail.com', 'RESEARCHER', 0, NULL, 'Nisakorn', 'Deesaen', '2020-05-18', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b3f1eb0b-a316-4445-aa54-7eff01e0b5c7', 'Nisit Poolthananant', 'joenisit@gmail.com', 'RESEARCHER', 0, NULL, 'Nisit', 'Poolthananant', '2021-06-29', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a4e02cca-8831-4811-bd2d-23de417172a6', 'Non Sowanna', '55970916500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Non', 'Sowanna', '2002-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('75e9814a-6971-466c-b056-8a81221f26b3', 'Nongluk Oilmungmool', '55001764400@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Nongluk', 'Oilmungmool', '2007-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e412c894-b986-431b-a4d8-3f16149bddbd', 'Noppakao Kongtal', 'Kongtalnoppakao@gmail.com', 'RESEARCHER', 0, NULL, 'Noppakao', 'Kongtal', '2007-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('44dc633e-d787-4c84-9573-9095b29c79a8', 'Nopparat Santisathaporn', '59004595600@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Nopparat', 'Santisathaporn', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ca17b2c6-62dd-45df-8425-52ed6425d165', 'Nuanluck Yupensuk', 'nuan_tuk@hotmail.com', 'RESEARCHER', 0, NULL, 'Nuanluck', 'Yupensuk', '2010-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e1123a72-1856-492a-af9a-9088a0d30ca9', 'Nun Singpan', '57221439666@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Nun', 'Singpan', '2017-07-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('97a19cce-c47b-47a8-83dc-ba8f13c466c8', 'Ongartl Lertkajornsin', '8938184000@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Ongartl', 'Lertkajornsin', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e75738de-c50e-4f8d-81d2-ca7220645fa2', 'Oranicha Pimpha', '57197837816@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Oranicha', 'Pimpha', '2008-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('7f593040-8bd7-454f-82f4-bb284f92a813', 'Orawan Kumcharoenkun', '59374055500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Orawan', 'Kumcharoenkun', '2007-05-04', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('62612a34-f542-41fd-9f29-6e0b4678fd89', 'Pailin Paspitsanu', 'linlycardio@gmail.com', 'RESEARCHER', 1, NULL, 'Pailin', 'Paspitsanu', '2002-04-01', '2020-05-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c8b29f71-5693-4f42-9ebf-2be3cac3883a', 'Paisit Kosum', 'paisitkosum7@gmail.com', 'RESEARCHER', 0, NULL, 'Paisit', 'Kosum', '2014-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ec4b776f-4681-4dbf-bc4f-809a8690f199', 'Paitoon Chuangchum', '57194601332@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Paitoon', 'Chuangchum', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('2d6032d6-4068-4b3a-8e06-4f11c1a24b10', 'Pakakrong Patigburt', 'pakakrong.gift@gmail.com', 'RESEARCHER', 0, NULL, 'Pakakrong', 'Patigburt', '2018-05-21', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('767a6b7f-5917-4fca-8e1c-4448506d7bbb', 'Pantitra Singkheaw', '57219862705@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Pantitra', 'Singkheaw', '2010-05-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('782110f5-214f-4211-b9ad-28ca8d243cc3', 'Panuwat Chuemor', 'Panuwatc@nu.ac.th', 'RESEARCHER', 0, NULL, 'Panuwat', 'Chuemor', '2007-04-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('95f37fbd-7563-4610-acce-f2b915023499', 'Paphawadee Sukboonthong', '57211910747@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Paphawadee', 'Sukboonthong', '2019-05-21', '2022-01-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8eb447bf-7b03-429a-9646-23127632f6b0', 'Parin Samapath', 'palm-@live.com', 'RESEARCHER', 0, NULL, 'Parin', 'Samapath', '2019-05-21', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('811e862e-6776-44b5-9117-46aa591a3cc1', 'Pariphat Chompoonutprapa', 'Pariphatc@nu.ac.th', 'RESEARCHER', 0, NULL, 'Pariphat', 'Chompoonutprapa', '2016-05-16', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('cacaa61b-2f01-4cd3-9da4-a80955d3f73c', 'Passakorn Teekaweerakit', '57221950183@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Passakorn', 'Teekaweerakit', '2018-05-21', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ff8a9507-0a1f-4643-a916-025d1ff3ea97', 'Pasuporn Pongernnak', '57193647413@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Pasuporn', 'Pongernnak', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('62b2eaa1-b3fd-45ff-8261-8247e62dd0d1', 'Patcharada Amatyakul', 'patcharadaa@nu.ac.th_x000D_
pamatyakul@hotmail.com', 'RESEARCHER', 0, NULL, 'Patcharada', 'Amatyakul', '2006-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ea1372c8-0cd3-4091-b76b-1ea2431016fa', 'Patcharin Intarakhao', '57193547669@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Patcharin', 'Intarakhao', '2010-05-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('74cd0881-8067-4ef8-bdad-035262732276', 'Patcharin Pingmuangkaew', '55123118200@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Patcharin', 'Pingmuangkaew', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b6ec6422-7d20-442e-b310-65955369fdce', 'Pattamaporn Phunsomboon', '57200969457@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Pattamaporn', 'Phunsomboon', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ddbe8327-4685-4dc4-a64b-54788fa99e04', 'Pattapong Towiwat', '55441426700@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Pattapong', 'Towiwat', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('5cb5d051-9d8b-4088-bbd2-805e4cd37bcb', 'Pattawarin Wata', 'Pattawarin_w@hotmail.com', 'RESEARCHER', 0, NULL, 'Pattawarin', 'Wata', '2013-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('51186871-aff9-4b0c-a5a3-eaa24de225a1', 'Pattrawan Supanpaiboon', '35774560100@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Pattrawan', 'Supanpaiboon', '2002-07-16', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a4338d38-7887-417b-a2e6-b7f5c383b382', 'Pawanrat Suannum', '57195347731@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Pawanrat', 'Suannum', '2013-06-17', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('df02159a-b4f3-492d-94d3-3a1757dd06e9', 'Pawin Sudbanthad', 'ake.pawins@gmail.com', 'RESEARCHER', 1, NULL, 'Pawin', 'Sudbanthad', '2021-05-17', '2023-11-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('13e30c5e-2804-499b-aba7-680c6f777297', 'Peeraphong Thiarawat', 'peeraphongt@gmail.com', 'RESEARCHER', 0, NULL, 'Peeraphong', 'Thiarawat', '2001-04-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a575b80d-ec0d-44a8-8c42-b6a319f93233', 'Peerapon Wong', 'peeraponw@nu.ac.th', 'RESEARCHER', 0, NULL, 'Peerapon', 'Wong', '1994-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('daa91e77-2e61-46b8-aaba-5f41f7f91638', 'Peerayut Sitthichaiyakul', '57857202400@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Peerayut', 'Sitthichaiyakul', '2004-08-04', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('05e6aaa4-82ca-4c7e-b2ad-03c7df49eff6', 'Phattharaphong Tantichariyangkul', '57214081297@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Phattharaphong', 'Tantichariyangkul', '2016-05-16', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a2166c86-bb35-4393-93b3-49c9930b7c97', 'Phimnipha Boonprasert', 'Phimnihab@gmail.com', 'RESEARCHER', 1, NULL, 'Phimnipha', 'Boonprasert', '2006-05-01', '2021-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ec74ba8b-1423-4f18-9b49-d332ad6fd98e', 'Phonthep Meephaikhor', 'phonthepm@nu.ac.th', 'RESEARCHER', 0, NULL, 'Phonthep', 'Meephaikhor', '2015-08-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('fb582057-4282-4b86-bffa-f6d35b5602ef', 'Phurichaya Kladcharoen', '59536513000@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Phurichaya', 'Kladcharoen', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('1074f552-6c14-4929-8a6c-94a44507d3e1', 'Pimlada Chatpitanrut', '56764627500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Pimlada', 'Chatpitanrut', '2012-07-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d74498a2-fd5c-4f9d-a1d2-b3bd84d5517e', 'Piroon Tangsripong', 'mocca_ra@hotmail.com', 'RESEARCHER', 0, NULL, 'Piroon', 'Tangsripong', '2006-04-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d30c041b-18ce-4c49-bb9f-8df604508a1e', 'Piwadee Kunmaturos', 'Piwadeek@nu.ac.th', 'RESEARCHER', 0, NULL, 'Piwadee', 'Kunmaturos', '2010-06-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('949b1055-ee6b-4d2d-8fd4-33adaae14215', 'Piyanuch Prajong', 'Dr.nuchee@hotmail.com', 'RESEARCHER', 1, NULL, 'Piyanuch', 'Prajong', '2009-04-01', '2020-01-25')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('700be3e9-876d-4bc1-9f18-72081603cb3b', 'Pongpun Jittham', 'boy_pong_photo@yahoo.com', 'RESEARCHER', 0, NULL, 'Pongpun', 'Jittham', '2004-05-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('3ec8c634-238e-4d3c-bb98-33f75a72dfd0', 'Poosit Ruengwanichayakun', '57209585946@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Poosit', 'Ruengwanichayakun', '2014-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('26897a25-5e69-49ac-9bd5-0ab891ed44f5', 'Pornnarong Jaikon', '57363851200@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Pornnarong', 'Jaikon', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('7220f9f6-e5d6-4853-991c-99fabc72140a', 'Powwasut Sonpoklang', '58866880500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Powwasut', 'Sonpoklang', '2025-05-19', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ee440146-3b41-439b-9603-7c1eaf4bd904', 'Praew Suwannasrisuk', '57191474636@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Praew', 'Suwannasrisuk', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('48859c7b-2980-478b-8454-d019bad93e8f', 'Prateep Warnnissorn', '20437105100@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Prateep', 'Warnnissorn', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('02ac02a1-148a-480b-8853-e88575125603', 'Prathana Anekpunyakul', 'prathanaa@nu.ac.th', 'RESEARCHER', 0, NULL, 'Prathana', 'Anekpunyakul', '2003-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('00cf5b55-62a1-432c-a9e0-b2391ad92868', 'Prissana Charoenporn', '6505571127@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Prissana', 'Charoenporn', '2004-10-15', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8b4fcbf4-6dc7-4b81-a4db-0838a045b7ca', 'Ptasnaporn Nontaratron', '57226840010@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Ptasnaporn', 'Nontaratron', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('5b850c3b-f352-4b4f-a641-0b16b60bfbf8', 'Punyanuch Phonngoenchai', 'punyanuchp@nu.ac.th', 'RESEARCHER', 0, NULL, 'Punyanuch', 'Phonngoenchai', '2020-05-18', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a138d558-410c-4d15-a60d-8f8b8832ee42', 'Purinon Suangyanon', 'purinon@windowlives.com', 'RESEARCHER', 1, NULL, 'Purinon', 'Suangyanon', '2007-04-02', '2018-02-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('19ddc086-636e-403e-8296-8d4861ad7d77', 'Raksit Chinnarakbumrung', '57566773400@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Raksit', 'Chinnarakbumrung', '2014-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d194ed5f-54a8-48da-b3e7-753083ee3a3e', 'Ranchana Khemphet', '57553015800@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Ranchana', 'Khemphet', '2018-05-21', '2022-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f3255af0-156d-4375-b758-660ba9ef016d', 'Ratchadaporn Somkrua', 'pai_ratchadaporn@gmail.com', 'RESEARCHER', 1, NULL, 'Ratchadaporn', 'Somkrua', '2015-09-01', '2019-01-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('6977e9e8-7485-4907-ae73-178eba1d427f', 'Ratchanok Kandee', '23569107500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Ratchanok', 'Kandee', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('00869425-40f5-4e41-95e3-3417a301ae1d', 'Rawisut Deoisares', 'rawisut3807@gmail.com', 'RESEARCHER', 0, NULL, 'Rawisut', 'Deoisares', '2004-05-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('56002717-92dc-47a5-93f6-07314211d7e9', 'Rossukon Khotcharrat', '56786606100@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Rossukon', 'Khotcharrat', '2004-05-04', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8c2ec722-d9ec-4fdc-9909-03c305ccde9e', 'Sagoontee Inkate', '60119680000@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Sagoontee', 'Inkate', '2025-09-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('3ce8a684-a71d-4586-8a14-12d4188e6060', 'Sakchai Chaiyamahapurk', '36717474000@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Sakchai', 'Chaiyamahapurk', '2017-06-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4a8ae660-39e6-4acb-a333-d5b23a81bdcd', 'Santi Weerakul', 'jswe2000@yahoo.com', 'RESEARCHER', 0, NULL, 'Santi', 'Weerakul', '1996-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('275887aa-2724-4d79-a1e3-1dca7044a0f3', 'Saran Malisorn', 'smalisorn@gmail.com', 'RESEARCHER', 0, NULL, 'Saran', 'Malisorn', '2012-11-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('95baccbf-9d6c-4692-9a05-61d2bc2dc5da', 'Saran Worasakwutiphong', 'saranw@nu.ac.th', 'RESEARCHER', 0, NULL, 'Saran', 'Worasakwutiphong', '2007-07-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('27f281ea-9a2d-4c3e-8abf-ba12a570740f', 'Sarinya Sattanon', 'tui2521@yahoo.com', 'RESEARCHER', 0, NULL, 'Sarinya', 'Sattanon', '2004-05-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e94dd5b2-f217-468d-b244-e80e000ac3dd', 'Sarunya Srijuntongsiri', 'sarnyachin@gmail.com', 'RESEARCHER', 0, NULL, 'Sarunya', 'Srijuntongsiri', '2001-04-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8a60a726-e16f-40ad-befd-2c1243e3eaed', 'Sasathorn Tharapoom', '59559303500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Sasathorn', 'Tharapoom', '2017-05-22', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('75af1b46-fe2b-49e2-9297-be7e984313a5', 'Sathon Thum-Umnuaysuk', 'ranchumu@hotmail.com', 'RESEARCHER', 0, NULL, 'Sathon', 'Thum-Umnuaysuk', '1999-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('6bdc9f42-5516-4896-a052-de47e90e42e8', 'Sawichayaporn Jermnim', '57195346302@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Sawichayaporn', 'Jermnim', '2002-08-08', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b18dc326-7cd2-44cc-b7f7-a99f8379d7b4', 'Setthachai Piwchan', '57220778620@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Setthachai', 'Piwchan', '2016-05-16', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('65981899-7138-4c28-acad-97ec8cd008e8', 'Siraphop Thapmongkol', 'giganticcvt@hotmail.com', 'RESEARCHER', 0, NULL, 'Siraphop', 'Thapmongkol', '2002-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('bb5599d3-41dc-4bb5-beaf-ed0356f7bcd6', 'Sirikanya Wairit', '59399374400@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Sirikanya', 'Wairit', '2009-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4431729c-a04b-44d9-877a-1f83a6824a89', 'Sirikarn Tananoo', '58906526600@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Sirikarn', 'Tananoo', '2023-08-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d6f97db6-3eb3-4241-b79a-5d696f29c9a8', 'Sirikasem Sirilak', 'Drsirikasem@yahoo.com', 'RESEARCHER', 1, NULL, 'Sirikasem', 'Sirilak', '1999-07-30', '2024-08-15')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('6e12b8db-ed87-4458-a924-1d3d17dfe087', 'Siriluk Toolyodpun', '57208236039@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Siriluk', 'Toolyodpun', '2006-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('24d29f26-011d-48ce-8eeb-bde213da9e58', 'Sirinan Treeyawedkul', '58601221100@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Sirinan', 'Treeyawedkul', '2004-10-04', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('37c487a3-09ff-4d1f-bb6c-cc0923f10b36', 'Sirirat Bunarsa', 'Siriratbu@nu.ac.th', 'RESEARCHER', 0, NULL, 'Sirirat', 'Bunarsa', '2012-03-16', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('71de2cc2-f724-45f2-810f-729f92f91cbb', 'Siroratt Narkcham', 'por42738@gmail.com', 'RESEARCHER', 1, NULL, 'Siroratt', 'Narkcham', '2012-05-01', '2022-12-21')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c6b65b32-13f8-4d1c-8d11-2278fe696923', 'Sivaporn Pondeenana', 'tivasha39@gmail.com', 'RESEARCHER', 0, NULL, 'Sivaporn', 'Pondeenana', '2010-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('da008470-a84b-4a14-837b-12794accf84d', 'Siwapon Munsing', '56601469700@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Siwapon', 'Munsing', '2013-05-20', '2024-06-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('94872f44-9212-4045-ab13-a2fc02bfabc2', 'Sorasit Inchan', 'Iplatwo@gmail.com', 'RESEARCHER', 1, NULL, 'Sorasit', 'Inchan', '2018-05-21', '2023-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('9d469697-7d00-46ec-8ef6-33bea9342d88', 'Sudarat Isaravisavakul', 'pan_oon@hotmail.com', 'RESEARCHER', 0, NULL, 'Sudarat', 'Isaravisavakul', '2011-12-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c3cb1e25-ff44-4013-a9aa-d56f85b3543a', 'Sujitra Tinnut', '57407416600@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Sujitra', 'Tinnut', '2014-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('84644179-2268-4f42-934a-22d1dca6f179', 'Sukanya Rakkhajeekul', '56027974300@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Sukanya', 'Rakkhajeekul', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4891e30c-3c28-4b50-bc94-b6775735dc0f', 'Supachok Rasamimongkol', '57193651298@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Supachok', 'Rasamimongkol', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f6ca70d1-b905-4c27-8d68-ce1e48405f20', 'Supasit Pannarunothai', '6603611723@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Supasit', 'Pannarunothai', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('66984a76-4370-41eb-9c63-370a22f7aa1b', 'Supathida Yoocharoen', 'ace.athin@gmail.com', 'RESEARCHER', 1, NULL, 'Supathida', 'Yoocharoen', '2021-05-17', '2025-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('441f9b3b-4cc3-422d-9f15-eb1a7ff197b4', 'Supattra Tipsuwan', 'supattrat@nu.ac.th', 'RESEARCHER', 0, NULL, 'Supattra', 'Tipsuwan', '2006-10-16', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('110af878-1d9c-432f-bedf-c6be9e81c742', 'Supawadee Makanut', 'supawadee_makanut@hotmail.com', 'RESEARCHER', 0, NULL, 'Supawadee', 'Makanut', '2000-04-18', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('09753f44-0fac-43d3-b2b3-5d5820887d55', 'Suphakit Khutanthong', 'mut2535@gmail.com', 'RESEARCHER', 0, NULL, 'Suphakit', 'Khutanthong', '2023-05-18', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('63287436-e4bc-4f13-81a4-ad7bdab0931d', 'Supinda Sirilak', 'asupindasirilak@gmail.com', 'RESEARCHER', 1, NULL, 'Supinda', 'Sirilak', '2004-04-02', '2024-12-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('1f5f6e6c-161d-4c4c-a9b0-a6307507af8e', 'Suppana Chuensakul', 'devil_bas@hotmail.com', 'RESEARCHER', 0, NULL, 'Suppana', 'Chuensakul', '2010-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4b839036-5974-44bc-b478-a7af2d488ae3', 'Surachart Pojanasupawun', '57218827332@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Surachart', 'Pojanasupawun', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('10ab6bda-fc2e-44cf-b44f-eb8847608ce6', 'Sutatip Pongcharoen', 'sutatipp@nu.ac.th', 'RESEARCHER', 0, NULL, 'Sutatip', 'Pongcharoen', '2002-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('5b798cb5-57cc-410a-b3c1-1173a8fb9b6c', 'Suthasinee Poomiphol', '57190748493@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Suthasinee', 'Poomiphol', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('1ab86287-f8ba-4142-b29b-0798d9b359b5', 'Suthasinee Thamaree', 'sthamaree@yahoo.com', 'RESEARCHER', 1, NULL, 'Suthasinee', 'Thamaree', '2000-04-18', '2018-12-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('533c4176-e786-425f-a41d-6651a0bc4318', 'Sutida Sasjeenpong', 'aeakatha323@gmail.com', 'RESEARCHER', 0, NULL, 'Sutida', 'Sasjeenpong', '2009-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c127e27c-15a4-48c4-b963-55462c07c821', 'Suwanna Boonsirichan', '57715294000@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Suwanna', 'Boonsirichan', '2017-05-22', '2021-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a67179d0-f94b-4aef-8fcf-b5bd96f32acd', 'Suwannee Uthaisangsook', 'suwannee_u@yahoo.com', 'RESEARCHER', 0, NULL, 'Suwannee', 'Uthaisangsook', '1997-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('bda21b10-a9fc-41ea-afff-d7cff85bbbe8', 'Suwannika Palee', 'suwannikap@gmail.com', 'RESEARCHER', 0, NULL, 'Suwannika', 'Palee', '2014-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('0d8ec01c-677e-4194-985e-731f6405b701', 'Suwimon Nabumrung', '60126917200@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Suwimon', 'Nabumrung', '2018-10-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ef808d97-3f1e-4d27-8b79-fef3ef22794b', 'Tanapron Termwattanaphakdee', '36011046500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Tanapron', 'Termwattanaphakdee', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8da6ef26-93be-498f-863a-e332bd285380', 'Tanate Chira-Adisai', '57217166491@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Tanate', 'Chira-Adisai', '2009-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('7b6f2c17-9b12-40e5-9688-bbf05dbd6a05', 'Taniya Bhoopat', '57211910717@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Taniya', 'Bhoopat', '2015-08-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('01e893ea-cee0-4340-8447-7992a13d1d98', 'Taniya Wongwan', 'taniyaw@nu.ac.th', 'RESEARCHER', 1, NULL, 'Taniya', 'Wongwan', '2012-01-04', '2019-04-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('63b4df91-9058-4e8a-9c01-33dfc275ea39', 'Temporn Kruamak', '57196038758@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Temporn', 'Kruamak', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('fc0fbfe7-236e-4a18-b391-8c46f6c6f164', 'Thadpong Chanton', '57211311804@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Thadpong', 'Chanton', '2013-06-03', '2015-08-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b3d28740-a2f0-4bd6-8504-c62976869777', 'Thanakorn Laksomya', '57190751589@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Thanakorn', 'Laksomya', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a82c3b5a-2d67-4f72-9631-d5a701fd5481', 'Thanawan Damrongkitchaiporn', '57211387559@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Thanawan', 'Damrongkitchaiporn', '2016-05-16', '2019-03-31')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b7ac20a4-021a-474e-aada-cc2a297e4c5e', 'Thanin Chattrapiban', '35774313600@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Thanin', 'Chattrapiban', '2007-10-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a3743b3a-8d76-4c94-86b9-37ea0e6b6348', 'Thanyasiri Jindayok', '27368152600@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Thanyasiri', 'Jindayok', '2006-05-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('7aa6f48f-303f-42cc-8886-f6cbead63f28', 'Thapanik Pongprapai', 'thapanik.pong@gmail.com', 'RESEARCHER', 1, NULL, 'Thapanik', 'Pongprapai', '2013-05-01', '2019-02-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('2950d0e6-d82b-4da3-bd7b-d8734590132d', 'Theerachai Thammathiwat', 'T.thammathiwat@gmail.com', 'RESEARCHER', 0, NULL, 'Theerachai', 'Thammathiwat', '2011-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('caf2bffc-e300-42ee-8011-403179fb8f5a', 'Theeradej Tepkasetkul', '57211390543@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Theeradej', 'Tepkasetkul', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('96b67f39-535d-4aca-ba6b-c45256656731', 'Thitima Ngoenmak', 'thitiman@nu.ac.th.', 'RESEARCHER', 0, NULL, 'Thitima', 'Ngoenmak', '2004-04-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4ed8ec73-1170-4c7e-ad4e-f7202db0c699', 'Thuchchai Srisen', 'thuchchais@nu.ac.th', 'RESEARCHER', 0, NULL, 'Thuchchai', 'Srisen', '2019-03-08', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4759b999-08b2-41fd-9762-25430cb8c345', 'Veeraphatra Wongsantimeth', '58602325300@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Veeraphatra', 'Wongsantimeth', '2020-05-18', '2023-05-18')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8cf304ae-5913-4afc-8cca-81caf758138b', 'Waneerat Galassi', '15062620000@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Waneerat', 'Galassi', '1994-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b13404df-777e-4705-9477-053c3d9210a5', 'Warisa Poonnarattanakul', '57221920935@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Warisa', 'Poonnarattanakul', '2017-05-22', '2021-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('ea8c08fe-2aea-4d2a-8419-991ad0f37ab8', 'Wasee Lertkajornsin', 'wasee13@gmail.com', 'RESEARCHER', 0, NULL, 'Wasee', 'Lertkajornsin', '2003-03-04', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('09d3c2d6-7ed3-4aea-bbd1-a8b5e9239275', 'Watchara Pichitsiri', 'pichitsiri@hotmail.com', 'RESEARCHER', 0, NULL, 'Watchara', 'Pichitsiri', '2002-07-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e531eb49-4bb7-49c3-b07b-6e59933496e0', 'Watcharapong Eiamjumras', 'newwatch@hotmail.com>', 'RESEARCHER', 1, NULL, 'Watcharapong', 'Eiamjumras', '2017-05-22', '2025-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('84cfcc99-17f2-4db2-99a0-8c34d4685d89', 'Watcharaporn Taburee', '57194686289@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Watcharaporn', 'Taburee', '1998-09-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('14018be5-c55a-4847-b75a-3844d84a23f2', 'Weerapong Prayulsatien', 'werapray@hotmail.com', 'RESEARCHER', 0, NULL, 'Weerapong', 'Prayulsatien', '2001-04-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('77f60663-695f-4ae2-848d-c03a957a99a8', 'Wikunda Limpiangkanan', '36166880000@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Wikunda', 'Limpiangkanan', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d0e05fb3-77b6-42c0-aaee-5e95ab7bdbe8', 'Wipawadee Boonmak', '57214672565@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Wipawadee', 'Boonmak', '2018-08-01', '2022-02-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d39af74a-4471-4a10-a32d-a7697245033a', 'Wittawat Jitpewngarm', 'starplatinum07@hotmail.com', 'RESEARCHER', 0, NULL, 'Wittawat', 'Jitpewngarm', '2000-04-18', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('443e1d86-b063-4b43-b331-56417375df5a', 'Worapong Lueyam', '59772428000@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Worapong', 'Lueyam', '2024-05-16', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('38047ae1-40b8-4065-b943-56f4e731e3d4', 'Worawan Jittham', 'worawanji@nu.ac.th', 'RESEARCHER', 0, NULL, 'Worawan', 'Jittham', '2004-05-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('84984a32-5d3d-4291-84aa-f4e1e25fbbcc', 'Yasinee Apiraknapanon', 'yasineea@nu.ac.th', 'RESEARCHER', 0, NULL, 'Yasinee', 'Apiraknapanon', '2005-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('3e0cc3b7-ebad-4c9a-b48c-5a6b5df0d55e', 'Yuthapong Buddharaksa', '55789207900@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Yuthapong', 'Buddharaksa', '2003-11-03', '2026-03-05')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('527d7632-76ff-4a19-b518-48b535e14763', 'Bhuwad Chinwatanawongwan', 'bhuwad_j@hotmail.com', 'RESEARCHER', 0, NULL, 'Bhuwad', 'Chinwatanawongwan', '2015-07-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('64c123d9-bed8-4460-8e71-6a47bf573b3a', 'Atipotsawee Tungsupreechameth', 'atungsupreechameth@gmail.com', 'RESEARCHER', 0, NULL, 'Atipotsawee', 'Tungsupreechameth', '2017-05-22', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('759cbfe2-6c25-4c61-ad96-0ab74c1b7f12', 'Chawisachon Nonsri', 'Chawisachon@gmail.com', 'RESEARCHER', 0, NULL, 'Chawisachon', 'Nonsri', '2016-05-16', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4f965782-a196-4c65-b883-00622fe2303d', 'Chayakamon Niyasom', 'chayakamonn@gmail.com', 'RESEARCHER', 1, NULL, 'Chayakamon', 'Niyasom', '2016-05-16', '2024-04-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a436de2f-8c92-4d16-a51f-c445665fd21b', 'Jirapon Jesrichai', '59143774500@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Jirapon', 'Jesrichai', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8f93c565-4b1c-4e78-8466-c1d498ca2d6a', 'Jittima Monwiratkul', 'j.monwiratkul@gmail.com', 'RESEARCHER', 0, NULL, 'Jittima', 'Monwiratkul', '2020-03-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f3700a23-4130-4ae0-a265-d865cf1d7ae2', 'Kongpop Sutantikorn', 'kongpops@nu.ac.th', 'RESEARCHER', 0, NULL, 'Kongpop', 'Sutantikorn', '2020-05-18', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('eb4a4e45-85d7-4bd5-bf89-3ce09517adc5', 'Kritsana Kumphet', '57224560409@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Kritsana', 'Kumphet', '2023-05-01', '2024-12-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c06e6252-59cd-460a-9b43-bc6e4e778a8d', 'Kwanchanok Areewong', '58906700800@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Kwanchanok', 'Areewong', '2007-07-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('001db516-5a7b-4e53-ba37-eb36df6e495b', 'Nathapon Treewipanon', '58650860300@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Nathapon', 'Treewipanon', '2015-05-18', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d56e527f-5658-444f-99a0-39ffd7bee814', 'Nutjakorn Wilairat', 'nutjakorn.wi@gmail.com', 'RESEARCHER', 1, NULL, 'Nutjakorn', 'Wilairat', '2020-10-01', '2021-03-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4c01cb81-e6f8-4df2-835e-fb44cc55cecb', 'Panapol Varakornpipat', '57208244786@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Panapol', 'Varakornpipat', '2014-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('dbdb4f43-1d82-4ad9-94bb-ecc6b4416c61', 'Panotsom Ngowyutagon', 'katepa@hotmail.com', 'RESEARCHER', 1, NULL, 'Panotsom', 'Ngowyutagon', '2007-06-01', '2018-01-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8998e697-bb3c-427f-b280-54d56e6d0452', 'Paweena Phaholthep', '57224535722@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Paweena', 'Phaholthep', '2011-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8063b1c6-b221-4deb-a94f-e193e4d1d5f9', 'Piyatida Chumnumsiriwath', 'piyatida_21@hotmail.com', 'RESEARCHER', 0, NULL, 'Piyatida', 'Chumnumsiriwath', '2020-12-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('dcc56bc4-0401-4063-a8bf-c74fd3f47439', 'Ravisara Opascharoenkij', 'Ravisara.bow@gmail.com', 'RESEARCHER', 0, NULL, 'Ravisara', 'Opascharoenkij', '2021-05-17', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b5950729-6827-45e4-bd80-90a1b6c7999b', 'Rawee Jongkongkawutthi', 'vee_one@msn.com', 'RESEARCHER', 1, NULL, 'Rawee', 'Jongkongkawutthi', '2017-05-22', '2025-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('cb81416b-7c5d-431c-bbf6-272d987a73fa', 'Supalert Prakhunhungsit', '57073834700@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Supalert', 'Prakhunhungsit', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('db485b0f-04e1-4c97-a7a0-df0e78eec299', 'Suri Tangchitthavorngul', '57564596000@placeholder.iram.edu', 'RESEARCHER', 0, NULL, 'Suri', 'Tangchitthavorngul', '2014-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c8cded8d-0abd-4253-a3c6-2551b5d3c72c', 'Thanachat Rutnumnoi', '57222611562@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Thanachat', 'Rutnumnoi', '2015-05-18', '2026-03-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('52620437-3c60-4b84-b01a-90eb28288916', 'Thanawat Tantimethanon', 'Tantimethanon.thanawat@gmail.com>', 'RESEARCHER', 0, NULL, 'Thanawat', 'Tantimethanon', '2017-05-22', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('92443b34-baf5-4dc3-a316-c396c820368b', 'Udomsak Tangchaisuriya', 'Udomsak.md@gmail.com', 'RESEARCHER', 1, NULL, 'Udomsak', 'Tangchaisuriya', '2014-05-01', '2022-02-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('02a15332-72b1-4a83-ad60-f229b4989212', 'Wattakorn Laohapiboolrattana', '58536889900@placeholder.iram.edu', 'RESEARCHER', 1, NULL, 'Wattakorn', 'Laohapiboolrattana', '2023-09-01', '2026-05-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e3c61420-d988-477a-9990-bb43567ae679', 'Achiraya Thonghem', 'no-email-e3c61420@nu.ac.th', 'RESEARCHER', 0, NULL, 'Achiraya', 'Thonghem', '2013-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b3ff17b8-32da-4ffd-a012-8229db1380d1', 'Chonlakorn Kumhame', 'no-email-b3ff17b8@nu.ac.th', 'RESEARCHER', 1, NULL, 'Chonlakorn', 'Kumhame', '2020-05-18', '2024-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c2f0d7c5-4d0c-4eda-8737-d2335f339ec5', 'Jarupat Promkhiamon', 'no-email-c2f0d7c5@nu.ac.th', 'RESEARCHER', 0, NULL, 'Jarupat', 'Promkhiamon', '2024-05-23', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('bf6ba325-986f-44cd-8e89-daa19a244fb8', 'Kochaporn Pipatpongsophon', 'no-email-bf6ba325@nu.ac.th', 'RESEARCHER', 0, NULL, 'Kochaporn', 'Pipatpongsophon', '2024-05-23', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c42ab381-78d9-4513-a199-50bf965b64fc', 'Krerkrit Kitpongpans', 'no-email-c42ab381@nu.ac.th', 'RESEARCHER', 0, NULL, 'Krerkrit', 'Kitpongpans', '2007-04-02', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f8f2cccc-b93f-44e0-8e56-6e5b57f4b8d0', 'Matina Phanacharoensawad', 'no-email-f8f2cccc@nu.ac.th', 'RESEARCHER', 1, NULL, 'Matina', 'Phanacharoensawad', '2022-05-23', '2025-05-23')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8a3ec93f-acae-4df5-9c03-cf3a15230dfb', 'Nichaphat Kasemwong', 'no-email-8a3ec93f@nu.ac.th', 'RESEARCHER', 0, NULL, 'Nichaphat', 'Kasemwong', '2024-05-20', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('549547b7-eae3-451b-be41-e92845ef5b55', 'Nuttharut Chaibhuddanugul', 'no-email-549547b7@nu.ac.th', 'RESEARCHER', 0, NULL, 'Nuttharut', 'Chaibhuddanugul', '2012-06-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b6717ed7-8639-4620-8369-1ec190206d92', 'Pandaree Dokkham', 'no-email-b6717ed7@nu.ac.th', 'RESEARCHER', 0, NULL, 'Pandaree', 'Dokkham', '2022-05-23', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e1dcbb99-9aab-42f2-a63d-5c9365e35ca2', 'Parinthorn Pol-Amorn', 'no-email-e1dcbb99@nu.ac.th', 'RESEARCHER', 1, NULL, 'Parinthorn', 'Pol-Amorn', '2021-05-17', '2025-07-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4b77055e-421b-43cb-b46c-debca3a7a015', 'Patapong Towiwat', 'no-email-4b77055e@nu.ac.th', 'RESEARCHER', 0, NULL, 'Patapong', 'Towiwat', '2003-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8b00591c-7f93-4684-9837-d1baabfb5281', 'Patcharapol Toeypromthong', 'no-email-8b00591c@nu.ac.th', 'RESEARCHER', 0, NULL, 'Patcharapol', 'Toeypromthong', '2016-10-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e8bcf4b1-9bdf-418b-9ca1-5f1fc68bba13', 'Patthiya Chuenchusilp', 'no-email-e8bcf4b1@nu.ac.th', 'RESEARCHER', 0, NULL, 'Patthiya', 'Chuenchusilp', '2022-05-23', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('2c8b57c8-5800-4c36-aa11-a218e647a972', 'Peemapol Puranamaneewiwat', 'no-email-2c8b57c8@nu.ac.th', 'RESEARCHER', 0, NULL, 'Peemapol', 'Puranamaneewiwat', '2024-05-20', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('85389eab-c2a8-467f-95cb-76894fa75f07', 'Pimsiri Tengthanakij', 'no-email-85389eab@nu.ac.th', 'RESEARCHER', 0, NULL, 'Pimsiri', 'Tengthanakij', '2024-05-20', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('11483674-8431-4b35-adb5-e21333b267a1', 'Piyatida Saengon', 'no-email-11483674@nu.ac.th', 'RESEARCHER', 0, NULL, 'Piyatida', 'Saengon', '2024-05-20', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b55fb569-fe2c-49d7-9c70-5fe2f5fdebe0', 'Poonsuk Dandamrongrak', 'no-email-b55fb569@nu.ac.th', 'RESEARCHER', 1, NULL, 'Poonsuk', 'Dandamrongrak', '2011-04-01', '2026-02-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c14f77da-b20b-4588-992e-ea8fd8073577', 'Praewwanit Nitayakul', 'no-email-c14f77da@nu.ac.th', 'RESEARCHER', 1, NULL, 'Praewwanit', 'Nitayakul', '2020-05-18', '2023-05-18')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('3da783da-4dc8-44cf-879f-915911c1baf8', 'Sila Sutjarittam', 'no-email-3da783da@nu.ac.th', 'RESEARCHER', 0, NULL, 'Sila', 'Sutjarittam', '2024-05-20', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('f26ebfaa-3aac-4502-9ebc-39f27dfdcd6b', 'Songsit Russameeruttayadham', 'no-email-f26ebfaa@nu.ac.th', 'RESEARCHER', 1, NULL, 'Songsit', 'Russameeruttayadham', '2021-05-17', '2024-06-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('5be93cb3-ccc7-41a2-83db-3a68252394d9', 'Supachoke Rasamimongkol', 'no-email-5be93cb3@nu.ac.th', 'RESEARCHER', 0, NULL, 'Supachoke', 'Rasamimongkol', '2006-04-03', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c8aacc44-6e56-4087-88f1-8f0f74f6ad3c', 'Supaksarun Cheewasukanont', 'no-email-c8aacc44@nu.ac.th', 'RESEARCHER', 1, NULL, 'Supaksarun', 'Cheewasukanont', '2017-05-22', '2026-05-05')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4d7a0b10-ea1f-4fc5-aca2-7c4a334d4f8e', 'Tanaporn Sukittivarapunt', 'no-email-4d7a0b10@nu.ac.th', 'RESEARCHER', 0, NULL, 'Tanaporn', 'Sukittivarapunt', '2023-05-22', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('51ed31d5-9588-49e3-aba4-259a52664ad8', 'Tanatpim Supapornpradub', 'no-email-51ed31d5@nu.ac.th', 'RESEARCHER', 1, NULL, 'Tanatpim', 'Supapornpradub', '2021-02-01', '2025-12-01')
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('664ff2fb-309c-495b-ae7f-dd797388fec5', 'Thanakorn Ngamsouy', 'no-email-664ff2fb@nu.ac.th', 'RESEARCHER', 0, NULL, 'Thanakorn', 'Ngamsouy', '2022-05-23', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('2eb07db6-bd77-4c10-b624-012c5f5bb91c', 'Todsapon Siriwat', 'no-email-2eb07db6@nu.ac.th', 'RESEARCHER', 0, NULL, 'Todsapon', 'Siriwat', '2025-09-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a7bc0d3c-f836-4f39-8fa0-e2388c9102e4', 'Veeratape Ngamnusonkit', 'no-email-a7bc0d3c@nu.ac.th', 'RESEARCHER', 0, NULL, 'Veeratape', 'Ngamnusonkit', '2022-05-23', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d4155831-825a-4fed-88b2-e2c608753bf0', 'Winat Kaewtun', 'no-email-d4155831@nu.ac.th', 'RESEARCHER', 0, NULL, 'Winat', 'Kaewtun', '2011-04-01', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('e6c16909-9381-4f7f-bea7-24aaca2317f1', 'Wiraporn Noina', 'no-email-e6c16909@nu.ac.th', 'RESEARCHER', 0, NULL, 'Wiraporn', 'Noina', '2024-05-23', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('23b521b8-1d19-481f-991e-5f5a5b0eb88f', 'Ying Supattanawong', 'no-email-23b521b8@nu.ac.th', 'RESEARCHER', 0, NULL, 'Ying', 'Supattanawong', '2000-04-18', NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b16cba4c-631f-46f4-bf30-c1c4a6bca0c6', 'Kriangsak Ounboontham', 'no-email-b16cba4c@nu.ac.th', 'RESEARCHER', 0, NULL, 'เกรียงศักดิ์', 'อุ่นบุญธรรม', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8c03d22b-8ee1-4125-8a2d-e917c2f286c3', 'Methira Khamthong', 'no-email-8c03d22b@nu.ac.th', 'RESEARCHER', 0, NULL, 'เมธิรา', 'คำทอง', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b480bd1d-6ca8-4643-8115-df725d8a588a', 'Kangwan Pongdara', 'no-email-b480bd1d@nu.ac.th', 'RESEARCHER', 0, NULL, 'กังวาน', 'พงษ์ดารา', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('dac6f1ad-1f33-4274-bc2c-5c8aea324699', 'Yada Supasit', 'no-email-dac6f1ad@nu.ac.th', 'RESEARCHER', 0, NULL, 'ญดา', 'ศุภสิทธิ์', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('09b63de3-02b3-4ea6-96e9-0ff26793fb58', 'Yanika Jindamile', 'no-email-09b63de3@nu.ac.th', 'RESEARCHER', 0, NULL, 'ญาณิกา', 'จินดาไมล์', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('74217df7-fc99-4b70-9924-f2d2295052f8', 'Thanasit Srisombat', 'no-email-74217df7@nu.ac.th', 'RESEARCHER', 0, NULL, 'ฐานสิทธิ์', 'ศรีสมบัติ', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('bb96bfe7-1056-4be5-a654-dd7d3265dbb7', 'Natthanich Sitthithanawong', 'no-email-bb96bfe7@nu.ac.th', 'RESEARCHER', 0, NULL, 'ณัฏฐนิชญ์', 'สิทธิธนาวงศ์', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('057807c9-f34d-43c4-9c03-3a17e02ba192', 'Natthaphon Phannachet', 'no-email-057807c9@nu.ac.th', 'RESEARCHER', 0, NULL, 'ณัฐพล', 'พรรณเชษฐ์', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('4be3e41f-d6ad-4647-93f6-cccecdf1372c', 'Tiyarut Khayankit', 'no-email-4be3e41f@nu.ac.th', 'RESEARCHER', 0, NULL, 'ติยารัชต์', 'ขยันกิจ', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('dee9f094-fa90-43a4-ae61-2604b3c0444d', 'Songkiat Udompornwattana', 'no-email-dee9f094@nu.ac.th', 'RESEARCHER', 0, NULL, 'ทรงเกียรติ', 'อุดมพรวัฒนะ', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('d1f096fb-be61-43c1-bba2-0404492198c7', 'Thisayaphong Intangam', 'no-email-d1f096fb@nu.ac.th', 'RESEARCHER', 0, NULL, 'ทิศยพงษ์', 'อินตางาม', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('190bcb3c-30c2-4a04-8d30-a72ac7d6d7d8', 'Thanapong Kajhontrideth', 'no-email-190bcb3c@nu.ac.th', 'RESEARCHER', 0, NULL, 'ธนพงษ์', 'ขจรไตรเดช', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('9ffb8124-96a9-41b2-8faa-3c08f1ae8b9c', 'Nanthiwan Saesue', 'no-email-9ffb8124@nu.ac.th', 'RESEARCHER', 0, NULL, 'นันทิวัน', 'แซ่ซื้อ', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('b2d01c11-028e-45d4-9a41-f029b4036391', 'Pracha Ratjaidee', 'no-email-b2d01c11@nu.ac.th', 'RESEARCHER', 0, NULL, 'ประชา', 'ราษฎร์ใจดี', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('a6e829e1-77e7-434c-a764-a40008ded957', 'Praphan Chantanapothi', 'no-email-a6e829e1@nu.ac.th', 'RESEARCHER', 0, NULL, 'ประพันธ์', 'จันทนะโพธิ', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('c79cfdba-fd11-4738-a9e2-f14762cf24be', 'Pannaphorn Thongsuk', 'no-email-c79cfdba@nu.ac.th', 'RESEARCHER', 0, NULL, 'ปัณณพร', 'ทองสุก', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('adda68d4-adee-4847-9877-a6b0b644c835', 'Panjit Wannaphira', 'no-email-adda68d4@nu.ac.th', 'RESEARCHER', 0, NULL, 'ปานจิต', 'วรรณภิระ', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('aa517686-aa52-4130-83fc-34122f373cd0', 'Peerawit Thanasanpaiboon', 'no-email-aa517686@nu.ac.th', 'RESEARCHER', 0, NULL, 'พีรวิชญ์', 'ธนสารไพบูลย์', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8836768a-119c-4fa6-8b07-c118231f359e', 'Yotana Maphansu', 'no-email-8836768a@nu.ac.th', 'RESEARCHER', 0, NULL, 'ยตนา', 'มาพันธ์สุ', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('9d3fbebd-22e6-406b-95a2-ae59eb43960b', 'Warit Nilphanich', 'no-email-9d3fbebd@nu.ac.th', 'RESEARCHER', 0, NULL, 'วฤธ', 'นิลพานิช', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('0626360c-0be2-40e5-bd08-8873277648c3', 'Wipapond Suharitdumrong', 'no-email-0626360c@nu.ac.th', 'RESEARCHER', 0, NULL, 'วิภาพร', 'สุหฤทดำรง', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('0dd67c58-87b0-4a2c-b048-16cd56691256', 'Saran Kalantapura', 'no-email-0dd67c58@nu.ac.th', 'RESEARCHER', 0, NULL, 'ศรัณย์', 'กลันทปุระ', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('8990e713-c659-4490-bcaf-53c2b4e718aa', 'Saranya Tesprasit', 'no-email-8990e713@nu.ac.th', 'RESEARCHER', 0, NULL, 'ศรัณยา', 'เทศประสิทธิ์', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('15d26b12-ee64-4377-bbab-c54e7a16d2ad', 'Siriwan Phannachet', 'no-email-15d26b12@nu.ac.th', 'RESEARCHER', 0, NULL, 'ศิริวรรณ', 'พรรณเชษฐ์', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('0f888b19-061d-45d3-bada-c5ab34c45216', 'Santhiti Morakul', 'no-email-0f888b19@nu.ac.th', 'RESEARCHER', 0, NULL, 'สัณฐิติ', 'โมรากุล', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('edcf6e3a-e2c9-4a9d-afc3-16138393d606', 'Sitthisak Rujiraphruttiphong', 'no-email-edcf6e3a@nu.ac.th', 'RESEARCHER', 0, NULL, 'สิทธิศักดิ์', 'รุจิระพฤติพงศ์', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
INSERT INTO irUser (id, name, email, role, isDeleted, title, firstName, lastName, joinDate, resignDate)
VALUES ('790f717a-2dcc-46d4-b581-29a51050106b', 'Onicha Nakarasmee', 'no-email-790f717a@nu.ac.th', 'RESEARCHER', 0, NULL, 'อรณิชา', 'นาคะรัศมี', NULL, NULL)
ON CONFLICT(id) DO UPDATE SET
name = excluded.name,
email = excluded.email,
role = excluded.role,
isDeleted = excluded.isDeleted,
title = excluded.title,
firstName = excluded.firstName,
lastName = excluded.lastName,
joinDate = excluded.joinDate,
resignDate = excluded.resignDate;
