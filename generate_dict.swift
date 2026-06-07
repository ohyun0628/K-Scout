import Foundation

// Paste the KoreanTranslationService contents here temporarily to run it
struct KoreanTranslationService {
    private static let surnames: [String: String] = [
        "kim": "김", "lee": "이", "park": "박", "choi": "최", "jeong": "정", "jung": "정", "kang": "강", "cho": "조", "jo": "조", "yoon": "윤", "yun": "윤", "jang": "장", "lim": "임", "im": "임", "han": "한", "oh": "오", "seo": "서", "shin": "신", "kwon": "권", "hwang": "황", "ahn": "안", "an": "안", "song": "송", "jeon": "전", "hong": "홍", "ko": "고", "go": "고", "goh": "고", "moon": "문", "mun": "문", "yang": "양", "son": "손", "bae": "배", "baek": "백", "paek": "백", "heo": "허", "huh": "허", "nam": "남", "sim": "심", "shim": "심", "no": "노", "noh": "노", "kwak": "곽", "woo": "우", "gu": "구", "koo": "구", "ku": "구", "ha": "하", "doo": "두", "do": "두", "du": "두", "ryu": "류", "seol": "설", "ma": "마", "bang": "방", "won": "원", "um": "엄", "eom": "엄", "yeon": "연", "you": "유", "yoo": "유", "yu": "유", "chun": "천", "cheon": "천", "joung": "정", "jeung": "정", "myung": "명", "myeong": "명", "byun": "변", "byeon": "변", "mok": "목", "ki": "기", "gi": "기", "na": "나", "ra": "라", "la": "라", "min": "민", "bing": "빙", "suk": "석", "seok": "석", "cha": "차", "chu": "추", "choo": "추", "wang": "왕", "yeo": "여", "pa": "파", "pan": "판", "gong": "공", "kong": "공", "kam": "감", "gam": "감", "hwak": "확", "guk": "국", "kook": "국", "kug": "국", "ok": "옥", "pum": "품", "eo": "어", "bak": "박", "jin": "진", "sin": "신", "lyu": "류", "gang": "강", "gweon": "권", "gwon": "권", "gim": "김", "ro": "노", "lo": "노", "dong": "동", "paik": "백", "sul": "설", "seong": "성", "sung": "성", "uh": "어", "yeong": "영", "young": "영", "o": "오", "u": "우", "eun": "은", "yi": "이", "i": "이", "rhee": "이", "rim": "임", "jun": "전", "ju": "주", "joo": "주", "ji": "지", "chae": "채", "tak": "탁", "pyo": "표"
    ]
    
    private static let syllables: [String: String] = [
        "min": "민", "kyu": "규", "gyu": "규", "joon": "준", "jun": "준", "ho": "호", "hyung": "형", "hyeong": "형", "geun": "근", "keun": "근", "gun": "건", "geon": "건", "ju": "주", "joo": "주", "yong": "용", "young": "영", "yeong": "영", "seung": "승", "woo": "우", "won": "원", "sang": "상", "jin": "진", "su": "수", "soo": "수", "jae": "재", "hyun": "현", "hyeon": "현", "tae": "태", "dong": "동", "kyung": "경", "gyeong": "경", "suk": "석", "seok": "석", "ji": "지", "hoon": "훈", "hun": "훈", "sung": "성", "seong": "성", "dae": "대", "il": "일", "lok": "록", "rok": "록", "chul": "철", "cheol": "철", "cheul": "철", "garam": "가람", "bum": "범", "beom": "범", "chang": "창", "ki": "기", "gi": "기", "jong": "종", "nam": "남", "myung": "명", "myeong": "명", "chung": "청", "cheong": "청", "yeon": "연", "eun": "은", "ha": "하", "in": "인", "do": "도", "hyuk": "혁", "hyeok": "혁", "gwang": "광", "kwang": "광", "chan": "찬", "bin": "빈", "hwan": "환", "ryong": "룡", "wook": "욱", "yoon": "윤", "yun": "윤", "kwan": "관", "gwan": "관", "mo": "모", "pyo": "표", "sol": "솔", "seo": "서", "seon": "선", "sun": "선", "bo": "보", "je": "제", "hwi": "휘", "san": "산", "yeop": "엽", "yup": "엽", "hak": "학", "ryeol": "렬", "ryul": "률", "yul": "율", "ryeong": "령", "ryung": "령", "ung": "웅", "woong": "웅", "hyo": "효", "ki": "기", "gi": "기", "rim": "림", "lim": "림", "ryu": "류", "eui": "의", "ui": "의", "gu": "구", "koo": "구", "ku": "구", "no": "노", "noh": "노", "ok": "옥", "dong": "동", "baek": "백", "paek": "백", "seol": "설", "jeon": "전", "jun": "전", "guk": "국", "kook": "국", "kug": "국", "o": "오", "u": "우", "yi": "이", "i": "이", "rhee": "이", "chae": "채", "tak": "탁", "ah": "아", "a": "아", "na": "나", "ra": "라", "la": "라", "ma": "마", "ba": "바", "pa": "파", "sa": "사", "ja": "자", "cha": "차", "ka": "카", "ga": "가", "ta": "타", "da": "다", "pa": "파", "ha": "하"
    ]
    
