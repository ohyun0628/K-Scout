import sys

def check_braces(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    level = 0
    for i, line in enumerate(lines):
        clean = line.split('//')[0]
        # Ignore strings
        in_string = False
        clean_no_str = ""
        for char in clean:
            if char == '"':
                in_string = not in_string
            if not in_string:
                clean_no_str += char
        
        for char in clean_no_str:
            if char == '{':
                level += 1
            elif char == '}':
                level -= 1
        
        if level < 0:
            print(f'Error: Too many closing braces at line {i+1}: {line.strip()}')
            return
            
    print(f'Final brace level: {level}')
    if level > 0:
        print("Missing closing braces!")

check_braces('KScout/Views/Schedule/MatchDetailView.swift')
