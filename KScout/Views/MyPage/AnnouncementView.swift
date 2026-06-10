import SwiftUI
import FirebaseAuth
struct Announcement: Identifiable, Codable {
    var id = UUID()
    let title: String
    let date: String
    let content: String
    var isImportant: Bool = false
}

struct AnnouncementView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var expandedId: UUID? = nil
    @State private var showWriteView = false
    @State private var announcements: [Announcement] = []
    
    // 기본 공지사항 목업 리스트
    let defaultAnnouncements = [
        Announcement(
            title: "[업데이트] K-Scout 정식 출시 및 V1.0 업데이트 안내",
            date: "2026.06.14",
            content: "안녕하세요, K-Scout 팀입니다.\n\n대한민국 K리그 최고의 축구 데이터를 제공하는 K-Scout 모바일 서비스(V1.0)가 정식 출시되었습니다!\n2022년부터 2026년까지의 K리그 전 시즌 경기 일정 및 선수 스카우팅 리포트를 제공합니다.\n\n앞으로도 더 정교하고 정확한 데이터를 분석하여 제공해 드리겠습니다. 많은 사랑 부탁드립니다. 감사합니다.",
            isImportant: true
        ),
        Announcement(
            title: "[기능 안내] 오프라인 환경(Mock 데이터) 완벽 지원 안내",
            date: "2026.06.12",
            content: "K-Scout은 언제 어디서나 끊김 없이 데이터를 확인할 수 있도록 설계되었습니다.\n\n데이터 네트워크가 끊어지거나 API 통신이 원활하지 않은 상황에서도, 앱 내부에 내장된 대규모 로컬 데이터베이스(Mock DB) 모드로 자동 전환되어 무중단 서비스를 제공합니다.\n오프라인 상태에서도 안심하고 스카우팅 데이터를 분석해 보세요!",
            isImportant: false
        ),
        Announcement(
            title: "[기능 안내] 선수 스탯 '육각형 레이더 차트' 시각화 기능 추가",
            date: "2026.06.10",
            content: "선수 상세 분석 페이지에 '육각형 레이더 차트' 기능이 새롭게 추가되었습니다.\n\n득점, 도움, 슛, 패스, 수비 등 5가지 주요 지표를 직관적인 도형 그래프로 시각화하여, 해당 선수의 강점과 약점을 한눈에 파악할 수 있습니다.\n선수 검색 기능을 통해 직접 확인해 보세요.",
            isImportant: false
        )
    ]
    
    // 관리자 여부 확인 연산 프로퍼티
    private var isAdmin: Bool {
        // 1. 오프라인 시연(Mock) 모드일 때는 기능 시연을 위해 항상 활성화
        if MockPlayerService.shared.useMockData {
            return true
        }
        // 2. 실제 운영 환경에서는 로그인된 유저의 이메일이 관리자 계정인지 확인
        if let email = FirebaseAuth.Auth.auth().currentUser?.email, email == "test@abc.com" {
            return true
        }
        return false
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            if announcements.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "megaphone.slash")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                    Text("등록된 공지사항이 없습니다.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(announcements) { announcement in
                            VStack(alignment: .leading, spacing: 0) {
                                // 공지사항 헤더
                                Button(action: {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                        if expandedId == announcement.id {
                                            expandedId = nil
                                        } else {
                                            expandedId = announcement.id
                                        }
                                    }
                                }) {
                                    HStack(alignment: .top, spacing: 12) {
                                        // 중요 표시 배지
                                        if announcement.isImportant {
                                            Text("중요")
                                                .font(.system(size: 11, weight: .bold))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.red)
                                                .cornerRadius(6)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(announcement.title)
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundColor(Color.brandNavy)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)
                                            
                                            Text(announcement.date)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.gray)
                                            .rotationEffect(.degrees(expandedId == announcement.id ? 180 : 0))
                                    }
                                    .padding()
                                }
                                
                                // 본문 영역 (열렸을 때 활성화)
                                if expandedId == announcement.id {
                                    Divider()
                                        .padding(.horizontal)
                                    
                                    VStack(alignment: .leading, spacing: 14) {
                                        Text(announcement.content)
                                            .font(.subheadline)
                                            .foregroundColor(.primary.opacity(0.8))
                                            .lineSpacing(6)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        // 관리자용 삭제 버튼 추가
                                        if isAdmin {
                                            HStack {
                                                Spacer()
                                                Button(action: {
                                                    deleteAnnouncement(announcement)
                                                }) {
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "trash")
                                                        Text("삭제")
                                                    }
                                                    .font(.caption)
                                                    .foregroundColor(.red)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 6)
                                                    .background(Color.red.opacity(0.08))
                                                    .cornerRadius(8)
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                    .background(Color(.systemGray6).opacity(0.4))
                                }
                            }
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 3)
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationTitle("공지사항")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Group {
                if isAdmin {
                    Button(action: { showWriteView = true }) {
                        HStack(spacing: 4) {
                            Image(systemName: "square.and.pencil")
                            Text("글쓰기")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.brandNavy)
                    }
                } else {
                    EmptyView()
                }
            }
        )
        .sheet(isPresented: $showWriteView) {
            AnnouncementWriteView { newAnnouncement in
                addAnnouncement(newAnnouncement)
            }
        }
        .onAppear {
            loadAnnouncements()
        }
    }
    
    // MARK: - 로컬 저장소 CRUD 연동
    
    private func loadAnnouncements() {
        if let data = UserDefaults.standard.data(forKey: "kscout_announcements_v2"),
           let decoded = try? JSONDecoder().decode([Announcement].self, from: data) {
            self.announcements = decoded
        } else {
            // 처음 켰을 때 기본 목업 리스트 등록
            self.announcements = defaultAnnouncements
            saveToStorage(defaultAnnouncements)
        }
    }
    
    private func saveToStorage(_ list: [Announcement]) {
        if let encoded = try? JSONEncoder().encode(list) {
            UserDefaults.standard.set(encoded, forKey: "kscout_announcements_v2")
        }
    }
    
    private func addAnnouncement(_ item: Announcement) {
        withAnimation(.spring()) {
            if item.isImportant {
                // 중요 공지는 맨 위에 배치
                announcements.insert(item, at: 0)
            } else {
                // 일반 공지는 중요 공지 다음 또는 가장 위에 배치
                if let firstNormalIndex = announcements.firstIndex(where: { !$0.isImportant }) {
                    announcements.insert(item, at: firstNormalIndex)
                } else {
                    announcements.append(item)
                }
            }
            saveToStorage(announcements)
        }
    }
    
    private func deleteAnnouncement(_ item: Announcement) {
        withAnimation(.spring()) {
            announcements.removeAll { $0.id == item.id }
            saveToStorage(announcements)
            if expandedId == item.id {
                expandedId = nil
            }
        }
    }
}

struct AnnouncementView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnnouncementView()
                .environmentObject(AuthManager())
        }
    }
}
