import Foundation
import Combine

class PlayerSummaryViewModel: ObservableObject {
    @Published var playerDetail: PlayerDetailItem?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchPlayer(id: Int) {
        isLoading = true
        errorMessage = nil
        
        let season = 2024
        
        NetworkManager.shared.request(endpoint: .playerDetail(id: id, season: season)) { (result: Result<[PlayerDetailItem], NetworkError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let items):
                    if let item = items.first {
                        self.playerDetail = item
                    } else {
                        self.errorMessage = "선수 정보를 찾을 수 없습니다."
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
