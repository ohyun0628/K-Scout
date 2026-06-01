import SwiftUI

struct ClubSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("favoriteClub") private var favoriteClub = "선택 안 함"
    @State private var searchText = ""
    
    // 검색어 필터링 리스트
    var filteredClubs: [ClubInfo] {
        if searchText.isEmpty {
            return ClubInfo.allClubs
        } else {
            return ClubInfo.allClubs.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.region.localizedCaseInsensitiveContains(searchText) }
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
                                        
                                        Text(ClubInfo.getClubInitial(club.name))
                                            .font(.system(size: 16, weight: .black))
                                            .foregroundColor(club.name == "선택 안 함" ? .white : club.secondaryColor)
                                    }
                                    .shadow(color: club.primaryColor.opacity(0.2), radius: 4, x: 0, y: 2)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(club.name)
                                            .font(.system(size: 16, weight: .bold))
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
