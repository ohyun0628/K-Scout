const fs = require('fs');

const content = fs.readFileSync('KScout/Views/Schedule/MatchDetailView.swift', 'utf8');
const lines = content.split('\n');

let level = 0;
for (let i = 0; i < lines.length; i++) {
    const line = lines[i].split('//')[0];
    let inString = false;
    for (let j = 0; j < line.length; j++) {
        if (line[j] === '"') inString = !inString;
        if (!inString) {
            if (line[j] === '{') level++;
            else if (line[j] === '}') level--;
        }
    }
    if (level < 0) {
        console.log(`Unmatched } at line ${i + 1}`);
        process.exit(1);
    }
}
console.log(`Final level: ${level}`);
