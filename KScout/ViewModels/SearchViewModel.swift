import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredPlayers: [Player] = []
    @Published var selectedPlayer: Player? = nil
    
    private var allPlayers: [Player] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMockPlayers()
        
        // 검색어 입력 시 0.2초 딜레이(Debounce)를 주어 실시간 필터링 수행
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterPlayers(with: text)
            }
            .store(in: &cancellables)
    }
    
    private func filterPlayers(with query: String) {
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredPlayers = allPlayers
        } else {
            filteredPlayers = allPlayers.filter { player in
                player.name.localizedCaseInsensitiveContains(query) ||
                player.teamName.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    private func loadMockPlayers() {
        allPlayers = [
            Player(id: 101, name: "주민규", photo: nil, teamName: "울산 HD", goals: 14, assists: 3, shots: 48, passes: 320, defense: 12),
            Player(id: 102, name: "세징야", photo: nil, teamName: "대구 FC", goals: 9, assists: 8, shots: 45, passes: 680, defense: 22),
            Player(id: 103, name: "이승우", photo: nil, teamName: "수원 FC", goals: 11, assists: 5, shots: 38, passes: 480, defense: 15),
            Player(id: 104, name: "기성용", photo: nil, teamName: "서울 FC", goals: 3, assists: 6, shots: 25, passes: 910, defense: 58),
            Player(id: 105, name: "설영우", photo: nil, teamName: "울산 HD", goals: 2, assists: 7, shots: 18, passes: 820, defense: 78),
            Player(id: 106, name: "송민규", photo: nil, teamName: "전북 현대", goals: 8, assists: 5, shots: 35, passes: 540, defense: 30),
            Player(id: 107, name: "김영권", photo: nil, teamName: "울산 HD", goals: 1, assists: 1, shots: 8, passes: 950, defense: 85),
            Player(id: 108, name: "무고사", photo: nil, teamName: "인천 유나이티드", goals: 12, assists: 2, shots: 52, passes: 280, defense: 10),
            Player(id: 109, name: "일류첸코", photo: nil, teamName: "서울 FC", goals: 11, assists: 4, shots: 42, passes: 310, defense: 14),
            Player(id: 110, name: "조현우", photo: nil, teamName: "울산 HD", goals: 0, assists: 0, shots: 0, passes: 410, defense: 95) // GK는 수비/패스 중심
        ]
        filteredPlayers = allPlayers
    }
}
