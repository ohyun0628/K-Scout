const https = require('https');
const apiKey = "4eb0b3baf194555ef46565fa9dc2d35d";

function fetchSquad(teamId) {
    return new Promise((resolve) => {
        const options = {
            hostname: 'v3.football.api-sports.io',
            path: `/players/squads?team=${teamId}`,
            method: 'GET',
            headers: { 'x-apisports-key': apiKey }
        };

        const req = https.request(options, (res) => {
            let body = '';
            res.on('data', chunk => body += chunk);
            res.on('end', () => {
                const data = JSON.parse(body);
                if (data.response && data.response.length > 0) {
                    resolve(data.response[0].players);
                } else {
                    resolve([]);
                }
            });
        });
        req.end();
    });
}

async function run() {
    const seoul = await fetchSquad(414);
    const ulsan = await fetchSquad(412);
    
    console.log("Seoul Players:");
    seoul.filter(p => p.name.includes("Ki") || p.name.includes("Sung")).forEach(p => console.log(p.id, p.name));
    
    console.log("\nUlsan Players:");
    ulsan.filter(p => p.name.includes("Kim") || p.name.includes("Young") || p.name.includes("Jo") || p.name.includes("Hyeon")).forEach(p => console.log(p.id, p.name));
}
run();
