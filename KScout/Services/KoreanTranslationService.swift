import Foundation

struct KoreanTranslationService {
    
    // 로마자 성씨 매핑
    private static let surnames: [String: String] = [
        "kim": "김", "lee": "이", "park": "박", "choi": "최", "jeong": "정", "jung": "정", "kang": "강", "cho": "조", "jo": "조", "yoon": "윤", "yun": "윤", "jang": "장", "lim": "임", "im": "임", "han": "한", "oh": "오", "seo": "서", "shin": "신", "kwon": "권", "hwang": "황", "ahn": "안", "an": "안", "song": "송", "jeon": "전", "hong": "홍", "ko": "고", "go": "고", "goh": "고", "moon": "문", "mun": "문", "yang": "양", "son": "손", "bae": "배", "baek": "백", "heo": "허", "huh": "허", "nam": "남", "sim": "심", "shim": "심", "no": "노", "noh": "노", "kwak": "곽", "woo": "우", "gu": "구", "koo": "구", "ha": "하", "doo": "두", "do": "두", "ryu": "류", "seol": "설", "ma": "마", "bang": "방", "won": "원", "um": "엄", "eom": "엄", "yeon": "연", "you": "유", "yoo": "유", "yu": "유", "chun": "천", "cheon": "천", "paik": "백", "joung": "정", "jeung": "정", "myung": "명", "myeong": "명"
    ]
    
