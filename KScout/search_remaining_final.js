const https = require('https');

const apiKey = "4eb0b3baf194555ef46565fa9dc2d35d";

const queries = [
    { kor: "기성용", eng: "Ki Sung Yong", league: 292, season: 2023 },
    { kor: "엄원상", eng: "Eom Won Sang", league: 292, season: 2023 },
    { kor: "서진수", eng: "Seo Jin Soo", league: 292, season: 2023 },
    { kor: "홍창범", eng: "Hong Chang Bum", league: 293, season: 2023 },
    { kor: "홍창범", eng: "Hong Chang Beom", league: 293, season: 2023 },
    { kor: "이한도", eng: "Lee Han Do", league: 293, season: 2023 },
    { kor: "김대원", eng: "Kim Dae Won", league: 292, season: 2023 }
];

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function searchPlayer(player) {
    return new Promise((resolve) => {
        const { kor, eng, league, season } = player;
        const options = {
            hostname: 'v3.football.api-sports.io',
            path: `/players?search=${encodeURIComponent(eng)}&league=${league}&season=${season}`,
            method: 'GET',
            headers: {
                'x-apisports-key': apiKey
            }
        };

        const req = https.request(options, (res) => {
            let body = '';
            res.on('data', (chunk) => { body += chunk; });
            res.on('end', () => {
                try {
                    const data = JSON.parse(body);
                    if (data.response && data.response.length > 0) {
                        for (const item of data.response) {
                            console.log(`FOUND_MATCH: "${kor}": { "id": ${item.player.id}, "photoURL": "${item.player.photo}" }, // Name: ${item.player.name}`);
                        }
                    } else {
                        console.log(`NO MATCH FOR ${kor} (${eng}): ${body}`);
                    }
                } catch (e) {
                    console.log(`Error parsing for ${eng}: ${e.message}`);
                }
                resolve();
            });
        });

        req.on('error', (e) => {
            console.log(`Error connecting for ${eng}: ${e.message}`);
            resolve();
        });

        req.end();
    });
}

async function run() {
    for (const player of queries) {
        await searchPlayer(player);
        await sleep(7500); // 7.5s rate limit buffer
    }
}

run();
