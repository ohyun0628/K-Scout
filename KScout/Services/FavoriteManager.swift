import Foundation

class FavoriteManager: ObservableObject {
    static let shared = FavoriteManager()
    
    private let userDefaultsKey = "favoritePlayerIDs"
    
    @Published var favoriteIDs: Set<Int> = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    private init() {
        loadFromUserDefaults()
    }
    
    // 즐겨찾기된 전체 선수 객체 리스트
    var favoritePlayers: [Player] {
        return Player.mockPlayers.filter { favoriteIDs.contains($0.id) }
    }
    
    // 특정 선수가 즐겨찾기 되어있는지 여부
    func isFavorite(playerID: Int) -> Bool {
        return favoriteIDs.contains(playerID)
    }
    
    // 즐겨찾기 토글
    func toggleFavorite(playerID: Int) {
        if favoriteIDs.contains(playerID) {
            favoriteIDs.remove(playerID)
        } else {
            favoriteIDs.insert(playerID)
        }
    }
    
    // 즐겨찾기 추가
    func addFavorite(playerID: Int) {
        favoriteIDs.insert(playerID)
    }
    
    // 즐겨찾기 삭제
    func removeFavorite(playerID: Int) {
        favoriteIDs.remove(playerID)
    }
    
    // UserDefaults 저장 로직
    private func saveToUserDefaults() {
        let array = Array(favoriteIDs)
        UserDefaults.standard.set(array, forKey: userDefaultsKey)
    }
    
    // UserDefaults 로드 로직
    private func loadFromUserDefaults() {
        if let array = UserDefaults.standard.array(forKey: userDefaultsKey) as? [Int] {
            favoriteIDs = Set(array)
        }
    }
}