    // 로마자 이름(음절) 매핑
    private static let syllables: [String: String] = [
        "min": "민", "kyu": "규", "gyu": "규", "joon": "준", "jun": "준", "ho": "호", "hyung": "형", "hyeong": "형", "geun": "근", "gun": "건", "geon": "건", "ju": "주", "joo": "주", "yong": "용", "young": "영", "yeong": "영", "seung": "승", "woo": "우", "won": "원", "sang": "상", "jin": "진", "su": "수", "soo": "수", "jae": "재", "hyun": "현", "hyeon": "현", "tae": "태", "dong": "동", "kyung": "경", "gyeong": "경", "suk": "석", "seok": "석", "ji": "지", "hoon": "훈", "hun": "훈", "sung": "성", "seong": "성", "dae": "대", "il": "일", "lok": "록", "rok": "록", "chul": "철", "cheul": "철", "garam": "가람", "bum": "범", "beom": "범", "chang": "창", "ki": "기", "gi": "기", "jong": "종", "nam": "남", "myung": "명", "myeong": "명", "chung": "청", "cheong": "청", "yeon": "연", "eun": "은", "ha": "하", "in": "인", "do": "도", "hyuk": "혁", "hyeok": "혁", "gwang": "광", "kwang": "광", "chan": "찬", "bin": "빈", "hwan": "환", "ryong": "룡", "wook": "욱", "yoon": "윤", "yun": "윤", "kwan": "관", "gwan": "관", "mo": "모", "pyo": "표", "sol": "솔", "seo": "서", "seon": "선", "sun": "선", "bo": "보", "je": "제", "hwi": "휘", "san": "산", "yeop": "엽", "yup": "엽", "hak": "학", "ryeol": "렬", "ryul": "률", "ryun": "륜", "ryeo": "려", "joong": "중", "jung": "중", "jeong": "정", "hee": "희", "hi": "희", "bi": "비", "kug": "국", "gook": "국", "guk": "국", "wan": "완", "uk": "욱", "ok": "옥", "chong": "총", "che": "체", "baek": "백", "paek": "백", "bong": "봉", "kwon": "권", "gwon": "권", "kang": "강", "gang": "강", "dan": "단", "dal": "달", "dam": "담", "rim": "림", "lim": "림", "chin": "진", "chun": "춘", "choon": "춘", "sam": "삼", "shik": "식", "sik": "식", "shin": "신", "sin": "신", "ah": "아", "a": "아", "oh": "오", "o": "오", "on": "온", "song": "송", "ye": "예", "jo": "조", "cho": "조", "chu": "추", "choo": "추", "chi": "치", "po": "포", "heung": "흥", "hyo": "효", "hye": "혜", "duk": "덕", "deok": "덕", "pil": "필", "ui": "의"
    ]

    
    // 팀명 한글 번역 딕셔너리
    private static let teamDictionary: [String: String] = [
        "ulsan hyundai": "울산 HD",
        "ulsan hyundai fc": "울산 HD",
        "ulsan hd fc": "울산 HD",
        "ulsan hd": "울산 HD",
        "ulsan": "울산 HD",
        
        "jeonbuk motors": "전북 현대",
        "jeonbuk hyundai motors": "전북 현대",
        "jeonbuk hyundai": "전북 현대",
        "jeonbuk": "전북 현대",
        
        "pohang steelers": "포항 스틸러스",
        "pohang": "포항 스틸러스",
        
        "suwon city": "수원 FC",
        "suwon city fc": "수원 FC",
        "suwon fc": "수원 FC",
        
        "seoul": "FC 서울",
        "fc seoul": "FC 서울",
        "seoul fc": "FC 서울",
        
        "jeju united": "제주 유나이티드",
        "jeju united fc": "제주 유나이티드",
        "jeju": "제주 유나이티드",
        
        "daegu fc": "대구 FC",
        "daegu": "대구 FC",
        
        "incheon united": "인천 유나이티드",
        "incheon united fc": "인천 유나이티드",
        "incheon": "인천 유나이티드",
        
        "gimcheon sangmu": "김천 상무",
        "gimcheon sangmu fc": "김천 상무",
        "kimcheon sangmu": "김천 상무",
        "gimcheon": "김천 상무",
        
        "seongnam fc": "성남 FC",
        "seongnam": "성남 FC",
        
        "gangwon fc": "강원 FC",
        "gangwon": "강원 FC",
        
        "daejeon citizen": "대전 하나 시티즌",
        "daejeon hana citizen": "대전 하나 시티즌",
        "daejeon hana": "대전 하나 시티즌",
        "daejeon": "대전 하나 시티즌",
        
        "gwangju fc": "광주 FC",
        "gwangju": "광주 FC",
        
        "gyeongnam fc": "경남 FC",
        "gyeongnam": "경남 FC",
        
        "ansan greeners": "안산 그리너스",
        "ansan greeners fc": "안산 그리너스",
        "ansan": "안산 그리너스",
        
        "bucheon fc 1995": "부천 FC 1995",
        "bucheon fc": "부천 FC 1995",
        "bucheon": "부천 FC 1995",
        
        "seoul e-land": "서울 이랜드",
        "seoul e-land fc": "서울 이랜드",
        "seoul e": "서울 이랜드",
        
        "busan i park": "부산 아이파크",
        "busan ipark": "부산 아이파크",
        "busan": "부산 아이파크",
        
        "jeonnam dragons": "전남 드래곤즈",
        "chonnam dragons": "전남 드래곤즈",
        "jeonnam": "전남 드래곤즈",
        
        "chungnam asan fc": "충남아산 FC",
        "chungnam asan": "충남아산 FC",
        "asan": "충남아산 FC",
        
        "gimpo fc": "김포 FC",
        "gimpo": "김포 FC",
        
        "cheonan city fc": "천안 시티 FC",
        "cheonan city": "천안 시티 FC",
        "cheonan": "천안 시티 FC",
        
        "chungbuk cheongju fc": "충북청주 FC",
        "chungbuk cheongju": "충북청주 FC",
        "cheongju": "충북청주 FC",
        
        "anyang fc": "FC 안양",
        "fc anyang": "FC 안양",
        "anyang": "FC 안양",
        
        "suwon samsung bluewings": "수원 삼성",
        "suwon samsung": "수원 삼성",
        "suwon bluewings": "수원 삼성"
    ]
    
