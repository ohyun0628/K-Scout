import SwiftUI

struct PlayerDetailView: View {
    let playerDetail: PlayerDetailItem?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // Placeholder for the actual detail view
            if let detail = playerDetail {
                Text("\(KoreanTranslationService.translatePlayer(detail.player.name)) 상세 기록")
                    .font(.title)
                
                Text("시즌 출전: \(detail.statistics.first?.games?.appearences ?? 0)경기")
                // Here we will build the historical table and radar chart later
            } else {
                Text("선수 정보가 없습니다.")
            }
        }
        .navigationTitle("선수 기록")
        .navigationBarTitleDisplayMode(.inline)
    }
}
