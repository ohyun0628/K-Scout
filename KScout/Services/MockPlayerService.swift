import Foundation

class MockPlayerService {
    static let shared = MockPlayerService()
    
    // 이 값을 true로 바꾸면 API 통신 대신 Mock 데이터를 사용합니다.
    var useMockData: Bool = true
    
    private init() {}
    
    func getMockPlayerDetail() -> [PlayerDetailItem] {
        let jsonString = """
        [{"player":{"id":2905,"name":"Lee Chung-Yong","firstname":"Chung-Yong","lastname":"Lee","age":37,"birth":{"date":"1988-07-02","place":"Seoul","country":"Korea Republic"},"nationality":"Korea Republic","height":"180","weight":"70","injured":false,"photo":"https://media.api-sports.io/football/players/2905.png"},"statistics":[{"team":{"id":2767,"name":"Ulsan Hyundai FC","logo":"https://media.api-sports.io/football/teams/2767.png"},"league":{"id":292,"name":"K League 1","country":"South-Korea","logo":"https://media.api-sports.io/football/leagues/292.png","flag":"https://media.api-sports.io/flags/kr.svg","season":2024},"games":{"appearences":23,"lineups":7,"minutes":931,"number":27,"position":"Midfielder","rating":"7.000000","captain":false},"substitutes":{"in":16,"out":6,"bench":18},"shots":{"total":2,"on":2},"goals":{"total":0,"conceded":0,"assists":2,"saves":null},"passes":{"total":157,"key":6,"accuracy":null},"tackles":{"total":8,"blocks":1,"interceptions":2},"duels":{"total":26,"won":15},"dribbles":{"attempts":3,"success":null,"past":null},"fouls":{"drawn":6,"committed":2},"cards":{"yellow":3,"yellowred":0,"red":0},"penalty":{"won":null,"commited":null,"scored":0,"missed":0,"saved":null}},{"team":{"id":2767,"name":"Ulsan Hyundai FC","logo":"https://media.api-sports.io/football/teams/2767.png"},"league":{"id":292,"name":"K League 1","country":"South-Korea","logo":"https://media.api-sports.io/football/leagues/292.png","flag":"https://media.api-sports.io/flags/kr.svg","season":2023},"games":{"appearences":28,"lineups":15,"minutes":1420,"number":27,"position":"Midfielder","rating":"7.100000","captain":true},"substitutes":{"in":13,"out":10,"bench":13},"shots":{"total":5,"on":3},"goals":{"total":2,"conceded":0,"assists":4,"saves":null},"passes":{"total":200,"key":10,"accuracy":null},"tackles":{"total":12,"blocks":2,"interceptions":5},"duels":{"total":40,"won":22},"dribbles":{"attempts":5,"success":2,"past":null},"fouls":{"drawn":10,"committed":4},"cards":{"yellow":1,"yellowred":0,"red":0},"penalty":{"won":null,"commited":null,"scored":0,"missed":0,"saved":null}}]}]
        """
        
        guard let data = jsonString.data(using: .utf8) else { return [] }
        do {
            let items = try JSONDecoder().decode([PlayerDetailItem].self, from: data)
            return items
        } catch {
            print("Mock decode error: \\(error)")
            return []
        }
    }
}
