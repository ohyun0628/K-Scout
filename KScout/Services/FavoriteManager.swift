import Foundation

class FavoriteManager: ObservableObject {
    static let shared = FavoriteManager()
    
    // Changed key to ensure old Set<Int> data doesn't crash the dictionary parsing
    private let userDefaultsKey = "favoritePlayerSeasonsV2"
    
    @Published var favoriteSeasons: [Int: Int] = [:] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    private init() {
        loadFromUserDefaults()
    }
    
    // 즐겨찾기된 전체 선수 객체 리스트
    var favoritePlayers: [Player] {
        return Player.mockPlayers.filter { favoriteSeasons.keys.contains($0.id) }
    }
    
    // 특정 선수가 즐겨찾기 되어있는지 여부
    func isFavorite(playerID: Int) -> Bool {
        return favoriteSeasons.keys.contains(playerID)
    }
    
    // 즐겨찾기 토글
    func toggleFavorite(playerID: Int, season: Int = 2024) {
        if favoriteSeasons.keys.contains(playerID) {
            favoriteSeasons.removeValue(forKey: playerID)
        } else {
            favoriteSeasons[playerID] = season
        }
    }
    
    // 즐겨찾기 추가
    func addFavorite(playerID: Int, season: Int = 2024) {
        favoriteSeasons[playerID] = season
    }
    
    // 즐겨찾기 삭제
    func removeFavorite(playerID: Int) {
        favoriteSeasons.removeValue(forKey: playerID)
    }
    
    // 선수가 즐겨찾기된 시즌 연도 가져오기
    func getFavoriteSeason(for playerID: Int) -> Int? {
        return favoriteSeasons[playerID]
    }
    
    // UserDefaults 저장 로직
    private func saveToUserDefaults() {
        var dictStrKey: [String: Int] = [:]
        for (key, value) in favoriteSeasons {
            dictStrKey[String(key)] = value
        }
        UserDefaults.standard.set(dictStrKey, forKey: userDefaultsKey)
    }
    
    // UserDefaults 로드 로직
    private func loadFromUserDefaults() {
        if let dictStrKey = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: Int] {
            var newDict: [Int: Int] = [:]
            for (key, value) in dictStrKey {
                if let intKey = Int(key) {
                    newDict[intKey] = value
                }
            }
            favoriteSeasons = newDict
        }
    }
}
