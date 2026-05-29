const https = require('https');

const apiKey = "4eb0b3baf194555ef46565fa9dc2d35d";

const queries = [
    { kor: "기성용", eng: "Sung-Yeung Ki" },
    { kor: "기성용", eng: "Sung-yeung Ki" },
    { kor: "기성용", eng: "Ki Sung-Yeung" },
    { kor: "기성용", eng: "Ki Sung-yueng" },
    { kor: "엄원상", eng: "Um Won-Sang" },
    { kor: "엄원상", eng: "Won-Sang Um" },
    { kor: "엄원상", eng: "Eom Won-Sang" },
    { kor: "서진수", eng: "Seo Jin-Su" },
    { kor: "서진수", eng: "Jin-Su Seo" },
    { kor: "아코스티", eng: "Acosty" },
    { kor: "아코스티", eng: "Adjei-Acosty" },
    { kor: "홍창범", eng: "Chang-Beom Hong" },
    { kor: "홍창범", eng: "Hong Chang-Beom" },
    { kor: "카즈키", eng: "Kozuka" },
    { kor: "이한도", eng: "Lee Han-Do" },
    { kor: "이한도", eng: "Han-Do Lee" },
    { kor: "김대원", eng: "Kim Dae-Won" },
    { kor: "김대원", eng: "Dae-Won Kim" }
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
                            console.log(`FOUND_MATCH: "${kor}": { "id": ${item.player.id}, "photoURL": "${item.player.photo}" }, // Name: ${item.player.name}`);
                        }
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
