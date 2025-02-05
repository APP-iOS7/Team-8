//Version: 0_1_1
//Date: 2025-02-05(Wed)
//Content: API url and dummyJsonWordData

import SwiftUI
import Foundation

//"https://random-word-api.herokuapp.com/home"
//"https://dictionaryapi.dev/"

struct dummyData : Codable {
    var word : String
    var meaning : String
    var imgPath : String
    var isBookmarked : Bool
    var isCorrect : Bool
}

func loadJsonData(filename: String) -> [dummyData] {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError("파일을 찾을 수 없음: \(filename)")
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decodedData = try JSONDecoder().decode([dummyData].self, from: data)
        
        return decodedData
    } catch {
        print("JSON 디코딩 오류:", error) 
        return []
    }
}


struct testdummyDataView: View {
    let dummyJsonWordData: [dummyData] = loadJsonData(filename: "dummyWordData")
    
    var body: some View {
        Button("Click Me") {
            print(dummyJsonWordData)
        }
    }
    
}


#Preview {
    testdummyDataView()
}