    // 선수명 한글 번역 딕셔너리
    private static let playerDictionary: [String: String] = [
        "mugosa": "무고사",
        "s. mugoša": "무고사",
        "stefan mugoša": "무고사",
        "mugoša": "무고사",
        
        "cesinha": "세징야",
        "césar fernando silva dos santos": "세징야",
        
        "joo min-kyu": "주민규",
        "min-kyu ju": "주민규",
        "j. min-kyu": "주민규",
        "ju min-kyu": "주민규",
        "min-kyu jo": "주민규",
        
        "gerso": "제르소",
        "gerso fernandes": "제르소",
        "g. fernandes": "제르소",
        
        "zeca": "제카",
        "josé joaquim de carvalho": "제카",
        
        "valdivia": "발디비아",
        "wanderson ferreira de oliveira": "발디비아",
        "w. de oliveira": "발디비아",
        
        "cho gue-sung": "조규성",
        "gue-sung cho": "조규성",
        "g. cho": "조규성",
        
        "an byong-jun": "안병준",
        "byong-jun an": "안병준",
        "b. an": "안병준",
        
        "lee seung-woo": "이승우",
        "seung-woo lee": "이승우",
        "s. lee": "이승우",
        
        "um won-sang": "엄원상",
        "won-sang eom": "엄원상",
        "w. eom": "엄원상",
        
        "barrow": "바로우",
        "modou barrow": "바로우",
        "m. barrow": "바로우",
        
        "lars veldwijk": "라스",
        "l. veldwijk": "라스",
        
        "popovic": "포포비치",
        "aleksandar popović": "포포비치",
        
        "yun il-lok": "윤일록",
        "il-lok yun": "윤일록",
        
        "kim dae-won": "김대원",
        "dae-won kim": "김대원",
        "d. kim": "김대원",
        
        "yang hyun-jun": "양현준",
        "hyun-jun yang": "양현준",
        "h. yang": "양현준",
        
        "lee dong-gyeong": "이동경",
        "dong-gyeong lee": "이동경",
        "d. lee": "이동경",
        
        "cho young-wook": "조영욱",
        "young-wook cho": "조영욱",
        "y. cho": "조영욱",
        
        "stanislav iljutcenko": "일류첸코",
        "s. iljutcenko": "일류첸코",
        "iljutcenko": "일류첸코",
        
        "gustavo": "구스타보",
        
        "na sang-ho": "나상호",
        "sang-ho na": "나상호",
        "s. na": "나상호",
        
        "kamil aspropotamitis": "아스프로",
        "k. aspropotamitis": "아스프로",
        
        "bako": "바코",
        "valeri qazaishvili": "바코",
        "v. qazaishvili": "바코",
        
        "leonardo": "레오나르도",
        
        "kim jin-su": "김진수",
        "jin-su kim": "김진수",
        
        "shin jin-ho": "신진호",
        "jin-ho shin": "신진호",
        
        "lee yeong-jae": "이영재",
        "yeong-jae lee": "이영재",
        
        "mulic": "뮬리치",
        "f. mulić": "뮬리치",
        "fejsal mulić": "뮬리치",
        
        "rubio": "루비오",
        "jonathan rubio": "루비오",
        
        "hernades": "에르난데스",
        "hernandes rodrigues": "에르난데스",
        "h. rodrigues": "에르난데스",
        "hernandes": "에르난데스",
        
        "wanderson": "완델손",
        "wanderson de sousa carneiro": "완델손",
        
        "edgar": "에드가",
        "edgar silva": "에드가",
        
        "goo bon-cheul": "구본철",
        "bon-cheul goo": "구본철",
        
        "kim seung-dae": "김승대",
        "seung-dae kim": "김승대",
        
        "yoon bit-garam": "윤빛가람",
        "bit-garam yoon": "윤빛가람",
        
        "lopes": "로페즈",
        "ricardo lopes": "로페즈",
        
        "yago cariello": "야고",
        "yago": "야고",
        
        "anderson oliveira": "안데르손",
        "anderson": "안데르손",
        
        "gabriel": "가브리엘",
        "kovacevic": "코바체비치",
        
        "tiago orobo": "티아고",
        "tiago orobó": "티아고",
        "tiago": "티아고",
        
        "yuri jonathan": "유리 조나탄",
        "yuri": "유리 조나탄",
        "s. jurj": "유리 조나탄",
        
        "lee han-beom": "이한범",
        "han-beom lee": "이한범",
        
        "pllana": "플라나",
        "m. pllana": "플라나",
        
        "luis nani": "나니",
        "paulinho": "파울리뇨",
        
        "ronaldo": "호날두",
        "ronaldo tavares": "호날두",
        
        "bassani": "바사니",
        
        "um ji-sung": "엄지성",
        "ji-sung um": "엄지성",
        
        "song min-kyu": "송민규",
        "min-kyu song": "송민규",
        
        "oberdan": "오베르단",
        
        "kornelius hansen": "코르넬리우스",
        
        // K-Scout 추가 영문 선수명 번역 테이블 (2024 시즌 및 API-Football 대응)
        "g. ludwigson": "루빅손",
        "gustav ludwigson": "루빅손",
        "ludwigson": "루빅손",
        
        "jorge luiz": "조르지",
        "jorge": "조르지",
        
        "hwang mun-ki": "황문기",
        "mun-ki hwang": "황문기",
        
        "d. bojanić": "보야니치",
        "bojanić": "보야니치",
        "darijan bojanić": "보야니치",
        "bojanic": "보야니치",
        "d. bojanic": "보야니치",
        
        "han seung-gyu": "한승규",
        "seung-gyu han": "한승규",
        
        "lee ho-jae": "이호재",
        "ho-jae lee": "이호재",
        
        "j. lingard": "린가드",
        "jesse lingard": "린가드",
        "lingard": "린가드",
        
        "yang min-hyuk": "양민혁",
        "yang min-hyeok": "양민혁",
        "min-hyuk yang": "양민혁",
        "min-hyeok yang": "양민혁",
        
        "lee myung-jae": "이명재",
        "myung-jae lee": "이명재",
        
        "lee jin-hyun": "이진현",
        "jin-hyun lee": "이진현",
        
        "doo hyeon-seok": "두현석",
        "hyeon-seok doo": "두현석",
        
        "jeong seung-won": "정승원",
        "seung-won jeong": "정승원",
        
        "jeong jae-hee": "정재희",
        "jae-hee jeong": "정재희",
        
        "lee chung-yong": "이청용",
        "chung-yong lee": "이청용",
        
        "bruno mota": "브루노",
        "bruno lamas": "라마스",
        
        "yun ju-tae": "윤주태",
        "ju-tae yun": "윤주태",
        
        "ha nam": "하남",
        "nam ha": "하남",
        
        "won ki-jong": "원기종",
        "ki-jong won": "원기종",
        
        "seong-woo park": "박성우",
        "hye-seong kim": "김혜성",
        
        "juninho rocha": "주닝요",
        "juninho": "주닝요",
        
        "kim jong-min": "김종민",
        "jong-min kim": "김종민",
        
        "bruno silva": "브루노 실바",
        
        "byeon gyung-jun": "변경준",
        "gyung-jun byeon": "변경준",
        
        "b. arabuli": "아라불리",
        "bachana arabuli": "아라불리",
        
        "matheus oliveira": "마테우스",
        
        "jucie lupeta": "루페타",
        "lupeta": "루페타",
        
        "osmar": "오스마르",
        
        "lim min-hyeok": "임민혁",
        "min-hyeok lim": "임민혁",
        
        "park min-seo": "박민서",
        "min-seo park": "박민서",
        
        "lee dong-su": "이동수",
        "dong-su lee": "이동수",
        
        "yoon jae-seok": "윤재석",
        "jae-seok yoon": "윤재석",
        
        "p. mlapa": "음라파",
        "peniel mlapa": "음라파",
        
        "cho ji-hun": "조지훈",
        "ji-hun cho": "조지훈",
        
        "park tae-yong": "박태용",
        "tae-yong park": "박태용",
        
        "jeong jae-min": "정재민",
        "jae-min jeong": "정재민",
        
        "lee jun-ho": "이준호",
        "jun-ho lee": "이준호",
        
        "moon seon-min": "문선민",
        "seon-min moon": "문선민",
        
        "kim in-gyun": "김인균",
        "in-gyun kim": "김인균",
        
        "goh young-jun": "고영준",
        "young-jun goh": "고영준",
        
        "cheon seong-hoon": "천성훈",
        "seong-hoon cheon": "천성훈",
        
        "eom ji-sung": "엄지성",
        "ji-sung eom": "엄지성",
        
        "willyan": "윌리안",
        
        "go jae-hyeon": "고재현",
        "jae-hyeon go": "고재현",
        
        "a. paločević": "팔로세비치",
        "palocivic": "팔로세비치",
        "palocevic": "팔로세비치",
        
        "leandro ribeiro": "레안드로",
        "leandro": "레안드로",
        
        "kim do-hyeok": "김도혁",
        "do-hyeok kim": "김도혁",
        
        "seol young-woo": "설영우",
        "young-woo seol": "설영우",
        
        "kang sang-woo": "강상우",
        "sang-woo kang": "강상우",
        
        "choi woo-jin": "최우진",
        "woo-jin choi": "최우진",
        "c. woo-jin": "최우진",
        
        "valdívia": "발디비아",
        "fessin": "페신",
        
        "an jae-jun": "안재준",
        "jae-jun an": "안재준",
        "gleyson": "글레이손",
        "guilherme castro": "카스트로",
        "ho-yeung sung": "성호영",
        "sung ho-yeung": "성호영",
        "hyun-kyu lee": "이현규",
        "lee hyun-kyu": "이현규",
        "joon-ho lee": "이준호",
        "lee joon-ho": "이준호",
        "kim chan": "김찬",
        "chan kim": "김찬",
        "kim jin-gyu": "김진규",
        "jin-gyu kim": "김진규",
        "l. mina": "미나",
        "luis mina": "미나",
        "lee jong-ho": "이종호",
        "jong-ho lee": "이종호",
        "m. ishida": "마사",
        "ishida": "마사",
        "p. makrillos": "마크릴로스",
        "makrillos": "마크릴로스",
        "paulo": "파울로",
        "reis": "헤이스",
        "ronan": "호난",
        
        "andrigo": "안드리고",
        "choi geon-joo": "최건주",
        "geon-joo choi": "최건주",
        "f. cadenazzi": "카데나시",
        "cadenazzi": "카데나시",
        "heo yong-jun": "허용준",
        "yong-jun heo": "허용준",
        "in-hyeok park": "박인혁",
        "park in-hyeok": "박인혁",
        "j. amano": "아마노 준",
        "amano jun": "아마노 준",
        "amano": "아마노 준",
        "j. moya": "모야",
        "moya": "모야",
        "jonathan balotelli": "발로텔리",
        "balotelli": "발로텔리",
        "kang hyun-muk": "강현묵",
        "hyun-muk kang": "강현묵",
        "kim bo-sub": "김보섭",
        "bo-sub kim": "김보섭",
        "kim ju-kong": "김주공",
        "ju-kong kim": "김주공",
        "lee ki-je": "이기제",
        "ki-je lee": "이기제",
        "lee myung-joo": "이명주",
        "myung-joo lee": "이명주",
        "lee sang-heon": "이상헌",
        "sang-heon lee": "이상헌",
        "m. acosty": "아코스티",
        "acosty": "아코스티",
        "m. ádám": "마틴 아담",
        "ádám": "마틴 아담",
        "nilson": "닐손주니어",
        "nilson junior": "닐손주니어",
        "oh hyeon-gyu": "오현규",
        "hyeon-gyu oh": "오현규",
        "sandro lima": "산드로",
        "sandro": "산드로",
        "son suk-yong": "손석용",
        "suk-yong son": "손석용",
        "yu kang-hyun": "유강현",
        "kang-hyun yu": "유강현",
        "yun min-ho": "윤민호",
        "min-ho yun": "윤민호"
    ]
    
