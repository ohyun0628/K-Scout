import SwiftUI

// MARK: - K-League Team Emblem URL Resolver
public func teamEmblemURL(for teamName: String) -> String {
    if teamName.contains("울산") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/7/75/Ulsan_HD_FC_crest.svg/200px-Ulsan_HD_FC_crest.svg.png"
    } else if teamName.contains("전북") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/a/ab/Jeonbuk_Hyundai_Motors_FC_crest.svg/200px-Jeonbuk_Hyundai_Motors_FC_crest.svg.png"
    } else if teamName.contains("포항") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/5/52/Pohang_Steelers_crest.svg/200px-Pohang_Steelers_crest.svg.png"
    } else if teamName.contains("서울") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/1/15/FC_Seoul_Crest.svg/200px-FC_Seoul_Crest.svg.png"
    } else if teamName.contains("강원") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/1/17/Gangwon_FC_crest.svg/200px-Gangwon_FC_crest.svg.png"
    } else if teamName.contains("대구") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/a/a2/Daegu_FC_crest.svg/200px-Daegu_FC_crest.svg.png"
    } else if teamName.contains("인천") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/6/6f/Incheon_United_FC_crest.svg/200px-Incheon_United_FC_crest.svg.png"
    } else if teamName.contains("제주") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/6/61/Jeju_United_FC_crest.svg/200px-Jeju_United_FC_crest.svg.png"
    } else if teamName.contains("광주") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/4/4b/Gwangju_FC_crest.svg/200px-Gwangju_FC_crest.svg.png"
    } else if teamName.contains("대전") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/d/d4/Daejeon_Hana_Citizen_crest.svg/200px-Daejeon_Hana_Citizen_crest.svg.png"
    } else if teamName.contains("수원 FC") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/5/5f/Suwon_FC_crest.svg/200px-Suwon_FC_crest.svg.png"
    } else if teamName.contains("김천") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/4/49/Gimcheon_Sangmu_FC_crest.svg/200px-Gimcheon_Sangmu_FC_crest.svg.png"
    } else if teamName.contains("수원 삼성") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/d/da/Suwon_Samsung_Bluewings_Crest.svg/200px-Suwon_Samsung_Bluewings_Crest.svg.png"
    } else if teamName.contains("부산") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/d/df/Busan_IPark_crest.svg/200px-Busan_IPark_crest.svg.png"
    } else if teamName.contains("전남") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/7/7b/Jeonnam_Dragons_crest.svg/200px-Jeonnam_Dragons_crest.svg.png"
    } else if teamName.contains("성남") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/4/47/Seongnam_FC_crest.svg/200px-Seongnam_FC_crest.svg.png"
    } else if teamName.contains("안양") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/1/14/FC_Anyang_crest.svg/200px-FC_Anyang_crest.svg.png"
    } else if teamName.contains("부천") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/8/87/Bucheon_FC_1995_crest.svg/200px-Bucheon_FC_1995_crest.svg.png"
    } else if teamName.contains("아산") {
        return "https://upload.wikimedia.org/wikipedia/ko/thumb/5/59/Chungnam_Asan_FC_crest.svg/200px-Chungnam_Asan_FC_crest.svg.png"
    }
    return ""
}

// MARK: - Reusable Team Logo View
struct TeamLogoView: View {
    let teamName: String
    var size: CGFloat = 20
    
    var body: some View {
        let urlStr = teamEmblemURL(for: teamName)
        if !urlStr.isEmpty, let url = URL(string: urlStr) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size, height: size)
                default:
                    fallbackLogo
                }
            }
        } else {
            fallbackLogo
        }
    }
    
    private var fallbackLogo: some View {
        Circle()
            .fill(sharedLogoColor(for: teamName))
            .frame(width: size, height: size)
            .overlay(
                Text(String(teamName.prefix(1)))
                    .font(.system(size: size * 0.45, weight: .bold))
                    .foregroundColor(.white)
            )
    }
}

// MARK: - Reusable Player Avatar View
struct PlayerAvatarView: View {
    let playerName: String
    var size: CGFloat = 42
    
    var body: some View {
        // Pravatar 실사 인물 사진 70장 중 이름 해시값에 맵핑
        let imgIndex = abs(playerName.hashValue) % 70 + 1
        let urlStr = "https://i.pravatar.cc/150?img=\(imgIndex)"
        
        if let url = URL(string: urlStr) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray.opacity(0.15), lineWidth: 0.5))
                default:
                    fallbackAvatar
                }
            }
        } else {
            fallbackAvatar
        }
    }
    
    private var fallbackAvatar: some View {
        ZStack {
            Circle()
                .fill(Color(UIColor.secondarySystemBackground))
                .frame(width: size, height: size)
            
            Image(systemName: "person.fill")
                .font(.system(size: size * 0.45))
                .foregroundColor(.gray.opacity(0.6))
            
            Text(String(playerName.prefix(1)))
                .font(.system(size: size * 0.35, weight: .bold))
                .foregroundColor(Color.brandNavy.opacity(0.15))
        }
    }
}

// MARK: - Shared Logo Color Helper
public func sharedLogoColor(for teamName: String) -> Color {
    if teamName.contains("울산") {
        return Color(red: 0.0, green: 0.2, blue: 0.6)
    } else if teamName.contains("전북") {
        return Color(red: 0.1, green: 0.6, blue: 0.1)
    } else if teamName.contains("포항") {
        return Color(red: 0.1, green: 0.1, blue: 0.1)
    } else if teamName.contains("수원 FC") {
        return Color(red: 0.05, green: 0.15, blue: 0.35)
    } else if teamName.contains("수원 삼성") {
        return Color(red: 0.0, green: 0.3, blue: 0.8)
    } else if teamName.contains("서울") {
        return Color(red: 0.8, green: 0.1, blue: 0.1)
    } else if teamName.contains("대전") {
        return Color(red: 0.0, green: 0.35, blue: 0.25)
    } else if teamName.contains("강원") {
        return Color(red: 0.95, green: 0.5, blue: 0.1)
    } else if teamName.contains("광주") {
        return Color(red: 0.9, green: 0.7, blue: 0.0)
    } else if teamName.contains("대구") {
        return Color(red: 0.35, green: 0.65, blue: 0.85)
    } else if teamName.contains("인천") {
        return Color(red: 0.0, green: 0.25, blue: 0.5)
    } else if teamName.contains("제주") {
        return Color(red: 0.9, green: 0.35, blue: 0.0)
    } else if teamName.contains("김천") {
        return Color(red: 0.75, green: 0.1, blue: 0.15)
    } else if teamName.contains("부산") {
        return Color(red: 0.8, green: 0.05, blue: 0.05)
    } else if teamName.contains("전남") {
        return Color(red: 0.95, green: 0.75, blue: 0.0)
    } else if teamName.contains("성남") {
        return Color(red: 0.15, green: 0.15, blue: 0.15)
    } else if teamName.contains("안양") {
        return Color(red: 0.35, green: 0.15, blue: 0.55)
    } else if teamName.contains("부천") {
        return Color(red: 0.8, green: 0.0, blue: 0.1)
    } else if teamName.contains("충남아산") {
        return Color(red: 0.0, green: 0.45, blue: 0.75)
    }
    return Color.brandNavy
}
