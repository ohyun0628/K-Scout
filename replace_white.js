const fs = require('fs');
const path = require('path');

function processDir(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            processDir(fullPath);
        } else if (fullPath.endsWith('.swift')) {
            let content = fs.readFileSync(fullPath, 'utf8');
            let original = content;
            content = content.replace(/\.background\(Color\.white\)/g, '.background(Color(.systemBackground))');
            if (content !== original) {
                fs.writeFileSync(fullPath, content);
                console.log(`Replaced in ${fullPath}`);
            }
        }
    }
}

processDir('KScout/Views');