    // 팀명 번역 함수
    static func translateTeam(_ name: String) -> String {
        let key = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        // Exact matching
        if let translated = teamDictionary[key] {
            return translated
        }
        
        // Partial matching
        for (engKey, korVal) in teamDictionary {
            if engKey.count > 3 && key.contains(engKey) {
                return korVal
            }
        }
        
        return name
    }
    
    // 선수명 번역 함수
    static func translatePlayer(_ name: String) -> String {
        let key = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        // Exact matching
        if let translated = playerDictionary[key] {
            return translated
        }
        
        // Partial matching
        for (engKey, korVal) in playerDictionary {
            if engKey.count > 3 && key.contains(engKey) {
                return korVal
            }
        }
        
        // 3. 한글 이름 Romanized 정규화 패턴 동적 매칭 시도 (예: "Joon-Ho Hong" -> "홍준호")
        if let decodedName = decodeRomanizedKorean(key) {
            return decodedName
        }
        
        return name
    }
    
    // 자동 영문 -> 한글 변환기 (Heuristic Decoder)
    private static func decodeRomanizedKorean(_ cleanName: String) -> String? {
        // "Choi Young-Jun" -> ["choi", "young", "jun"]
        var components = cleanName.components(separatedBy: CharacterSet(charactersIn: " -"))
        components = components.filter { !$0.isEmpty }
        
        guard components.count == 3 else { return nil }
        
        // 3어절일 때 (Last First First) -> 예: Kim Hyung Geun
        if let last = surnames[components[0]], 
           let first1 = syllables[components[1]], 
           let first2 = syllables[components[2]] {
            return "\(last)\(first1)\(first2)"
        }
        
        // 3어절일 때 (First First Last) -> 예: Joon Ho Hong
        if let last = surnames[components[2]], 
           let first1 = syllables[components[0]], 
           let first2 = syllables[components[1]] {
            return "\(last)\(first1)\(first2)"
        }
        
        return nil
    }
}
