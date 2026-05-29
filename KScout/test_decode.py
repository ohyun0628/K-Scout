
import json

try:
    with open("fixtures.json", "r", encoding="utf-8") as f:
        data = json.load(f)
    responses = data.get("response", [])
    
    for item in responses:
        # Check FixtureInfo
        fixture = item.get("fixture", {})
        assert "id" in fixture
        assert "date" in fixture
        assert "status" in fixture
        status = fixture["status"]
        assert "long" in status
        assert "short" in status
        
        # Check LeagueInfo
        league = item.get("league", {})
        assert "id" in league
        assert "name" in league
        assert "season" in league
        
        # Check TeamMatchInfo
        teams = item.get("teams", {})
        assert "home" in teams
        assert "away" in teams
        home = teams["home"]
        assert "id" in home
        assert "name" in home
        
        # Check GoalScoreInfo
        goals = item.get("goals", {})
        
    print(f"Success! {len(responses)} items parsed correctly.")
except Exception as e:
    print(f"Error: {e}")

