const fs = require('fs');

const players = [
    { name: "Min-Kyu Joo", id: 34427, team: "Ulsan HD FC", teamId: 2767, league: 1, pos: "Attacker", num: 18, app: 34, g: 17, a: 2, p: 280, t: 5, s: 60 },
    { name: "Lee Chung-Yong", id: 2905, team: "Ulsan HD FC", teamId: 2767, league: 1, pos: "Midfielder", num: 27, app: 23, g: 2, a: 5, p: 450, t: 15, s: 12 },
    { name: "Wanderson", id: 34569, team: "Pohang Steelers", teamId: 2768, league: 1, pos: "Defender", num: 77, app: 36, g: 2, a: 5, p: 1200, t: 45, s: 15 },
    { name: "Song Min-Kyu", id: 34598, team: "Jeonbuk Hyundai Motors", teamId: 2771, league: 1, pos: "Midfielder", num: 17, app: 34, g: 7, a: 7, p: 900, t: 20, s: 40 },
    { name: "Stanislav Iljutcenko", id: 25276, team: "FC Seoul", teamId: 2773, league: 1, pos: "Attacker", num: 9, app: 35, g: 14, a: 4, p: 300, t: 10, s: 55 },
    { name: "Eom Ji-Sung", id: 156321, team: "Gwangju FC", teamId: 2780, league: 1, pos: "Midfielder", num: 7, app: 28, g: 5, a: 4, p: 600, t: 15, s: 30 },
    { name: "Cesinha", id: 34484, team: "Daegu FC", teamId: 2769, league: 1, pos: "Midfielder", num: 11, app: 29, g: 10, a: 8, p: 650, t: 12, s: 45 },
    { name: "Tiago Orobó", id: 47864, team: "Daejeon Hana Citizen", teamId: 2772, league: 1, pos: "Attacker", num: 9, app: 36, g: 17, a: 5, p: 320, t: 8, s: 65 },
    { name: "Yuri Jonathan", id: 109209, team: "Jeju United", teamId: 2774, league: 1, pos: "Attacker", num: 9, app: 31, g: 8, a: 3, p: 250, t: 6, s: 40 },
    { name: "Stefan Mugoša", id: 34822, team: "Incheon United", teamId: 2775, league: 1, pos: "Attacker", num: 9, app: 36, g: 15, a: 2, p: 280, t: 7, s: 50 },
    { name: "Lee Seung-Woo", id: 2914, team: "Suwon FC", teamId: 2770, league: 1, pos: "Attacker", num: 11, app: 33, g: 10, a: 3, p: 400, t: 12, s: 45 },
    { name: "Yang Hyun-Jun", id: 292850, team: "Gangwon FC", teamId: 2776, league: 1, pos: "Attacker", num: 7, app: 21, g: 4, a: 4, p: 350, t: 10, s: 25 },
    { name: "Lee Dong-Gyeong", id: 34431, team: "Gimcheon Sangmu", teamId: 2779, league: 1, pos: "Midfielder", num: 10, app: 32, g: 12, a: 5, p: 800, t: 25, s: 50 },
    
    // K League 2
    { name: "Fejsal Mulić", id: 79138, team: "Suwon Samsung Bluewings", teamId: 2778, league: 2, pos: "Attacker", num: 9, app: 32, g: 13, a: 2, p: 200, t: 4, s: 55 },
    { name: "Bruno Lamas", id: -754565, team: "Busan I Park", teamId: 2781, league: 2, pos: "Midfielder", num: 10, app: 33, g: 6, a: 8, p: 1200, t: 30, s: 40 },
    { name: "Luis Mina", id: 111111, team: "Gimpo FC", teamId: 6969, league: 2, pos: "Attacker", num: 9, app: 30, g: 12, a: 3, p: 250, t: 5, s: 45 },
    { name: "Won Ki-Jong", id: 111112, team: "Gyeongnam FC", teamId: 2783, league: 2, pos: "Attacker", num: 11, app: 34, g: 9, a: 4, p: 300, t: 10, s: 38 },
    { name: "Nilson Junior", id: 111113, team: "Bucheon FC 1995", teamId: 2786, league: 2, pos: "Defender", num: 3, app: 35, g: 4, a: 1, p: 1500, t: 50, s: 10 },
    { name: "Yago", id: 111114, team: "FC Anyang", teamId: 2784, league: 2, pos: "Attacker", num: 9, app: 28, g: 8, a: 5, p: 220, t: 8, s: 35 },
    { name: "Valdívia", id: -381732, team: "Jeonnam Dragons", teamId: 2777, league: 2, pos: "Midfielder", num: 10, app: 35, g: 7, a: 10, p: 1100, t: 25, s: 42 },
    { name: "Jorge Luiz", id: 111115, team: "Chungbuk Cheongju FC", teamId: 6971, league: 2, pos: "Attacker", num: 9, app: 31, g: 11, a: 2, p: 240, t: 6, s: 48 },
    { name: "Gabriel Honorio", id: 111116, team: "Seongnam FC", teamId: 2782, league: 2, pos: "Attacker", num: 11, app: 25, g: 6, a: 4, p: 310, t: 12, s: 30 },
    { name: "Juninho", id: 111117, team: "Chungnam Asan FC", teamId: 2785, league: 2, pos: "Attacker", num: 7, app: 29, g: 9, a: 6, p: 290, t: 15, s: 40 },
    { name: "Bruno Silva", id: 111118, team: "Seoul E-Land FC", teamId: 2787, league: 2, pos: "Attacker", num: 10, app: 32, g: 10, a: 5, p: 350, t: 18, s: 45 },
    { name: "Kim Beom-Su", id: 111119, team: "Ansan Greeners FC", teamId: 2788, league: 2, pos: "Attacker", num: 11, app: 26, g: 5, a: 3, p: 210, t: 10, s: 25 },
    { name: "Bruno Mota", id: 111120, team: "Cheonan City FC", teamId: 6973, league: 2, pos: "Attacker", num: 9, app: 30, g: 8, a: 2, p: 200, t: 8, s: 35 }
];

const items = players.map(p => ({
    player: {
        id: p.id,
        name: p.name,
        photo: `https://media.api-sports.io/football/players/${p.id}.png`
    },
    statistics: [{
        team: { id: p.teamId, name: p.team },
        league: { id: p.league === 1 ? 292 : 293, name: p.league === 1 ? "K League 1" : "K League 2", season: 2024 },
        games: { appearences: p.app, position: p.pos, number: p.num },
        shots: { total: p.s },
        goals: { total: p.g, assists: p.a },
        passes: { total: p.p },
        tackles: { total: p.t }
    }]
}));

const jsonString = JSON.stringify(items);

// Replace in MockPlayerService.swift
let swiftPath = 'KScout/Services/MockPlayerService.swift';
let content = fs.readFileSync(swiftPath, 'utf8');

// Find the multi-line string between `let jsonString = """` and `"""`
const regex = /(let jsonString = """)([\s\S]*?)("""\s*guard let data)/;
content = content.replace(regex, `$1\n        ${jsonString}\n        $3`);

fs.writeFileSync(swiftPath, content);
console.log('Successfully injected 26 mock players!');
