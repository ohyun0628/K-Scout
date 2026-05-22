import SwiftUI

struct RankingView: View {
    @StateObject private var viewModel = RankingViewModel()
    
    // 상태 제어
    @State private var mainTab = 0 // 0: 팀 순위, 1: 선수 순위
    @State private var selectedLeague = 1 // 1: K리그1, 2: K리그2
    @State private var selectedStatType = "goals" // "goals": 득점, "assists": 도움
    
    var body: some View {
        ZStack {
            // 그레이 베이스 백그라운드
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 1. 커스텀 헤더 타이틀
                HeaderTitleView(title: "순위표", selectedSeason: $viewModel.currentSeason)
                
                // 2. 대분류 세그먼트 셀렉터 (팀 순위 vs 선수 순위)
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            mainTab = 0
                        }
                    }) {
                        Text("팀 순위")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(mainTab == 0 ? .white : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(mainTab == 0 ? Color.brandNavy : Color.clear)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            mainTab = 1
                        }
                    }) {
                        Text("선수 순위")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(mainTab == 1 ? .white : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(mainTab == 1 ? Color.brandNavy : Color.clear)
                            .cornerRadius(10)
                    }
                }
                .padding(4)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.bottom, 14)
                
                // 3. 소분류 세그먼트 셀렉터 (K리그1 vs K리그2)
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            selectedLeague = 1
                        }
                    }) {
                        Text("K리그1")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(selectedLeague == 1 ? Color.brandNavy : .gray)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(selectedLeague == 1 ? Color.white : Color.clear)
                            .cornerRadius(8)
                            .shadow(color: selectedLeague == 1 ? Color.black.opacity(0.05) : Color.clear, radius: 2, x: 0, y: 1)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            selectedLeague = 2
                        }
                    }) {
                        Text("K리그2")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(selectedLeague == 2 ? Color.brandNavy : .gray)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(selectedLeague == 2 ? Color.white : Color.clear)
                            .cornerRadius(8)
                            .shadow(color: selectedLeague == 2 ? Color.black.opacity(0.05) : Color.clear, radius: 2, x: 0, y: 1)
                    }
                }
                .padding(4)
                .background(Color(UIColor.secondarySystemBackground).opacity(0.6))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
                
                // 4. 선수 순위일 때만 나타나는 득점 / 도움 서브 토글 바
                if mainTab == 1 {
                    HStack(spacing: 12) {
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                selectedStatType = "goals"
                            }
                        }) {
                            Text("득점 순위")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(selectedStatType == "goals" ? .white : .gray)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(selectedStatType == "goals" ? Color.brandNavy : Color(UIColor.secondarySystemBackground))
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                selectedStatType = "assists"
                            }
                        }) {
                            Text("도움 순위")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(selectedStatType == "assists" ? .white : .gray)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(selectedStatType == "assists" ? Color.brandNavy : Color(UIColor.secondarySystemBackground))
                                .cornerRadius(8)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                }
                
                // 5. 메인 리스트 카드 영역
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("순위 정보 로드 중...")
                    Spacer()
                } else if viewModel.currentSeason == 2026 {
                    VStack(spacing: 20) {
                        Spacer()
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 60))
                            .foregroundColor(.gray.opacity(0.8))
                        
                        Text("2026 시즌 준비 중")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.brandNavy)
                        
                        Text("2026 시즌 성적 및 순위 정보는 준비 중입니다.\n이전 시즌(2025년 이하) 정보를 조회해 주세요.")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 40)
                } else {
                    ScrollView(showsIndicators: false) {
                        if mainTab == 0 {
                            // 팀 순위 테이블
                            TeamRankingTable(standings: viewModel.filteredStandings(forLeague: selectedLeague))
                                .padding(.horizontal, 16)
                                .padding(.bottom, 16)
                        } else {
                            // 선수 순위 리스트
                            VStack(spacing: 0) {
                                let rankings = viewModel.filteredPlayerRankings(forLeague: selectedLeague, type: selectedStatType)
                                
                                if rankings.isEmpty {
                                    Text("선수 순위 정보가 없습니다.")
                                        .foregroundColor(.gray)
                                        .padding(.vertical, 40)
                                } else {
                                    ForEach(rankings) { player in
                                        PlayerRankingRow(player: player)
                                        if player.id != rankings.last?.id {
                                            Divider()
                                                .padding(.horizontal, 16)
                                        }
                                    }
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchAllData(season: viewModel.currentSeason)
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
