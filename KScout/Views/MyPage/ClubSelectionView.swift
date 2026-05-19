import SwiftUI

struct ClubInfo: Identifiable {
    let id: UUID
    let name: String
    let primaryColor: Color
    let secondaryColor: Color
    let region: String
    
    init(name: String, primaryColor: Color, secondaryColor: Color, region: String) {
        self.id = UUID()
        self.name = name
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.region = region
    }
}

struct ClubSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("favoriteClub") private var favoriteClub = "선택 안 함"
    @State private var searchText = ""
    
    // K리그 구단 상세 정보 및 커스텀 테마 색상 설정
    let clubs: [ClubInfo] = [
        ClubInfo(name: "선택 안 함", primaryColor: .gray, secondaryColor: .white, region: "설정 해제"),
        ClubInfo(name: "울산 HD FC", primaryColor: Color(red: 0.0, green: 0.2, blue: 0.6), secondaryColor: Color(red: 1.0, green: 0.8, blue: 0.0), region: "울산"),
        ClubInfo(name: "전북 현대 모터스", primaryColor: Color(red: 0.0, green: 0.5, blue: 0.2), secondaryColor: Color(red: 0.9, green: 1.0, blue: 0.9), region: "전북"),
        ClubInfo(name: "광주 FC", primaryColor: Color(red: 0.9, green: 0.7, blue: 0.0), secondaryColor: Color(red: 0.8, green: 0.1, blue: 0.1), region: "광주"),
        ClubInfo(name: "포항 스틸러스", primaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), secondaryColor: Color(red: 0.9, green: 0.1, blue: 0.1), region: "포항"),
        ClubInfo(name: "FC 서울", primaryColor: Color(red: 0.8, green: 0.1, blue: 0.1), secondaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), region: "서울"),
        ClubInfo(name: "인천 유나이티드", primaryColor: Color(red: 0.0, green: 0.2, blue: 0.6), secondaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), region: "인천"),
        ClubInfo(name: "대구 FC", primaryColor: Color(red: 0.4, green: 0.7, blue: 0.9), secondaryColor: Color.white, region: "대구"),
        ClubInfo(name: "대전 하나 시티즌", primaryColor: Color(red: 0.0, green: 0.4, blue: 0.2), secondaryColor: Color(red: 0.6, green: 0.1, blue: 0.2), region: "대전"),
        ClubInfo(name: "제주 유나이티드", primaryColor: Color(red: 0.9, green: 0.4, blue: 0.0), secondaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), region: "제주"),
        ClubInfo(name: "강원 FC", primaryColor: Color(red: 0.9, green: 0.3, blue: 0.0), secondaryColor: Color(red: 0.0, green: 0.4, blue: 0.2), region: "강원"),
        ClubInfo(name: "수원 FC", primaryColor: Color(red: 0.8, green: 0.1, blue: 0.2), secondaryColor: Color(red: 0.0, green: 0.1, blue: 0.4), region: "수원"),
        ClubInfo(name: "김천 상무", primaryColor: Color(red: 0.8, green: 0.1, blue: 0.2), secondaryColor: Color(red: 0.0, green: 0.2, blue: 0.4), region: "김천"),
        ClubInfo(name: "수원 삼성 블루윙즈", primaryColor: Color(red: 0.0, green: 0.2, blue: 0.7), secondaryColor: Color(red: 1.0, green: 0.9, blue: 0.0), region: "수원"),
        ClubInfo(name: "부산 아이파크", primaryColor: Color(red: 0.8, green: 0.1, blue: 0.1), secondaryColor: Color.white, region: "부산"),
        ClubInfo(name: "서울 이랜드 FC", primaryColor: Color(red: 0.05, green: 0.1, blue: 0.2), secondaryColor: Color(red: 0.8, green: 0.6, blue: 0.2), region: "서울"),
        ClubInfo(name: "전남 드래곤즈", primaryColor: Color(red: 0.9, green: 0.7, blue: 0.0), secondaryColor: Color(red: 0.1, green: 0.1, blue: 0.1), region: "전남")
    ]
    
    // 이니셜 생성 도우미
    private func getClubInitial(_ name: String) -> String {
        if name == "선택 안 함" { return "X" }
        // 첫 단어의 첫 글자 반환
        return String(name.prefix(1))
    }
    
    // 검색어 필터링 리스트
    var filteredClubs: [ClubInfo] {
        if searchText.isEmpty {
            return clubs
        } else {
            return clubs.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.region.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 검색창
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("구단 이름 또는 연고지 검색", text: $searchText)
                        .font(.subheadline)
                    
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                // 구단 목록 리스트
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredClubs) { club in
                            Button(action: {
                                withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                    favoriteClub = club.name
                                }
                                // 마이페이지에서 상세 화면 형식으로 띄울 때 뒤로가기 액션
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                HStack(spacing: 16) {
                                    // 구단 엠블럼 심볼
                                    ZStack {
                                        Circle()
                                            .fill(club.primaryColor)
                                            .frame(width: 46, height: 46)
                                        
                                        Circle()
                                            .stroke(club.secondaryColor, lineWidth: 2)
                                            .frame(width: 40, height: 40)
                                        
                                        Text(getClubInitial(club.name))
                                            .font(.system(size: 16, weight: .black))
                                            .foregroundColor(club.name == "선택 안 함" ? .white : club.secondaryColor)
                                    }
                                    .shadow(color: club.primaryColor.opacity(0.2), radius: 4, x: 0, y: 2)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(club.name)
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                        
                                        Text(club.region)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    if favoriteClub == club.name {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.title3)
                                            .foregroundColor(.brandNavy)
                                            .transition(.scale.combined(with: .opacity))
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 4)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationTitle("선호 구단 설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}



struct ClubSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClubSelectionView()
        }
    }
}
