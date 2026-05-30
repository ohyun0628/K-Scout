const fs = require('fs');
const path = 'c:/Users/apf_temp_admin/OneDrive/바탕 화면/K-Scout/KScout/Services/KoreanTranslationService.swift';
let content = fs.readFileSync(path, 'utf8');

// 1. Add more surnames & syllables
const newSurnames = `"yeo": "여", "do": "도"`;
const newSyllables = `"hyeop": "협", "hyup": "협", "eu": "으", "ddeum": "뜸", "teum": "틈", "kyeong": "경", "yub": "엽", "yeob": "엽", "jun": "준", "reum": "름"`;

function cleanDict(dictStr) {
    const regex = /"([^"]+)":\s*"([^"]+)"/g;
    let match;
    const seen = new Set();
    const cleaned = [];
    while ((match = regex.exec(dictStr)) !== null) {
        if (!seen.has(match[1])) {
            cleaned.push(`"${match[1]}": "${match[2]}"`);
            seen.add(match[1]);
        }
    }
    return cleaned.join(', ');
}

content = content.replace(/(surnames: \[String: String\] = )\[([\s\S]*?)\](\s*\n)/, (match, prefix, dictContent, suffix) => {
    return `${prefix}[\n        ${cleanDict(dictContent + ', ' + newSurnames)}\n    ]${suffix}`;
});

content = content.replace(/(syllables: \[String: String\] = )\[([\s\S]*?)\](\s*\n)/, (match, prefix, dictContent, suffix) => {
    return `${prefix}[\n        ${cleanDict(dictContent + ', ' + newSyllables)}\n    ]${suffix}`;
});

// 2. Add 2-word support
const oldFunc = `        guard components.count == 3 else { return nil }`;
const newFunc = `        if components.count == 2 {
            if let last = surnames[components[0]], let first = syllables[components[1]] {
                return "\\(last)\\(first)"
            }
            if let last = surnames[components[1]], let first = syllables[components[0]] {
                return "\\(last)\\(first)"
            }
        }
        
        guard components.count == 3 else { return nil }`;

content = content.replace(oldFunc, newFunc);

fs.writeFileSync(path, content, 'utf8');
console.log("Success!");
