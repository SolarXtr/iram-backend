UPDATE irResearcherProfile
SET orcid = '0000-0002-9257-2051'
WHERE userId = (SELECT id FROM irUser WHERE name = 'Achiraya Thonghem');
