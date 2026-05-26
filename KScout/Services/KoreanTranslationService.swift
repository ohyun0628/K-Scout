import Foundation

struct KoreanTranslationService {
    
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
        "young-woo seol": "설영우"
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
        
        // 한글 이름 Romanized 정규화 패턴 매칭 시도 (예: "Gue-sung Cho" -> "조규성" 자동 매핑 룰)
        // 기본 딕셔너리에 대부분 매핑되므로 미번역 시 원본 리턴
        return name
    }
}
