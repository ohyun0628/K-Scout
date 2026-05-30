const fs = require('fs');

const path = 'c:/Users/apf_temp_admin/OneDrive/바탕 화면/K-Scout/KScout/Services/KoreanTranslationService.swift';
let content = fs.readFileSync(path, 'utf8');

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
    return `${prefix}[\n        ${cleanDict(dictContent)}\n    ]${suffix}`;
});

content = content.replace(/(syllables: \[String: String\] = )\[([\s\S]*?)\](\s*\n)/, (match, prefix, dictContent, suffix) => {
    return `${prefix}[\n        ${cleanDict(dictContent)}\n    ]${suffix}`;
});

fs.writeFileSync(path, content, 'utf8');
console.log("Success!");
