const fs = require('fs');
const path = 'KScout/Services/DummyData2025.swift';
let content = fs.readFileSync(path, 'utf8');

// Replace `id: UUID()` with `id: Int.random(in: 1000...9999)`
content = content.replace(/id: UUID\(\)/g, 'id: Int.random(in: 1000...9999)');

fs.writeFileSync(path, content, 'utf8');
console.log('Fixed DummyData2025.swift');
