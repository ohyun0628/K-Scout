const https = require('https');

const apiKey = "4eb0b3baf194555ef46565fa9dc2d35d";

const remainingPlayers = [
    { kor: "기성용", eng: "Sung-Yueng Ki" },
    { kor: "기성용", eng: "Sung-yueng Ki" },
    { kor: "엄원상", eng: "Won-Sang Eom" },
    { kor: "엄원상", eng: "Won-sang Eom" },
    { kor: "서진수", eng: "Jin-Su Seo" },
    { kor: "서진수", eng: "Jin-su Seo" },
    { kor: "아코스티", eng: "Acosty" },
    { kor: "홍창범", eng: "Chang-Beom Hong" },
    { kor: "카즈키", eng: "Kazuki Kozuka" },
    { kor: "이한도", eng: "Han-Do Lee" },
    { kor: "이한도", eng: "Han-do Lee" },
    { kor: "김대원", eng: "Dae-Won Kim" },
    { kor: "김대원", eng: "Dae-won Kim" },
    { kor: "루빅손", eng: "Gustav Ludwigson" }
];

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function searchPlayer(player) {
    return new Promise((resolve) => {
        const { kor, eng } = player;
        const options = {
            hostname: 'v3.football.api-sports.io',
            path: `/players?search=${encodeURIComponent(eng)}`,
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
                            console.log(`MATCH FOR ${kor} (${eng}): ID ${item.player.id}, Name: ${item.player.name}, Photo: ${item.player.photo}`);
                        }
                    } else {
                        console.log(`NO MATCH FOR ${kor} (${eng})`);
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
    for (const player of remainingPlayers) {
        await searchPlayer(player);
        await sleep(7500); // 7.5s rate limit buffer
    }
}

run();
