const fs = require('fs');
const path = 'KScout/ViewModels/RankingViewModel.swift';
let content = fs.readFileSync(path, 'utf8');

const mapping = JSON.parse(fs.readFileSync('KScout/player_photos_mapping.json', 'utf8'));

// Regex to find PlayerRanking(...) and extract the playerName
const regex = /PlayerRanking\(rank:\s*[^,]+,\s*playerName:\s*"([^"]+)",/g;

let updatedContent = content;
let match;
while ((match = regex.exec(content)) !== null) {
    const fullString = match[0];
    const playerName = match[1];
    
    // Find ID from mapping
    const mapped = mapping[playerName];
    if (mapped && mapped.id) {
        const newString = fullString.replace('PlayerRanking(rank:', `PlayerRanking(id: ${mapped.id}, rank:`);
        updatedContent = updatedContent.replace(fullString, newString);
    } else {
        // If not found, use a random large negative ID so it doesn't collide with real players
        const safeId = -Math.floor(Math.random() * 1000000) - 100000;
        const newString = fullString.replace('PlayerRanking(rank:', `PlayerRanking(id: ${safeId}, rank:`);
        updatedContent = updatedContent.replace(fullString, newString);
    }
}

fs.writeFileSync(path, updatedContent, 'utf8');
console.log('Fixed RankingViewModel.swift player IDs');
