const fs = require('fs');

function checkFile(filepath) {
    const content = fs.readFileSync(filepath, 'utf8');
    let depth = 0;
    const lines = content.split('\n');
    let output = '';
    for (let i = 0; i < lines.length; i++) {
        for (let j = 0; j < lines[i].length; j++) {
            if (lines[i][j] === '{') depth++;
            else if (lines[i][j] === '}') {
                depth--;
            }
        }
        output += `${i+1}: D${depth} ${lines[i]}\n`;
    }
    fs.writeFileSync(filepath + '.depth.txt', output);
}

checkFile('KScout/ViewModels/SearchViewModel.swift');
checkFile('KScout/ViewModels/PlayerSummaryViewModel.swift');