    // 외구인 선수
    private static let foreignPlayers: [String: String] = [
        "Cesinha": "세징야", "Mugosa": "무고사", "Iljutcenko": "일류첸코", "Jatobá": "자토바", "Geovani": "지오바니", "M. Dackers": "대커스", "Edgar": "에드가", "Matheus Serafim": "마테우스", "A. Krivotsyuk": "크리보추크", "Victor Bobsin": "빅터 밥신", "Diogo de Oliveira": "디오고", "M. Ishida": "이시다", "João Victor": "주앙 빅터", "G. Ludwigson": "루빅손", "Derlan": "데를란", "Matheus Frizzo": "마테우스 프리조", "M. Andersen": "안데르센", "Matheus Babi": "마테우스 바비", "Willyan": "윌리안", "J. Célestine": "셀레스틴", "Tobias Figueiredo": "토비아스", "Italo Moreira": "이탈로", "Emerson Negueba": "에메르손", "G. Paulauskas": "파울라우스카스", "João Gamboa": "감보아", "Oberdan": "오베르단", "Bruno Mota": "브루노 모타", "Tiago Orobó": "티아고", "P. Twumasi": "트우마시", "Juan Fernández": "후안", "Iker Undabarrena": "이케르", "M. Ferrier": "페리어", "S. Mugoša": "무고사", "K. Nishiya": "니시야", "Juninho Rocha": "주니뇨", "Jorge Luiz": "조르지", "J. Tranziska": "트란지스카", "Wanderson": "완델손", "Yazan Al Arab": "야잔", "Juan Antonio": "후안 안토니오", "H. Babec": "바베치", "Anderson Oliveira": "안데르손", "G. Samuel": "사무엘", "P. Klimala": "클리말라", "L. Ruiz": "루이즈", "M. Trojak": "트로야크", "D. Bojanić": "보야니치", "Marcão": "마르캉", "B. Michel": "미첼", "Pedrinho": "페드리뉴", "Yago Cariello": "야고", "M. Tuci": "투치"
    ]
    
    static func translatePlayer(_ name: String) -> String {
        if let foreign = foreignPlayers[name] { return foreign }
        let components = name.split(separator: " ").map { String($0) }
        guard components.count >= 2 else { return name }
        let isKoreanFormat = surnames.keys.contains(components.first!.lowercased()) && components.last!.contains("-")
        
        var surname = ""
        var givenName = ""
        
        if isKoreanFormat {
            surname = components.first!
            givenName = components.dropFirst().joined(separator: " ")
        } else {
            surname = components.last!
            givenName = components.dropLast().joined(separator: " ")
        }
        
        let translatedSurname = surnames[surname.lowercased()] ?? surname
        let givenNameParts = givenName.split(separator: "-").map { String($0) }
        var translatedGivenName = ""
        
        for part in givenNameParts {
            let cleanPart = part.trimmingCharacters(in: .whitespaces)
            if let translated = syllables[cleanPart.lowercased()] {
                translatedGivenName += translated
            } else {
                translatedGivenName += cleanPart
            }
        }
        
        let result = translatedSurname + translatedGivenName
        if result.count > 0 && result != name {
            return result
        }
        return name
    }
}

let jsonPath = "KScout/Resources/KLeaguePlayers.json"
let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
let players = try JSONDecoder().decode([String].self, from: data)

var dict = [String: String]()
for englishName in players {
    let koreanName = KoreanTranslationService.translatePlayer(englishName)
    if koreanName != englishName {
        dict[koreanName] = englishName
    } else {
        // Just add identity for foreign players who couldn't be parsed if any
        dict[englishName] = englishName
    }
}

// Generate Swift dictionary syntax
var swiftCode = "let generatedPlayerDictionary: [String: String] = [\n"
for (k, v) in dict {
    swiftCode += "    \"\(k)\": \"\(v)\",\n"
}
swiftCode += "]\n"

try swiftCode.write(to: URL(fileURLWithPath: "GeneratedDictionary.swift"), atomically: true, encoding: .utf8)
print("Generated Dictionary with \(dict.count) entries.")
