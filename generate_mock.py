import json

lee_chung_yong = {
    "player": {"id": 2905, "name": "Lee Chung-Yong", "photo": "https://media.api-sports.io/football/players/2905.png"},
    "statistics": [{
        "team": {"id": 2767, "name": "Ulsan Hyundai FC"},
        "league": {"id": 292, "name": "K League 1", "season": 2024},
        "games": {"appearences": 23, "position": "Midfielder", "number": 27},
        "shots": {"total": 12}, "goals": {"total": 2, "assists": 5}, "passes": {"total": 450}, "tackles": {"total": 15}
    }]
}

joo_min_kyu = {
    "player": {"id": 34427, "name": "Min-Kyu Joo", "photo": "https://media.api-sports.io/football/players/34427.png"},
    "statistics": [{
        "team": {"id": 2767, "name": "Ulsan Hyundai FC"},
        "league": {"id": 292, "name": "K League 1", "season": 2024},
        "games": {"appearences": 34, "position": "Attacker", "number": 18},
        "shots": {"total": 60}, "goals": {"total": 17, "assists": 2}, "passes": {"total": 280}, "tackles": {"total": 5}
    }]
}

cesinha = {
    "player": {"id": 34484, "name": "Cesinha", "photo": "https://media.api-sports.io/football/players/34484.png"},
    "statistics": [{
        "team": {"id": 2769, "name": "Daegu FC"},
        "league": {"id": 292, "name": "K League 1", "season": 2024},
        "games": {"appearences": 29, "position": "Midfielder", "number": 11},
        "shots": {"total": 45}, "goals": {"total": 10, "assists": 8}, "passes": {"total": 650}, "tackles": {"total": 12}
    }]
}

data = [lee_chung_yong, joo_min_kyu, cesinha]
with open('mock_players.json', 'w') as f:
    json.dump(data, f)
