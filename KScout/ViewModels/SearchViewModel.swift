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
        allPlayers = Player.mockPlayers
        filteredPlayers = allPlayers
    }
}
