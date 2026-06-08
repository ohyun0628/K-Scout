const fs = require('fs');
const https = require('https');

const options = {
  hostname: 'v3.football.api-sports.io',
  method: 'GET',
  headers: { 'x-apisports-key': '4eb0b3baf194555ef46565fa9dc2d35d' }
};

const teamIds = [
  2746, 2747, 2750, 2756, 2761, 2762, 2763, 2764, 2766, 2767, 2768, 2759, // K1
  2748, 2757, 7078, 2745, 2751, 2758, 7060, 7061, 2753, 2765, 2752, 2749, 2760 // K2
];

const fetchSquad = (teamId) => {
  return new Promise((resolve, reject) => {
    const req = https.request({ ...options, path: '/players/squads?team=' + teamId }, res => {
      let body = '';
      res.on('data', d => body += d);
      res.on('end', () => {
        try {
          const data = JSON.parse(body);
          if(data.response && data.response[0]) {
            resolve(data.response[0].players.map(p => p.name));
          } else {
            resolve([]);
          }
        } catch(e) { resolve([]); }
      });
    });
    req.on('error', reject);
    req.end();
  });
};

(async () => {
  let allPlayers = new Set();
  
  for(let id of teamIds) {
    console.log(`Fetching squad for team ${id}`);
    const names = await fetchSquad(id);
    console.log(`Team ${id} returned ${names.length} players`);
    names.forEach(n => allPlayers.add(n));
    // delay 200ms
    await new Promise(r => setTimeout(r, 200));
  }
  
  const playersArray = Array.from(allPlayers);
  console.log('Total unique players fetched:', playersArray.length);
  
  const targetDir = 'KScout/Resources';
  if (!fs.existsSync(targetDir)) {
      fs.mkdirSync(targetDir, { recursive: true });
  }
  
  fs.writeFileSync(targetDir + '/KLeaguePlayers.json', JSON.stringify(playersArray, null, 2));
  console.log('Saved to KLeaguePlayers.json');
})();
