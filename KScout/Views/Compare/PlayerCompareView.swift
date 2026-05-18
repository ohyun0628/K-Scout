import SwiftUI

struct PlayerCompareView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("선수 능력치 비교 화면")
                    .foregroundColor(.secondary)
                    .padding()
                
                // TODO: Radar Chart 구현 및 연결
            }
            .navigationTitle("선수 스탯 비교")
        }
    }
}

#Preview {
    PlayerCompareView()
}
