const fs = require('fs');
const https = require('https');

const API_KEY = "4eb0b3baf194555ef46565fa9dc2d35d";
const LEAGUES = [292, 293];
const SEASON = 2022;

const swiftContent = fs.readFileSync('KScout/Services/KoreanTranslationService.swift', 'utf8');
const keys = new Set([...swiftContent.matchAll(/"([^"]+)":/g)].map(m => m[1].toLowerCase()));

function fetchData(url) {
    return new Promise((resolve, reject) => {
        https.get(url, { headers: { 'x-apisports-key': API_KEY } }, (res) => {
            let data = '';
            res.on('data', chunk => data += chunk);
            res.on('end', () => resolve(JSON.parse(data)));
        }).on('error', reject);
    });
}

async function run() {
    const allNames = new Set();
    for (const league of LEAGUES) {
        for (const endpoint of ['topscorers', 'topassists']) {
            const url = `https://v3.football.api-sports.io/players/${endpoint}?season=${SEASON}&league=${league}`;
            try {
                const res = await fetchData(url);
                if (res.response) {
                    res.response.forEach(item => allNames.add(item.player.name));
                }
            } catch (e) {}
        }
    }

    const missing = [];
    for (const name of Array.from(allNames).sort()) {
        const lowerName = name.trim().toLowerCase();
        let found = false;
        if (keys.has(lowerName)) found = true;
        else {
            for (const k of keys) {
                if (k.length > 3 && lowerName.includes(k)) {
                    found = true;
                    break;
                }
            }
        }
        if (!found) missing.push(name);
    }

    console.log("MISSING NAMES IN DICTIONARY:");
    missing.forEach(n => console.log(n));
}
run();
