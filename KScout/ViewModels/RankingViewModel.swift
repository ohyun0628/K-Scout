import Foundation

class RankingViewModel: ObservableObject {
    @Published var standings: [Standing] = []
    @Published var playerRankings: [PlayerRanking] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // 리그별/구분별 필터 데이터 리턴
    func filteredStandings(forLeague league: Int) -> [Standing] {
        return standings.filter { $0.league == league }.sorted { $0.rank < $1.rank }
    }
    
    func filteredPlayerRankings(forLeague league: Int, type: String) -> [PlayerRanking] {
        return playerRankings.filter { $0.league == league && $0.type == type }.sorted { $0.rank < $1.rank }
    }
    
    func fetchAllData() {
        self.isLoading = true
        
        // 데이터 패치 시뮬레이션
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.standings = self.mockStandings
            self.playerRankings = self.mockPlayerRankings
            self.isLoading = false
        }
    }
    
    // MARK: - Mock Data
    private let mockStandings: [Standing] = [
        // K리그1 팀 순위
        Standing(id: 101, rank: 1, teamName: "울산 HD", points: 33, goalsDiff: 15, played: 15, won: 10, draw: 3, lost: 2, league: 1),
        Standing(id: 102, rank: 2, teamName: "전북 현대", points: 31, goalsDiff: 12, played: 15, won: 9, draw: 4, lost: 2, league: 1),
        Standing(id: 103, rank: 3, teamName: "포항 스틸러스", points: 29, goalsDiff: 8, played: 15, won: 8, draw: 5, lost: 2, league: 1),
        Standing(id: 104, rank: 4, teamName: "수원 FC", points: 25, goalsDiff: 2, played: 15, won: 7, draw: 4, lost: 4, league: 1),
        Standing(id: 105, rank: 5, teamName: "서울 FC", points: 24, goalsDiff: 3, played: 15, won: 6, draw: 6, lost: 3, league: 1),
        Standing(id: 106, rank: 6, teamName: "대전 하나", points: 20, goalsDiff: -1, played: 15, won: 5, draw: 5, lost: 5, league: 1),
        Standing(id: 107, rank: 7, teamName: "강원 FC", points: 16, goalsDiff: -6, played: 15, won: 4, draw: 4, lost: 7, league: 1),
        Standing(id: 108, rank: 8, teamName: "광주 FC", points: 12, goalsDiff: -10, played: 15, won: 3, draw: 3, lost: 9, league: 1),
        Standing(id: 109, rank: 9, teamName: "대구 FC", points: 11, goalsDiff: -8, played: 15, won: 2, draw: 5, lost: 8, league: 1),
        Standing(id: 110, rank: 10, teamName: "인천 유나이티드", points: 10, goalsDiff: -11, played: 15, won: 2, draw: 4, lost: 9, league: 1),
        Standing(id: 111, rank: 11, teamName: "제주 유나이티드", points: 9, goalsDiff: -12, played: 15, won: 2, draw: 3, lost: 10, league: 1),
        Standing(id: 112, rank: 12, teamName: "김천 상무", points: 9, goalsDiff: -12, played: 15, won: 1, draw: 6, lost: 8, league: 1),
        
        // K리그2 팀 순위
        Standing(id: 201, rank: 1, teamName: "부산 아이파크", points: 31, goalsDiff: 10, played: 15, won: 9, draw: 4, lost: 2, league: 2),
        Standing(id: 202, rank: 2, teamName: "수원 삼성", points: 29, goalsDiff: 8, played: 15, won: 8, draw: 5, lost: 2, league: 2),
        Standing(id: 203, rank: 3, teamName: "서울 이랜드", points: 26, goalsDiff: 5, played: 15, won: 7, draw: 5, lost: 3, league: 2),
        Standing(id: 204, rank: 4, teamName: "전남 드래곤즈", points: 24, goalsDiff: 3, played: 15, won: 6, draw: 6, lost: 3, league: 2),
        Standing(id: 205, rank: 5, teamName: "성남 FC", points: 20, goalsDiff: 0, played: 15, won: 5, draw: 5, lost: 5, league: 2),
        Standing(id: 206, rank: 6, teamName: "FC 안양", points: 18, goalsDiff: -2, played: 15, won: 4, draw: 6, lost: 5, league: 2),
        Standing(id: 207, rank: 7, teamName: "부천 FC 1995", points: 16, goalsDiff: -3, played: 15, won: 3, draw: 7, lost: 5, league: 2),
        Standing(id: 208, rank: 8, teamName: "충남아산 FC", points: 14, goalsDiff: -5, played: 15, won: 3, draw: 5, lost: 7, league: 2)
    ]
    
    private var mockPlayerRankings: [PlayerRanking] {
        return [
            // K리그1 - 득점 순위
            PlayerRanking(id: UUID(), rank: 1, playerName: "주민규", teamName: "울산 HD", statCount: 14, played: 16, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "일류첸코", teamName: "서울 FC", statCount: 11, played: 15, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "무고사", teamName: "인천 유나이티드", statCount: 10, played: 15, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 4, playerName: "송민규", teamName: "전북 현대", statCount: 8, played: 14, league: 1, type: "goals"),
            PlayerRanking(id: UUID(), rank: 5, playerName: "이승우", teamName: "수원 FC", statCount: 8, played: 15, league: 1, type: "goals"),
            
            // K리그1 - 도움 순위
            PlayerRanking(id: UUID(), rank: 1, playerName: "세징야", teamName: "대구 FC", statCount: 7, played: 15, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "설영우", teamName: "울산 HD", statCount: 6, played: 14, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "기성용", teamName: "서울 FC", statCount: 5, played: 15, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 4, playerName: "백승호", teamName: "전북 현대", statCount: 5, played: 13, league: 1, type: "assists"),
            PlayerRanking(id: UUID(), rank: 5, playerName: "안데르손", teamName: "수원 FC", statCount: 4, played: 15, league: 1, type: "assists"),
            
            // K리그2 - 득점 순위
            PlayerRanking(id: UUID(), rank: 1, playerName: "조나탄", teamName: "FC 안양", statCount: 12, played: 15, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "루페타", teamName: "부천 FC 1995", statCount: 9, played: 14, league: 2, type: "goals"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 8, played: 15, league: 2, type: "goals"),
            
            // K리그2 - 도움 순위
            PlayerRanking(id: UUID(), rank: 1, playerName: "발디비아", teamName: "전남 드래곤즈", statCount: 8, played: 15, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 2, playerName: "플라나", teamName: "전남 드래곤즈", statCount: 6, played: 14, league: 2, type: "assists"),
            PlayerRanking(id: UUID(), rank: 3, playerName: "주닝요", teamName: "충남아산 FC", statCount: 5, played: 15, league: 2, type: "assists")
        ]
    }
}
