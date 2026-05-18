import SwiftUI

struct RankingView: View {
    @StateObject private var viewModel = RankingViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("순위표 불러오는 중...")
                } else {
                    List(viewModel.standings) { standing in
                        HStack {
                            Text("\(standing.rank)위")
                                .font(.headline)
                                .frame(width: 40, alignment: .leading)
                            Text(standing.teamName)
                                .font(.body)
                            Spacer()
                            Text("\(standing.points)점")
                                .bold()
                        }
                    }
                }
            }
            .navigationTitle("팀 및 선수 랭킹")
            .onAppear {
                viewModel.fetchStandings()
            }
        }
    }
}
