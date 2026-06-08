const fs = require('fs');
const path = 'KScout/Services/DummyData2025.swift';
let content = fs.readFileSync(path, 'utf8');

const mapping = JSON.parse(fs.readFileSync('KScout/player_photos_mapping.json', 'utf8'));

// Regex to find PlayerRanking(...) and extract the playerName
const regex = /PlayerRanking\(id:\s*[^,]+,\s*rank:\s*[^,]+,\s*playerName:\s*"([^"]+)",/g;

let updatedContent = content;
let match;
while ((match = regex.exec(content)) !== null) {
    const fullString = match[0];
    const playerName = match[1];
    
    // Find ID from mapping
    const mapped = mapping[playerName];
    if (mapped && mapped.id) {
        const newString = fullString.replace(/id:\s*[^,]+,/, `id: ${mapped.id},`);
        updatedContent = updatedContent.replace(fullString, newString);
    } else {
        // If not found, use a random large negative ID so it doesn't collide with real players and just shows an error instead of a wrong player
        const safeId = -Math.floor(Math.random() * 1000000) - 100000;
        const newString = fullString.replace(/id:\s*[^,]+,/, `id: ${safeId},`);
        updatedContent = updatedContent.replace(fullString, newString);
    }
}

fs.writeFileSync(path, updatedContent, 'utf8');
console.log('Fixed DummyData2025.swift player IDs');
