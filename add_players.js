const fs = require('fs');
const path = 'c:/Users/apf_temp_admin/OneDrive/바탕 화면/K-Scout/KScout/Services/KoreanTranslationService.swift';
let content = fs.readFileSync(path, 'utf8');

const newPlayers = [
    '"kim ki-hee": "김기희"', '"ki-hee kim": "김기희"',
    '"cho su-hyuk": "조수혁"', '"su-hyuk cho": "조수혁"', '"jo su-hyuk": "조수혁"',
    '"b. arabidze": "아라비제"', '"arabidze": "아라비제"', '"arabidza": "아라비제"',
    '"cho sung-min": "조성민"', '"sung-min cho": "조성민"',
    '"mo jae-hyun": "모재현"', '"jae-hyun mo": "모재현"',
    '"kim seung-sub": "김승섭"', '"seung-sub kim": "김승섭"', '"kim seung-seob": "김승섭"',
    '"shigehiro": "시게히로"', '"t. shigehiro": "시게히로"',
    '"hwang soon-min": "황순민"', '"soon-min hwang": "황순민"',
    '"yoon jae-woon": "윤재운"', '"jae-woon yoon": "윤재운"',
    '"kwon neung": "권능"', '"neung kwon": "권능"',
    '"k. yoshio": "요시오"', '"yoshio": "요시오"',
    '"jefferson galego": "갈레고"', '"galego": "갈레고"', '"j. galego": "갈레고"',
    '"tales": "탈레스"', '"t. tales": "탈레스"',
    '"jegal jae-min": "제갈재민"', '"jae-min jegal": "제갈재민"',
    '"lee soon-min": "이순민"', '"soon-min lee": "이순민"',
    '"lee gun-hee": "이건희"', '"gun-hee lee": "이건희"',
    '"lee tae-hee": "이태희"', '"tae-hee lee": "이태희"',
    '"i. hadžić": "하지치"', '"hadzic": "하지치"', '"hadžić": "하지치"',
    '"h. hore": "헨리"', '"hore": "헨리"',
    '"park kyong-bae": "박경배"', '"kyong-bae park": "박경배"',
    '"lim sang-hyub": "임상협"', '"sang-hyub lim": "임상협"',
    '"rebin solaka": "술라카"', '"solaka": "술라카"', '"r. solaka": "술라카"',
    '"hosam aiesh": "아이에쉬"', '"aiesh": "아이에쉬"', '"h. aiesh": "아이에쉬"',
    '"a. calver": "아론"', '"calver": "아론"',
    '"b. mikeltadze": "베카"', '"mikeltadze": "베카"',
    '"andré luís": "안드레 루이스"', '"andre luis": "안드레 루이스"', '"a. luís": "안드레 루이스"'
];

// Append missing syllables as well for the decoder
const newSyllables = [
    '"kyong": "경"', '"hyub": "협"', '"neung": "능"', '"soon": "순"', '"gun": "건"', '"sub": "섭"', '"seob": "섭"'
];

// Deduplicate existing playerDictionary
function cleanDict(dictStr) {
    const regex = /"([^"]+)":\s*"([^"]+)"/g;
    let match;
    const seen = new Set();
    const cleaned = [];
    while ((match = regex.exec(dictStr)) !== null) {
        if (!seen.has(match[1])) {
            cleaned.push(`"${match[1]}": "${match[2]}"`);
            seen.add(match[1]);
        }
    }
    return cleaned.join(',\n        ');
}

content = content.replace(/(playerDictionary: \[String: String\] = )\[([\s\S]*?)\](\s*\n)/, (match, prefix, dictContent, suffix) => {
    let combined = dictContent + ',\n' + newPlayers.join(',\n');
    return `${prefix}[\n        ${cleanDict(combined)}\n    ]${suffix}`;
});

content = content.replace(/(syllables: \[String: String\] = )\[([\s\S]*?)\](\s*\n)/, (match, prefix, dictContent, suffix) => {
    let combined = dictContent + ', ' + newSyllables.join(', ');
    return `${prefix}[\n        ${cleanDict(combined)}\n    ]${suffix}`;
});

fs.writeFileSync(path, content, 'utf8');
console.log("Success!");
