import SwiftUI

struct StandingsView: View {
    @StateObject private var viewModel = StandingsViewModel()
    
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
            .navigationTitle("K리그 순위")
            .onAppear {
                Task {
                    await viewModel.fetchStandings()
                }
            }
        }
    }
}

#Preview {
    StandingsView()
}
