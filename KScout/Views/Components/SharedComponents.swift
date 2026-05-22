import SwiftUI

// MARK: - K-League Team Emblem URL Resolver
public func teamEmblemURL(for teamName: String) -> String {
    if teamName.contains("울산") {
        return "https://media.api-sports.io/football/teams/982.png"
    } else if teamName.contains("전북") {
        return "https://media.api-sports.io/football/teams/983.png"
    } else if teamName.contains("포항") {
        return "https://media.api-sports.io/football/teams/984.png"
    } else if teamName.contains("수원 FC") {
        return "https://media.api-sports.io/football/teams/2032.png"
    } else if teamName.contains("수원 삼성") || teamName.contains("수원블루윙즈") {
        return "https://media.api-sports.io/football/teams/986.png"
    } else if teamName.contains("서울") {
        return "https://media.api-sports.io/football/teams/985.png"
    } else if teamName.contains("대전") {
        return "https://media.api-sports.io/football/teams/994.png"
    } else if teamName.contains("강원") {
        return "https://media.api-sports.io/football/teams/989.png"
    } else if teamName.contains("광주") {
        return "https://media.api-sports.io/football/teams/993.png"
    } else if teamName.contains("대구") {
        return "https://media.api-sports.io/football/teams/991.png"
    } else if teamName.contains("인천") {
        return "https://media.api-sports.io/football/teams/992.png"
    } else if teamName.contains("제주") {
        return "https://media.api-sports.io/football/teams/990.png"
    } else if teamName.contains("김천") {
        return "https://media.api-sports.io/football/teams/2938.png"
    } else if teamName.contains("부산") {
        return "https://media.api-sports.io/football/teams/2030.png"
    } else if teamName.contains("전남") {
        return "https://media.api-sports.io/football/teams/2031.png"
    } else if teamName.contains("성남") {
        return "https://media.api-sports.io/football/teams/987.png"
    } else if teamName.contains("안양") {
        return "https://media.api-sports.io/football/teams/2033.png"
    } else if teamName.contains("부천") {
        return "https://media.api-sports.io/football/teams/2034.png"
    } else if teamName.contains("아산") {
        return "https://media.api-sports.io/football/teams/3222.png"
    }
    return ""
}

// MARK: - Reusable Remote Image View (for compatibility with older iOS SDKs without AsyncImage)
struct RemoteImageView: View {
    let urlString: String
    var size: CGFloat
    let fallback: AnyView
    let isCircle: Bool
    
    @State private var uiImage: UIImage? = nil
    
    var body: some View {
        Group {
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: isCircle ? .fill : .fit)
                    .frame(width: size, height: size)
                    .conditionalClip(isCircle: isCircle, size: size)
            } else {
                fallback
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error loading remote image: \(error.localizedDescription)")
                return
            }
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.uiImage = loadedImage
                }
            }
        }.resume()
    }
}

extension View {
    @ViewBuilder
    func conditionalClip(isCircle: Bool, size: CGFloat) -> some View {
        if isCircle {
            self.clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.15), lineWidth: 0.5))
        } else {
            self
        }
    }
}

// MARK: - Reusable Team Logo View
struct TeamLogoView: View {
    let teamName: String
    var size: CGFloat = 20
    
    var body: some View {
        let urlStr = teamEmblemURL(for: teamName)
        if !urlStr.isEmpty {
            RemoteImageView(urlString: urlStr, size: size, fallback: AnyView(fallbackLogo), isCircle: false)
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
        
        RemoteImageView(urlString: urlStr, size: size, fallback: AnyView(fallbackAvatar), isCircle: true)
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
