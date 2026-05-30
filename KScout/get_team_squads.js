const https = require('https');

const apiKey = "4eb0b3baf194555ef46565fa9dc2d35d";

function testStandings() {
    const options = {
        hostname: 'v3.football.api-sports.io',
        path: '/standings?league=292&season=2023',
        method: 'GET',
        headers: {
            'x-apisports-key': apiKey
        }
    };

    const req = https.request(options, (res) => {
        let body = '';
        res.on('data', (chunk) => { body += chunk; });
        res.on('end', () => {
            console.log("STANDINGS RESPONSE:\n", body.substring(0, 1000));
        });
    });

    req.on('error', (e) => {
        console.log(`Connection error: ${e.message}`);
    });

    req.end();
}

testStandings();
