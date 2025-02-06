//Version: 0_2_1
//Date: 2025-02-05(Wed)
//Content: Draft UI

import SwiftUI
import SwiftData
import Foundation

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
                
        let scanner = Scanner(string: hexSanitized)
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        
        let red = Double((hexValue & 0xFF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x0000FF) / 255.0
        
        self.init(red:red, green:green, blue:blue)
    }
}

struct WordQuizView: View {
    //SwiftData
    @Environment(\.modelContext) private var modelContext
    @Query private var wordItems: [wordDictionary]
    @State private var wordItemsToState: [wordDictionary] = []
    private var dummyItems: wordDictionary = wordDictionary(id: UUID(), word: "Apple", meaning: "사과", imgPath: "appleImage", isCorrect: false, isBookmarked: false)
    
    //Color
    private var primaryColor: Color = Color(hex:" #5AA0C8")
    private var backButtonColor: Color = Color(.black)
    private var subTextColor: Color = Color(hex: "#8A8787")
    private var textFieldBorderColor: Color = Color(hex: "#C7DBE7")
    
    //Symbol
    private var backButtonSymbol: String = "chevron.left"
    private var textFieldButtonSymbol: String = "arrow.right.circle"
    
    //State
    @State private var progressPercent: Float = 0.0
    @State private var dataIndex: Int = 0
    @State private var textFieldText: String = ""
    @State private var isFinised: Bool = false
    @FocusState private var isFocused: Bool
    
    
    var body: some View {
        NavigationStack {
            VStack {
                //progressView
                VStack(alignment: .trailing) {
                    ProgressView(value: progressPercent, total: 1)
                        .progressViewStyle(customProgressStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 42)
                    Text("\(progressPercent * 100, specifier: "%.0f")%")
                        .foregroundStyle(subTextColor)
                        .font(.system(size: 10))
                        .padding(.horizontal, 42)
                }
                .padding(.top)
                
                //FlashCardView
                if wordItemsToState != [] {
                    CardAnimationView(wordInfo: wordItemsToState[dataIndex])
                }
                else {
                    CardAnimationView(wordInfo: dummyItems)
                }
                Spacer()
                
                // TextField
                VStack(alignment: .leading) {
                    Text("단어를 맞춰보세요!")
                        .frame(width: 200, height: 26, alignment: .leading)
                        .padding(.leading, 50)
                        .foregroundStyle(subTextColor)
                        .font(.system(size: 15))
                    
                    ZStack() {
                        Section {
                            HStack {
                                Spacer()
                                TextField("", text: $textFieldText)
                                    .frame(width: 215, height: 49)
                                    .padding(.horizontal, 10)
                                    .focused($isFocused)

                                Button("", systemImage: textFieldButtonSymbol) {
                                    changeFlashCardView()
                                }
                                .frame(width: 40, height: 49, alignment: .trailing)
                                .foregroundStyle(primaryColor)
                                Spacer()
                            }
                            .frame(width: 300, height: 49)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(textFieldBorderColor, lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 42)
                }
                Spacer()
            }
            
            .navigationDestination(isPresented: $isFinised) {
                ResultView()
//                testView()
            }
            .onAppear {
                if wordItems.isEmpty {
                    let loadedData: [decodeData] = loadJsonData(filename: "dummyWordData").shuffled()
                    saveWordToSwiftData(decodeDatas: loadedData)
                }
                wordItemsToState = wordItems
                wordItemsToState.shuffle()
                progressPercent = 1 / Float(max(wordItems.count, 1))
            
            }
        }
        .contentShape(Rectangle())
        .gesture(
            TapGesture()
                .onEnded { _ in
                    isFocused = false
                }
        )
        .simultaneousGesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -40 {
                        changeFlashCardView()
                    }
                }
        )
    }
    
    
    func insertSwiftData(comparaWordInfo: wordDictionary) {
        let isContain = wordItems.contains { $0.word == comparaWordInfo.word }
        if !isContain {
            wordItemsToState.append(comparaWordInfo)
            modelContext.insert(comparaWordInfo)
            try? modelContext.save()
        }
    }
    
    func saveWordToSwiftData(decodeDatas: [decodeData]) {
        for decodeData in decodeDatas {
            let wordModelItem = wordDictionary(
                id: UUID(),
                word: decodeData.word,
                meaning: decodeData.meaning,
                imgPath: decodeData.imgPath,
                isCorrect: false,
                isBookmarked: false
            )
            insertSwiftData(comparaWordInfo: wordModelItem)
        }
    }
    
    func changeFlashCardView() {
        if dataIndex + 1 < wordItems.count {
            saveData()
            dataIndex += 1
            progressPercent += 1.0/Float(wordItems.count)
            progressPercent = min(progressPercent, 1.0)
            
        }
        else {
            isFinised = true
        }
    }
    
    func saveData() {
        if textFieldText == wordItemsToState[dataIndex].meaning {
            if let index = wordItemsToState.firstIndex(where: {$0.word == wordItems[dataIndex].word}) {
                wordItems[index].isCorrect = true
                try? modelContext.save()
            }
        }
        else {
            if let index = wordItemsToState.firstIndex(where: {$0.word == wordItems[dataIndex].word}) {
                wordItems[index].isCorrect = false
                try? modelContext.save()
            }
        }
        textFieldText = ""
    }
}

struct wordData : Codable, Identifiable {
    var id: UUID = UUID()
    var word : String
    var meaning : String
    var imgPath : String
    var isBookmarked : Bool
    var isCorrect : Bool
}


struct customProgressStyle: ProgressViewStyle {
    var progressColor: Color = Color(hex: "#FFFFFF")
    var progressFrameColor: Color = Color(hex: "#F3F9FC")
    var progressFrameBorderColor: Color = Color(hex: "#D9D9D9")
    
    var height: CGFloat = 11
    var radius: CGFloat = 20
    var lineWidth: CGFloat = 1
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        RoundedRectangle(cornerRadius: radius)
            .fill(progressFrameColor)
            .frame(height: height)
            .overlay(alignment: .leading) {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: radius)
                        .fill(progressColor)
                        .stroke(progressFrameBorderColor, lineWidth: lineWidth)
                        .frame(width:geometry.size.width * progress, height: height - lineWidth)
                }
            }
    }
}




#Preview {
    WordQuizView()
}
