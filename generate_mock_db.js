const fs = require('fs');

const englishNames = JSON.parse(fs.readFileSync('KScout/Resources/KLeaguePlayers.json', 'utf8'));

const teams = [
  "울산 HD FC", "전북 현대 모터스", "포항 스틸러스", "수원 FC", "수원 삼성 블루윙즈", "FC 서울",
  "대전 하나 시티즌", "강원 FC", "광주 FC", "대구 FC", "인천 유나이티드", "제주 유나이티드", "김천 상무 FC"
];

const players = englishNames.map((engName, index) => {
  // We don't have the Korean translation in JS, so we will generate Swift code
  // that uses KoreanTranslationService at runtime, or we just put the English name
  // and let the Swift code initialize it.
});
