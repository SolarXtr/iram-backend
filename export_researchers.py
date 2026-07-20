import json
import csv
import os
import codecs

output_csv = r"D:\.gemini\antigravity\scratch\researchers_list.csv"

d1_data = []
try:
    with codecs.open(r"D:\.gemini\antigravity\scratch\iram-backend\d1_users.json", 'r', encoding='utf-8-sig') as f:
        data = f.read()
        if data.strip():
            # The wrangler output might have extra text before json, but assuming it's clean
            try:
                parsed = json.loads(data.strip())
                if isinstance(parsed, list) and len(parsed) > 0 and 'results' in parsed[0]:
                    for row in parsed[0]['results']:
                        if row.get('role') in ('RESEARCHER', 'EXECUTIVE', 'STAFF'):
                            d1_data.append({
                                'source': 'D1 (irUser)',
                                'id': row.get('id', ''),
                                'name_en': row.get('name', ''), 
                                'name_th': '',
                                'department': '',
                                'email': row.get('email', ''),
                                'role': row.get('role', '')
                            })
            except Exception as e:
                print("Error parsing D1 json:", e)
except Exception as e:
    print("D1 JSON file not found or unreadable:", e)

scopus_data = []
try:
    with open(r"D:\.gemini\antigravity\scratch\iram-scopus\researchers.json", 'r', encoding='utf-8-sig') as f:
        parsed = json.load(f)
        for row in parsed:
            scopus_data.append({
                'source': 'Scopus JSON',
                'id': row.get('author_id', ''),
                'name_en': row.get('name', ''),
                'name_th': '',
                'department': row.get('department', ''),
                'email': '',
                'role': 'RESEARCHER'
            })
except Exception as e:
    print("Scopus JSON file not found or unreadable:", e)

all_data = scopus_data + d1_data

# Deduplicate by name_en (case insensitive) if we wanted to, but let's just output all for mapping
with open(output_csv, 'w', encoding='utf-8-sig', newline='') as csvfile:
    fieldnames = ['source', 'id', 'name_en', 'name_th', 'department', 'email', 'role']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    for row in all_data:
        writer.writerow(row)

print("Exported to", output_csv)
