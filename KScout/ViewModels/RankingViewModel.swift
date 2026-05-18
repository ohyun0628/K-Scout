import Foundation

@MainActor
class RankingViewModel: ObservableObject {
    @Published var standings: [Standing] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkManager = NetworkManager.shared
    
    func fetchStandings() {
        self.isLoading = true
        
        // 가짜 데이터 연동 (구버전 호환)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.standings = [
                Standing(id: 1, rank: 1, teamName: "울산 HD FC", points: 70, goalsDiff: 25),
                Standing(id: 2, rank: 2, teamName: "포항 스틸러스", points: 65, goalsDiff: 15),
                Standing(id: 3, rank: 3, teamName: "FC 서울", points: 60, goalsDiff: 10),
                Standing(id: 4, rank: 4, teamName: "전북 현대 모터스", points: 55, goalsDiff: 5)
            ]
            self.isLoading = false
        }
    }
}
