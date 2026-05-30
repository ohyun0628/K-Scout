import re
import urllib.request
import json
import ssl

with open('KScout/Services/KoreanTranslationService.swift', 'r', encoding='utf-8') as f:
    swift_content = f.read()

keys = re.findall(r'"([^"]+)":', swift_content)
keys = set([k.lower() for k in keys])

API_KEY = "4eb0b3baf194555ef46565fa9dc2d35d"
LEAGUES = [292, 293]
SEASON = 2023

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

def fetch_data(url):
    req = urllib.request.Request(url, headers={'x-apisports-key': API_KEY})
    with urllib.request.urlopen(req, context=ctx) as response:
        return json.loads(response.read().decode())

all_names = set()

for league in LEAGUES:
    for endpoint in ['topscorers', 'topassists']:
        url = f"https://v3.football.api-sports.io/players/{endpoint}?season={SEASON}&league={league}"
        try:
            res = fetch_data(url)
            if 'response' in res:
                for item in res['response']:
                    all_names.add(item['player']['name'])
        except Exception as e:
            pass

missing = []
for name in sorted(list(all_names)):
    lower_name = name.strip().lower()
    found = False
    if lower_name in keys:
        found = True
    else:
        for k in keys:
            if len(k) > 3 and k in lower_name:
                found = True
                break
    if not found:
        missing.append(name)

print("MISSING NAMES IN DICTIONARY:")
for name in missing:
    print(name)
