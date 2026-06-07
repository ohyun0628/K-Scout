const fs = require('fs');

const rvmPath = 'KScout/ViewModels/RankingViewModel.swift';
let content = fs.readFileSync(rvmPath, 'utf8');

// Replace API mapping
content = content.replace(
    /id: UUID\(\),\s*rank: index/g,
    'id: item.player.id,\n                            rank: index'
);

// Remove id: UUID(), from mock data
content = content.replace(/id: UUID\(\),\s*/g, '');

fs.writeFileSync(rvmPath, content, 'utf8');
console.log('Successfully updated RankingViewModel.swift');
