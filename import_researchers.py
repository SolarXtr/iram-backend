import csv
import uuid

csv_file = r"D:\.gemini\antigravity\scratch\researchers_list+.csv"
sql_file = r"D:\.gemini\antigravity\scratch\iram-backend\import_researchers_plus.sql"

# Avoid duplicate inserts for mock users if any are in the CSV, 
# but the user said they added names to the exported CSV which we know has 213 rows from Scopus.

with open(csv_file, 'r', encoding='utf-8-sig') as f:
    reader = csv.DictReader(f)
    
    with open(sql_file, 'w', encoding='utf-8') as out:
        out.write("-- Auto-generated SQL for migrating researchers to D1\n\n")
        
        for row in reader:
            # Generate a new UUID for irUser
            user_id = str(uuid.uuid4())
            profile_id = str(uuid.uuid4())
            
            # Extract data
            scopus_id = row.get('id', '').strip()
            name_en = row.get('name_en', '').strip().replace("'", "''")
            name_th = row.get('name_th', '').strip().replace("'", "''")
            fname_th = row.get('fname_th', '').strip().replace("'", "''")
            department = row.get('department', '').strip().replace("'", "''")
            email = row.get('email', '').strip().replace("'", "''")
            role = row.get('role', 'RESEARCHER').strip()
            
            # Handle empty email to avoid UNIQUE constraint if multiple are empty.
            # D1 allows NULLs in UNIQUE columns but email is NOT NULL. 
            # We'll use a placeholder if empty.
            if not email:
                email = f"{scopus_id}@placeholder.iram.edu"
                
            # INSERT into irUser
            out.write(f"INSERT INTO \"irUser\" (\"id\", \"name\", \"email\", \"role\") VALUES ('{user_id}', '{name_en}', '{email}', '{role}') ON CONFLICT(\"email\") DO NOTHING;\n")
            
            # INSERT into irResearcherProfile
            out.write(f"INSERT INTO \"irResearcherProfile\" (\"id\", \"userId\", \"scopusAuthorId\", \"nameTh\", \"titleTh\", \"department\") VALUES ('{profile_id}', '{user_id}', '{scopus_id}', '{name_th}', '{fname_th}', '{department}') ON CONFLICT(\"scopusAuthorId\") DO NOTHING;\n")

print(f"Generated {sql_file} successfully.")
