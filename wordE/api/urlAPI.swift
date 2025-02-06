//Version: 0_1_1
//Date: 2025-02-05(Wed)
//Content: API url and dummyJsonWordData

import SwiftUI
import Foundation
import SwiftData

//"https://random-word-api.herokuapp.com/home"
//"https://dictionaryapi.dev/"

struct decodeData : Codable {
    var word : String
    var meaning : String
    var imgPath : String
}

func loadJsonData(filename: String) -> [decodeData] {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError("파일을 찾을 수 없음: \(filename)")
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decodedData = try JSONDecoder().decode([decodeData].self, from: data)
        
        return decodedData
    } catch {
        print("JSON 디코딩 오류:", error)
        return []
    }
}

struct testdummyDataView: View {
    let dummyJsonWordData: [decodeData] = loadJsonData(filename: "dummyWordData")
    
    var body: some View {
        Button("Click Me") {
            print(dummyJsonWordData)
        }
    }
    
}


#Preview {
    testdummyDataView()
}
