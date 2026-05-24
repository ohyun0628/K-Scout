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

public func resolvedPlayerPhotoURL(for playerName: String) -> String? {
    let photos: [String: String] = [
        "주민규": "https://media.api-sports.io/football/players/34427.png",
        "티아고": "https://media.api-sports.io/football/players/197251.png",
        "이승우": "https://media.api-sports.io/football/players/2914.png",
        "라스": "https://media.api-sports.io/football/players/37445.png",
        "나상호": "https://media.api-sports.io/football/players/2908.png",
        "제르소": "https://media.api-sports.io/football/players/51267.png",
        "Kim In-Gyun": "https://media.api-sports.io/football/players/228842.png",
        "Goh Young-Jun": "https://media.api-sports.io/football/players/201279.png",
        "Reis": "https://media.api-sports.io/football/players/9659.png",
        "M. Ishida": "https://media.api-sports.io/football/players/91772.png",
        "에르난데스": "https://media.api-sports.io/football/players/266665.png",
        "Moon Seon-Min": "https://media.api-sports.io/football/players/34392.png",
        "Cheon Seong-Hoon": "https://media.api-sports.io/football/players/25305.png",
        "Eom Ji-Sung": "https://media.api-sports.io/football/players/237050.png",
        "Willyan": "https://media.api-sports.io/football/players/34144.png",
        "G. Ludwigson": "https://media.api-sports.io/football/players/47706.png",
        "Go Jae-Hyeon": "https://media.api-sports.io/football/players/34469.png",
        "제카": "https://media.api-sports.io/football/players/140564.png",
        "Lee Myung-Jae": "https://media.api-sports.io/football/players/34420.png",
        "Lee Jin-Hyun": "https://media.api-sports.io/football/players/2907.png",
        "Doo Hyeon-Seok": "https://media.api-sports.io/football/players/34145.png",
        "세징야": "https://media.api-sports.io/football/players/34484.png",
        "A. Paločević": "https://media.api-sports.io/football/players/41472.png",
        "Leandro Ribeiro": "https://media.api-sports.io/football/players/77860.png",
        "Kim Do-Hyeok": "https://media.api-sports.io/football/players/99230.png",
        "Seol Young-Woo": "https://media.api-sports.io/football/players/197985.png",
        "무고사": "https://media.api-sports.io/football/players/34822.png",
        "일류첸코": "https://media.api-sports.io/football/players/25276.png",
        "Lee Sang-Heon": "https://media.api-sports.io/football/players/34442.png",
        "Yang Min-Hyeok": "https://media.api-sports.io/football/players/423708.png",
        "Jeong Seung-Won": "https://media.api-sports.io/football/players/34480.png",
        "Lee Ho-Jae": "https://media.api-sports.io/football/players/304972.png",
        "야고": "https://media.api-sports.io/football/players/35821.png",
        "Jeong Jae-Hee": "https://media.api-sports.io/football/players/34355.png",
        "안데르손": "https://media.api-sports.io/football/players/9292.png",
        "가브리엘": "https://media.api-sports.io/football/players/310870.png",
        "유리 조나탄": "https://media.api-sports.io/football/players/109209.png",
        "이동경": "https://media.api-sports.io/football/players/34431.png",
        "Ji Dong-Won": "https://media.api-sports.io/football/players/2911.png",
        "송민규": "https://media.api-sports.io/football/players/34598.png",
        "J. Lingard": "https://media.api-sports.io/football/players/900.png",
        "완델손": "https://media.api-sports.io/football/players/34569.png",
        "Jorge Luiz": "https://media.api-sports.io/football/players/277197.png",
        "Hwang Mun-Ki": "https://media.api-sports.io/football/players/41647.png",
        "D. Bojanić": "https://media.api-sports.io/football/players/48124.png",
        "Kang Sang-Woo": "https://media.api-sports.io/football/players/34547.png",
        "Han Seung-Gyu": "https://media.api-sports.io/football/players/34386.png",
        "Choi Woo-Jin": "https://media.api-sports.io/football/players/403340.png",
        "Lee Chung-Yong": "https://media.api-sports.io/football/players/2905.png",
        "L. Mina": "https://media.api-sports.io/football/players/59875.png",
        "Valdívia": "https://media.api-sports.io/football/players/10567.png",
        "Gleyson": "https://media.api-sports.io/football/players/159829.png",
        "조영욱": "https://media.api-sports.io/football/players/34517.png",
        "An Jae-Jun": "https://media.api-sports.io/football/players/262604.png",
        "Bruno Mota": "https://media.api-sports.io/football/players/9621.png",
        "Bruno Lamas": "https://media.api-sports.io/football/players/41215.png",
        "Yun Ju-Tae": "https://media.api-sports.io/football/players/34527.png",
        "플라나": "https://media.api-sports.io/football/players/47757.png",
        "Kim Chan": "https://media.api-sports.io/football/players/34580.png",
        "Paulo": "https://media.api-sports.io/football/players/9690.png",
        "P. Makrillos": "https://media.api-sports.io/football/players/26689.png",
        "Ha Nam": "https://media.api-sports.io/football/players/228834.png",
        "Ronan": "https://media.api-sports.io/football/players/41195.png",
        "Lee Jong-Ho": "https://media.api-sports.io/football/players/33779.png",
        "Fessin": "https://media.api-sports.io/football/players/80537.png",
        "Guilherme Castro": "https://media.api-sports.io/football/players/9392.png",
        "Kim Jin-Gyu": "https://media.api-sports.io/football/players/34168.png",
        "Hyun-Kyu Lee": "https://media.api-sports.io/football/players/644387.png",
        "Joon-Ho Lee": "https://media.api-sports.io/football/players/641043.png",
        "Ho-Yeung Sung": "https://media.api-sports.io/football/players/644392.png",
        "Won Ki-Jong": "https://media.api-sports.io/football/players/99249.png",
        "Seong-Woo Park": "https://media.api-sports.io/football/players/644913.png",
        "Hye-seong Kim": "https://media.api-sports.io/football/players/644908.png",
        "Juninho Rocha": "https://media.api-sports.io/football/players/36440.png",
        "L. Ruiz": "https://media.api-sports.io/football/players/63449.png",
        "Kim Jong-Min": "https://media.api-sports.io/football/players/91881.png",
        "Bruno Silva": "https://media.api-sports.io/football/players/10216.png",
        "바사니": "https://media.api-sports.io/football/players/143639.png",
        "Byeon Gyung-Jun": "https://media.api-sports.io/football/players/304966.png",
        "뮬리치": "https://media.api-sports.io/football/players/79138.png",
        "B. Arabuli": "https://media.api-sports.io/football/players/28485.png",
        "Kang Min-Geu": "https://media.api-sports.io/football/players/356373.png",
        "Matheus Oliveira": "https://media.api-sports.io/football/players/9718.png",
        "Jucie Lupeta": "https://media.api-sports.io/football/players/99152.png",
        "Osmar": "https://media.api-sports.io/football/players/34509.png",
        "로페즈": "https://media.api-sports.io/football/players/34405.png",
        "E. Placca": "https://media.api-sports.io/football/players/8917.png",
        "Lim Min-Hyeok": "https://media.api-sports.io/football/players/34138.png",
        "Park Min-Seo": "https://media.api-sports.io/football/players/34474.png",
        "Lee Dong-Su": "https://media.api-sports.io/football/players/34779.png",
        "Yoon Jae-Seok": "https://media.api-sports.io/football/players/457280.png",
        "P. Mlapa": "https://media.api-sports.io/football/players/37789.png",
        "Cho Ji-Hun": "https://media.api-sports.io/football/players/34653.png",
        "Park Tae-Yong": "https://media.api-sports.io/football/players/405118.png",
        "Jeong Jae-Min": "https://media.api-sports.io/football/players/409202.png",
        "Lee Jun-Ho": "https://media.api-sports.io/football/players/356215.png",
        "이상헌": "https://media.api-sports.io/football/players/292850.png",
        "황문기": "https://media.api-sports.io/football/players/142145.png",
        "김지현": "https://media.api-sports.io/football/players/114674.png"
    ]
    return photos[playerName]
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
        let resolvedURL = resolvedPlayerPhotoURL(for: playerName) ?? photoURL
        if let urlStr = resolvedURL, !urlStr.isEmpty {
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
