import sys

def check_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        
    depth = 0
    for i, line in enumerate(lines):
        for char in line:
            if char == '{':
                depth += 1
            elif char == '}':
                depth -= 1
                if depth < 0:
                    print(f"Negative depth at line {i+1} in {filepath}")
    
    print(f"Final depth for {filepath}: {depth}")

check_file('KScout/ViewModels/SearchViewModel.swift')
check_file('KScout/ViewModels/PlayerSummaryViewModel.swift')
