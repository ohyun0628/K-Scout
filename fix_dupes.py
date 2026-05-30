import re
import io

path = r'c:\Users\apf_temp_admin\OneDrive\바탕 화면\K-Scout\KScout\Services\KoreanTranslationService.swift'

with io.open(path, 'r', encoding='utf-8') as f:
    content = f.read()

def clean_dict(dict_str):
    matches = re.findall(r'"([^"]+)":\s*"([^"]+)"', dict_str)
    seen_keys = set()
    cleaned = []
    for k, v in matches:
        if k not in seen_keys:
            cleaned.append(f'"{k}": "{v}"')
            seen_keys.add(k)
    return ", ".join(cleaned)

def replace_dict(match):
    prefix = match.group(1)
    dict_content = match.group(2)
    suffix = match.group(3)
    
    cleaned = clean_dict(dict_content)
    return f'{prefix}[\n        {cleaned}\n    ]{suffix}'

# Replace surnames
new_content = re.sub(r'(surnames: \[String: String\] = )\[(.*?)\](\s*\n)', replace_dict, content, flags=re.DOTALL)
# Replace syllables
new_content = re.sub(r'(syllables: \[String: String\] = )\[(.*?)\](\s*\n)', replace_dict, new_content, flags=re.DOTALL)

with io.open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("Duplicates removed!")
