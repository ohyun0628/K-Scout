const https = require('https');
const fs = require('fs');
const path = require('path');

const apiKey = "4eb0b3baf194555ef46565fa9dc2d35d";

// KoreanTranslationService의 선수 번역 딕셔너리 이식
const playerDictionary = {
    "mugosa": "무고사",
    "s. mugoša": "무고사",
    "stefan mugoša": "무고사",
    "mugoša": "무고사",
    "cesinha": "세징야",
    "césar fernando silva dos santos": "세징야",
    "joo min-kyu": "주민규",
    "min-kyu ju": "주민규",
    "j. min-kyu": "주민규",
    "ju min-kyu": "주민규",
    "min-kyu jo": "주민규",
    "gerso": "제르소",
    "gerso fernandes": "제르소",
    "g. fernandes": "제르소",
    "zeca": "제카",
    "josé joaquim de carvalho": "제카",
    "valdivia": "발디비아",
    "wanderson ferreira de oliveira": "발디비아",
    "w. de oliveira": "발디비아",
    "cho gue-sung": "조규성",
    "gue-sung cho": "조규성",
    "g. cho": "조규성",
    "an byong-jun": "안병준",
    "byong-jun an": "안병준",
    "b. an": "안병준",
    "lee seung-woo": "이승우",
    "seung-woo lee": "이승우",
    "s. lee": "이승우",
    "um won-sang": "엄원상",
    "won-sang eom": "엄원상",
    "w. eom": "엄원상",
    "barrow": "바로우",
    "modou barrow": "바로우",
    "m. barrow": "바로우",
    "lars veldwijk": "라스",
    "l. veldwijk": "라스",
    "popovic": "포포비치",
    "aleksandar popović": "포포비치",
    "yun il-lok": "윤일록",
    "il-lok yun": "윤일록",
    "kim dae-won": "김대원",
    "dae-won kim": "김대원",
    "d. kim": "김대원",
    "yang hyun-jun": "양현준",
    "hyun-jun yang": "양현준",
    "h. yang": "양현준",
    "lee dong-gyeong": "이동경",
    "dong-gyeong lee": "이동경",
    "d. lee": "이동경",
    "cho young-wook": "조영욱",
    "young-wook cho": "조영욱",
    "y. cho": "조영욱",
    "stanislav iljutcenko": "일류첸코",
    "s. iljutcenko": "일류첸코",
    "iljutcenko": "일류첸코",
    "gustavo": "구스타보",
    "na sang-ho": "나상호",
    "sang-ho na": "나상호",
    "s. na": "나상호",
    "kamil aspropotamitis": "아스프로",
    "k. aspropotamitis": "아스프로",
    "bako": "바코",
    "valeri qazaishvili": "바코",
    "v. qazaishvili": "바코",
    "leonardo": "레오나르도",
    "kim jin-su": "김진수",
    "jin-su kim": "김진수",
    "shin jin-ho": "신진호",
    "jin-ho shin": "신진호",
    "lee yeong-jae": "이영재",
    "yeong-jae lee": "이영재",
    "mulic": "뮬리치",
    "f. mulić": "뮬리치",
    "fejsal mulić": "뮬리치",
    "rubio": "루비오",
    "jonathan rubio": "루비오",
    "hernades": "에르난데스",
    "hernandes rodrigues": "에르난데스",
    "h. rodrigues": "에르난데스",
    "hernandes": "에르난데스",
    "wanderson": "완델손",
    "wanderson de sousa carneiro": "완델손",
    "edgar": "에드가",
    "edgar silva": "에드가",
    "goo bon-cheul": "구본철",
    "bon-cheul goo": "구본철",
    "kim seung-dae": "김승대",
    "seung-dae kim": "김승대",
    "yoon bit-garam": "윤빛가람",
    "bit-garam yoon": "윤빛가람",
    "lopes": "로페즈",
    "ricardo lopes": "로페즈",
    "yago cariello": "야고",
    "yago": "야고",
    "anderson oliveira": "안데르손",
    "anderson": "안데르손",
    "gabriel": "가브리엘",
    "kovacevic": "코바체비치",
    "tiago orobo": "티아고",
    "tiago orobó": "티아고",
    "tiago": "티아고",
    "yuri jonathan": "유리 조나탄",
    "yuri": "유리 조나탄",
    "s. jurj": "유리 조나탄",
    "lee han-beom": "이한범",
    "han-beom lee": "이한범",
    "pllana": "플라나",
    "m. pllana": "플라나",
    "lus nani": "나니",
    "paulinho": "파울리뇨",
    "ronaldo": "호날두",
    "ronaldo tavares": "호날두",
    "bassani": "바사니",
    "um ji-sung": "엄지성",
    "ji-sung um": "엄지성",
    "song min-kyu": "송민규",
    "min-kyu song": "송민규",
    "oberdan": "오베르단",
    "kornelius hansen": "코르넬리우스"
};

