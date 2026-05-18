import SwiftUI

struct FavoriteView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("즐겨찾기한 선수 목록")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("즐겨찾기")
        }
    }
}
