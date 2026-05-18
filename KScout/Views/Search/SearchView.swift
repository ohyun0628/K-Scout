import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("선수 이름 검색", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Spacer()
                Text("검색 결과 및 스탯 레이더 차트 화면")
                    .foregroundColor(.secondary)
                Spacer()
            }
            .navigationTitle("선수 검색")
        }
    }
}

#Preview {
    SearchView()
}
