import Foundation

@MainActor
class StandingsViewModel: ObservableObject {
    @Published var standings: [Standing] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkManager = NetworkManager.shared
    
    func fetchStandings() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // TODO: 실제 API 호출 로직으로 변경
            // let data = try await networkManager.request(endpoint: .standings(league: 39, season: 2024))
            
            // 임시 더미 데이터 (뷰 확인용)
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1초 지연
            self.standings = [
                Standing(id: 1, rank: 1, teamName: "울산 HD FC", points: 70, goalsDiff: 25),
                Standing(id: 2, rank: 2, teamName: "포항 스틸러스", points: 65, goalsDiff: 15),
                Standing(id: 3, rank: 3, teamName: "FC 서울", points: 60, goalsDiff: 10),
                Standing(id: 4, rank: 4, teamName: "전북 현대 모터스", points: 55, goalsDiff: 5)
            ]
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