function translatePlayer(name) {
    const key = name.trim().toLowerCase();
    
    // Exact matching
    if (playerDictionary[key]) {
        return playerDictionary[key];
    }
    
    // Partial matching
    for (const [engKey, korVal] of Object.entries(playerDictionary)) {
        if (engKey.length > 3 && key.includes(engKey)) {
            return korVal;
        }
    }
    
    return name;
}

const endpoints = [
    { league: 292, season: 2023, type: "topscorers" },
    { league: 292, season: 2023, type: "topassists" },
    { league: 292, season: 2024, type: "topscorers" },
    { league: 292, season: 2024, type: "topassists" },
    { league: 293, season: 2023, type: "topscorers" },
    { league: 293, season: 2023, type: "topassists" },
    { league: 293, season: 2024, type: "topscorers" },
    { league: 293, season: 2024, type: "topassists" }
];

const results = {};

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function fetchRankings(endpoint) {
    return new Promise((resolve) => {
        const { league, season, type } = endpoint;
        console.log(`[${new Date().toLocaleTimeString()}] Fetching ${type} for league ${league}, season ${season}...`);
        
        const pathStr = `/players/${type}?league=${league}&season=${season}`;
        const options = {
            hostname: 'v3.football.api-sports.io',
            path: pathStr,
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
                    if (data.errors && data.errors.rateLimit) {
                        console.log(`-> Rate limit hit: ${data.errors.rateLimit}`);
                        resolve(false);
                        return;
                    }
                    if (data.response && data.response.length > 0) {
                        console.log(`-> Retrieved ${data.response.length} players.`);
                        for (const item of data.response) {
                            const engName = item.player.name;
                            const korName = translatePlayer(engName);
                            const photoUrl = item.player.photo;
                            const playerId = item.player.id;
                            
                            results[korName] = {
                                id: playerId,
                                photoURL: photoUrl,
                                originalName: engName
                            };
                        }
                    } else {
                        console.log(`-> Empty response.`);
                    }
                } catch (e) {
                    console.log(`-> Error parsing response: ${e.message}`);
                }
                resolve(true);
            });
        });

        req.on('error', (e) => {
            console.log(`-> Connection error: ${e.message}`);
            resolve(true);
        });

        req.end();
    });
}

async function run() {
    for (let i = 0; i < endpoints.length; i++) {
        let success = await fetchRankings(endpoints[i]);
        if (!success) {
            console.log("Waiting 30 seconds due to rate limit...");
            await sleep(30000);
            i--; // Retry
            continue;
        }
        await sleep(7500); // 7.5s interval to be perfectly safe
    }
    
    // 추가적인 하드코딩 매핑 보완 (검색 결과에 없을 경우를 위한 대비)
    const fallbackMap = {
        "이상헌": { "id": 292850, "photoURL": "https://media.api-sports.io/football/players/292850.png" },
        "황문기": { "id": 142145, "photoURL": "https://media.api-sports.io/football/players/142145.png" },
        "김지현": { "id": 114674, "photoURL": "https://media.api-sports.io/football/players/114674.png" }
    };
    
    for (const [kor, data] of Object.entries(fallbackMap)) {
        if (!results[kor]) {
            results[kor] = data;
        }
    }
    
    const outputPath = path.join(__dirname, 'player_photos_mapping.json');
    fs.writeFileSync(outputPath, JSON.stringify(results, null, 2), 'utf-8');
    console.log(`\nFinished! Results saved to: ${outputPath}`);
}

run();
