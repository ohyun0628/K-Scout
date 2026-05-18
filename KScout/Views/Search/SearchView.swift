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
                
                // 더미 데이터를 활용한 레이더 차트
                Text("선수 능력치 분석")
                    .font(.headline)
                    .padding(.bottom, 20)
                
                RadarChartView(data: [0.8, 0.6, 0.9, 0.5, 0.3])
                    .frame(width: 250, height: 250)
                
                Spacer()
            }
            .navigationTitle("선수 검색")
        }
    }
}

#Preview {
    SearchView()
}
