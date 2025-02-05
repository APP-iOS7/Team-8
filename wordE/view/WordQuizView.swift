//Version: 0_2_1
//Date: 2025-02-05(Wed)
//Content: Draft UI

import SwiftUI

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
    @Environment(\.dismiss) var dismiss
    
    
    private var primaryColor: Color = Color(hex:" #5AA0C8")
    private var backButtonColor: Color = Color(.black)
    private var subTextColor: Color = Color(hex: "#8A8787")
    private var textFieldBorderColor: Color = Color(hex: "#C7DBE7")
    
    private var backButtonSymbol: String = "chevron.left"
    private var textFieldButtonSymbol: String = "arrow.right.circle"
    

    @State private var progressPercent: Float = 0.0
    @State private var dummyDataList: [dummyData]
    @State private var dummyDataItem: dummyData
    @State private var dummyDataItemIndex: Int = 0
    @State private var textFieldText: String = ""
    @State var resultList: [dummyData] = []
    @State private var isFinised: Bool = false
    
    init() {
        let loadedData: [dummyData] = loadJsonData(filename: "dummyWordData").shuffled()
        self.dummyDataList = loadedData
        self.dummyDataItem = loadedData[0]
        self._progressPercent = State(initialValue: 1 / Float(dummyDataList.count))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                //progressView
                VStack(alignment: .trailing) {
                    ProgressView(value: progressPercent, total: 1)
                        .progressViewStyle(customProgressStyle())
                    Text("\(progressPercent * 100, specifier: "%.0f")%")
                        .foregroundStyle(subTextColor)
                        .font(.system(size: 10))
                }
                .padding(0)
                
                Spacer()
                
                //FlashCardView
                FlashCardView(wordInfo: dummyDataItem)
                
                Spacer()
                
                // TextField
                VStack(alignment: .leading) {
                    Text("단어를 맞춰보세요!")
                        .frame(width: 200, height: 26, alignment: .leading)
                        .padding(.bottom, 10)
                        .foregroundStyle(subTextColor)
                        .font(.system(size: 15))
                    
                    ZStack(alignment: .trailing) {
                        TextField("", text: $textFieldText)
                            .frame(height:49)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(textFieldBorderColor, lineWidth: 1)
                            )
                        Button("", systemImage: textFieldButtonSymbol) {
                            chageFlashCardView()
                        }
                        .foregroundStyle(primaryColor)
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 10)
                    }
                    
                }
                Spacer()
            }
            .padding([.leading, .trailing], 42)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button("", systemImage: backButtonSymbol){
                        dismiss()
                    }
                    .tint(backButtonColor)
                })
            }
            .navigationDestination(isPresented: $isFinised) {
                testView() // 이 부분에 view넣으면 됨.
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -40 {
                        chageFlashCardView()
                    }
                }
        )
    }
    
    func chageFlashCardView() {
        if dummyDataItemIndex + 1 < dummyDataList.count {
            saveData()
            dummyDataItemIndex += 1
            dummyDataItem = dummyDataList[dummyDataItemIndex]
            
            progressPercent += 1.0/Float(dummyDataList.count)
            progressPercent = min(progressPercent, 1.0)
            
        }
        else {
            isFinised = true
        }
    }
    
    func saveData() {
        if textFieldText == dummyDataItem.meaning {
            dummyDataItem.isCorrect = true
        }
        resultList.append(dummyDataItem)
        textFieldText = ""
    }
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
