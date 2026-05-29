
const fs = require("fs");
try {
    const data = JSON.parse(fs.readFileSync("fixtures.json", "utf-8"));
    const responses = data.response || [];
    let allValid = true;
    for (let i = 0; i < responses.length; i++) {
        const item = responses[i];
        if (!item.fixture || typeof item.fixture.id !== "number") allValid = false;
        if (!item.league || typeof item.league.id !== "number") allValid = false;
        if (!item.teams || !item.teams.home || !item.teams.home.name) allValid = false;
        if (!item.goals) allValid = false; // GoalScoreInfo requires goals object even if home/away are null
    }
    console.log("Success! Valid items: " + responses.length + ", All schema valid: " + allValid);
} catch(e) {
    console.log("Error: " + e);
}

