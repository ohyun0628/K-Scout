import SwiftUI

// MARK: - K-League Team Emblem URL Resolver
public func teamEmblemURL(for teamName: String) -> String {
    let teamId: String
    if teamName.contains("울산") {
        teamId = "K01"
    } else if teamName.contains("수원 삼성") || teamName.contains("수원블루윙즈") {
        teamId = "K02"
    } else if teamName.contains("포항") {
        teamId = "K03"
    } else if teamName.contains("제주") {
        teamId = "K04"
    } else if teamName.contains("전북") {
        teamId = "K05"
    } else if teamName.contains("부산") {
        teamId = "K06"
    } else if teamName.contains("전남") {
        teamId = "K07"
    } else if teamName.contains("성남") {
        teamId = "K08"
    } else if teamName.contains("서울 FC") || teamName.contains("FC 서울") || (teamName == "서울" && !teamName.contains("이랜드")) {
        teamId = "K09"
    } else if teamName.contains("대전") {
        teamId = "K10"
    } else if teamName.contains("대구") {
        teamId = "K17"
    } else if teamName.contains("인천") {
        teamId = "K18"
    } else if teamName.contains("경남") {
        teamId = "K20"
    } else if teamName.contains("강원") {
        teamId = "K21"
    } else if teamName.contains("광주") {
        teamId = "K22"
    } else if teamName.contains("부천") {
        teamId = "K26"
    } else if teamName.contains("안양") {
        teamId = "K27"
    } else if teamName.contains("수원 FC") {
        teamId = "K29"
    } else if teamName.contains("이랜드") {
        teamId = "K31"
    } else if teamName.contains("안산") {
        teamId = "K32"
    } else if teamName.contains("아산") {
        teamId = "K34"
    } else if teamName.contains("김천") {
        teamId = "K35"
    } else if teamName.contains("김포") {
        teamId = "K36"
    } else if teamName.contains("청주") {
        teamId = "K37"
    } else if teamName.contains("천안") {
        teamId = "K38"
    } else {
        return ""
    }
    return "https://www.kleague.com/assets/images/emblem/emblem_\(teamId).png"
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
    let teamName: String
    let photoURL: String?
    var size: CGFloat = 42
    
    var body: some View {
        if let urlStr = photoURL, !urlStr.isEmpty {
            RemoteImageView(urlString: urlStr, size: size, fallback: AnyView(fallbackAvatar), isCircle: true)
        } else {
            fallbackAvatar
        }
    }
    
    private var fallbackAvatar: some View {
        ZStack {
            Circle()
                .fill(sharedLogoColor(for: teamName).opacity(0.1))
                .frame(width: size, height: size)
            
            Circle()
                .stroke(sharedLogoColor(for: teamName), lineWidth: 1.5)
                .frame(width: size, height: size)
            
            Text(String(playerName.prefix(1)))
                .font(.system(size: size * 0.4, weight: .bold))
                .foregroundColor(sharedLogoColor(for: teamName))
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
