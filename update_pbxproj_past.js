const fs = require('fs');
let pbxPath = 'KScout.xcodeproj/project.pbxproj';
let content = fs.readFileSync(pbxPath, 'utf8');

const years = [2022, 2023, 2024];
let i = 3;

years.forEach(year => {
    if (!content.includes(`DummyData${year}.swift`)) {
        let newId1 = `DE${year}${year}${year}${year}${year}${year}${year}${year}`;
        let newId2 = `DF${year}${year}${year}${year}${year}${year}${year}${year}`;
        
        content = content.replace(/(CE7055932FBC2EDC00147E7E \/\* DummyData2025\.swift in Sources \*\/ = \{isa = PBXBuildFile; fileRef = CE7055922FBC2EDC00147E7E \/\* DummyData2025\.swift \*\/; \};)/g, `$1\n\t\t${newId1} /* DummyData${year}.swift in Sources */ = {isa = PBXBuildFile; fileRef = ${newId2} /* DummyData${year}.swift */; };`);
        
        content = content.replace(/(CE7055922FBC2EDC00147E7E \/\* DummyData2025\.swift \*\/ = \{isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode\.swift; path = DummyData2025\.swift; sourceTree = "<group>"; \};)/g, `$1\n\t\t${newId2} /* DummyData${year}.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = DummyData${year}.swift; sourceTree = "<group>"; };`);
        
        content = content.replace(/(CE7055922FBC2EDC00147E7E \/\* DummyData2025\.swift \*\/,)/g, `$1\n\t\t\t\t${newId2} /* DummyData${year}.swift */,`);
        
        content = content.replace(/(CE7055932FBC2EDC00147E7E \/\* DummyData2025\.swift in Sources \*\/,)/g, `$1\n\t\t\t\t${newId1} /* DummyData${year}.swift in Sources */,`);
        
        console.log(`Added DummyData${year}.swift`);
    }
});

fs.writeFileSync(pbxPath, content);
console.log('project.pbxproj updated');
