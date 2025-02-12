//Version: 0_1_1
//Date: 2025-02-05(Wed)
//Content: Draft UI

import SwiftUI

struct FlashCardView: View {
    //Color
    private var primarySemiColor: Color = Color(hex: "F3F9FC")
    private var imageBorderColor: Color = Color(hex: "B7A1A1")
    private var wordTextColor: Color = Color(.black)
    
    //SwiftData
    private var wordInfo: wordDictionary
    private var dummyItems: wordDictionary = wordDictionary(id: UUID(), word: "Apple", meaning: "사과", imgPath: "appleImage", isCorrect: false, isBookmarked: false)
    
    private var image: String
    private var word: String
    private var meaning: String
    @State private var isFlapped: Bool
    
    init(wordInfo: wordDictionary) {
        self.wordInfo = wordInfo
        self.image = wordInfo.imgPath
        self.word = wordInfo.word
        self.meaning = wordInfo.meaning
        self._isFlapped = State(initialValue: false)
    }
    
    var body: some View {
        Button(action: {
            isFlapped.toggle()
        }) {
            ZStack{
                Color(primarySemiColor)
                GeometryReader { geometry in
                    VStack(alignment: .center) {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 270, height: 210) //1:0.78
                            .padding([.top, .leading, .trailing], (geometry.size.width - 270)/2)
                        Spacer()
                        Text("\(word)")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundStyle(wordTextColor)
                            .frame(maxWidth: .infinity,alignment: .center)
                        Spacer()
                    }
                    .opacity(isFlapped ? 0 : 1)
                }
                Text(meaning)
                    .opacity(isFlapped ? 1 : 0)
                    .foregroundStyle(wordTextColor)
                    .font(.system(size: 35, weight: .bold))
            }
        }
        .background(primarySemiColor)
        .frame(minHeight:400, maxHeight: 400)
        .cornerRadius(15)
        .padding(42)
    }
}

//#Preview {
//    FlashCardView()
//}
