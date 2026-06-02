import SwiftUI

struct ClubInfo: Identifiable {
    let id: UUID
    let name: String
    let logoURL: String?
    let primaryColor: Color
    let secondaryColor: Color
    let region: String
    
    init(name: String, logoURL: String? = nil, primaryColor: Color, secondaryColor: Color, region: String) {
        self.id = UUID()
        self.name = name
        self.logoURL = logoURL
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.region = region
    }
    
    static let allClubs: [ClubInfo] = [
        ClubInfo(name: "선택 안 함", logoURL: nil, primaryColor: .gray, secondaryColor: .white, region: "설정 해제"),
        ClubInfo(name: "울산 HD FC", logoURL: "https://media.api-sports.io/football/teams/2767.png", primaryColor: Color(red: 0.0, green: 0.2, blue: 0.6), secondaryColor: Color(red: 1.0, green: 0.8, blue: 0.0), region: "울산"),
        ClubInfo(name: "전북 현대 모터스", logoURL: "https://media.api-sports.io/football/teams/2762.png", primaryColor: Color(red: 0.0, green: 0.5, blue: 0.2), secondaryColor: Color(red: 0.9, green: 1.0, blue: 0.9), region: "전북"),
        ClubInfo(name: "광주 FC", logoURL: "https://media.api-sports.io/football/teams/2759.png", primaryColor: Color(red: 0.9, green: 0.7, blue: 0.0), secondaryColor: Color(red: 0.8, green: 0.1, blue: 0.1), region: "광주"),
        ClubInfo(name: "포항 스틸러스", logoURL: "https://media.api-sports.io/football/teams/2764.png", primaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), secondaryColor: Color(red: 0.9, green: 0.1, blue: 0.1), region: "포항"),
        ClubInfo(name: "FC 서울", logoURL: "https://media.api-sports.io/football/teams/2766.png", primaryColor: Color(red: 0.8, green: 0.1, blue: 0.1), secondaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), region: "서울"),
        ClubInfo(name: "인천 유나이티드", logoURL: "https://media.api-sports.io/football/teams/2763.png", primaryColor: Color(red: 0.0, green: 0.2, blue: 0.6), secondaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), region: "인천"),
        ClubInfo(name: "대구 FC", logoURL: "https://media.api-sports.io/football/teams/2747.png", primaryColor: Color(red: 0.4, green: 0.7, blue: 0.9), secondaryColor: Color.white, region: "대구"),
        ClubInfo(name: "대전 하나 시티즌", logoURL: "https://media.api-sports.io/football/teams/2750.png", primaryColor: Color(red: 0.0, green: 0.4, blue: 0.2), secondaryColor: Color(red: 0.6, green: 0.1, blue: 0.2), region: "대전"),
        ClubInfo(name: "제주 유나이티드", logoURL: "https://media.api-sports.io/football/teams/2761.png", primaryColor: Color(red: 0.9, green: 0.4, blue: 0.0), secondaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), region: "제주"),
        ClubInfo(name: "강원 FC", logoURL: "https://media.api-sports.io/football/teams/2746.png", primaryColor: Color(red: 0.9, green: 0.3, blue: 0.0), secondaryColor: Color(red: 0.0, green: 0.4, blue: 0.2), region: "강원"),
        ClubInfo(name: "수원 FC", logoURL: "https://media.api-sports.io/football/teams/2756.png", primaryColor: Color(red: 0.8, green: 0.1, blue: 0.2), secondaryColor: Color(red: 0.0, green: 0.1, blue: 0.4), region: "수원"),
        ClubInfo(name: "김천 상무", logoURL: "https://media.api-sports.io/football/teams/2768.png", primaryColor: Color(red: 0.8, green: 0.1, blue: 0.2), secondaryColor: Color(red: 0.0, green: 0.2, blue: 0.4), region: "김천"),
        ClubInfo(name: "수원 삼성 블루윙즈", logoURL: "https://media.api-sports.io/football/teams/2765.png", primaryColor: Color(red: 0.0, green: 0.2, blue: 0.7), secondaryColor: Color(red: 1.0, green: 0.9, blue: 0.0), region: "수원"),
        ClubInfo(name: "부산 아이파크", logoURL: "https://media.api-sports.io/football/teams/2752.png", primaryColor: Color(red: 0.8, green: 0.1, blue: 0.1), secondaryColor: Color.white, region: "부산"),
        ClubInfo(name: "서울 이랜드 FC", logoURL: "https://media.api-sports.io/football/teams/2749.png", primaryColor: Color(red: 0.05, green: 0.1, blue: 0.2), secondaryColor: Color(red: 0.8, green: 0.6, blue: 0.2), region: "서울"),
        ClubInfo(name: "전남 드래곤즈", logoURL: "https://media.api-sports.io/football/teams/2760.png", primaryColor: Color(red: 0.9, green: 0.7, blue: 0.0), secondaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), region: "전남")
    ]
    
    static func getClubInitial(_ name: String) -> String {
        if name == "선택 안 함" { return "X" }
        return String(name.prefix(1))
    }
    
    static func getClub(by name: String) -> ClubInfo? {
        return allClubs.first { $0.name == name }
    }
}
