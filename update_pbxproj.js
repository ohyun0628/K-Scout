const fs = require('fs');
let pbxPath = 'KScout.xcodeproj/project.pbxproj';
let content = fs.readFileSync(pbxPath, 'utf8');

if (!content.includes('DummyData2026.swift')) {
    let newId1 = 'DE1111111111111111111111';
    let newId2 = 'DE2222222222222222222222';
    
    // Add PBXBuildFile
    content = content.replace(/(CE7055932FBC2EDC00147E7E \/\* DummyData2025\.swift in Sources \*\/ = \{isa = PBXBuildFile; fileRef = CE7055922FBC2EDC00147E7E \/\* DummyData2025\.swift \*\/; \};)/g, `$1\n\t\t${newId1} /* DummyData2026.swift in Sources */ = {isa = PBXBuildFile; fileRef = ${newId2} /* DummyData2026.swift */; };`);
    
    // Add PBXFileReference
    content = content.replace(/(CE7055922FBC2EDC00147E7E \/\* DummyData2025\.swift \*\/ = \{isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode\.swift; path = DummyData2025\.swift; sourceTree = "<group>"; \};)/g, `$1\n\t\t${newId2} /* DummyData2026.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = DummyData2026.swift; sourceTree = "<group>"; };`);
    
    // Add to main group
    content = content.replace(/(CE7055922FBC2EDC00147E7E \/\* DummyData2025\.swift \*\/,)/g, `$1\n\t\t\t\t${newId2} /* DummyData2026.swift */,`);
    
    // Add to PBXSourcesBuildPhase
    content = content.replace(/(CE7055932FBC2EDC00147E7E \/\* DummyData2025\.swift in Sources \*\/,)/g, `$1\n\t\t\t\t${newId1} /* DummyData2026.swift in Sources */,`);
    
    fs.writeFileSync(pbxPath, content);
    console.log('Added DummyData2026.swift to project.pbxproj');
} else {
    console.log('Already in pbxproj');
}
