//Version: 0_1_1
//Date: 2025-02-05(Tue)
//Content: Word Quiz view

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

struct wordQuizView: View {
    private var primaryColor: Color = Color(hex:" #5AA0C8")
    private var backButtonColor: Color = Color(.black)
    private var subTextColor: Color = Color(hex: "#8A8787")
    private var textFieldBorderColor: Color = Color(hex: "#C7DBE7")
    
    private var backButtonSymbol: String = "chevron.left"
    private var textFieldButtonSymbol: String = "arrow.right.circle"
    
    @State private var progressPercent: Float = 0.0
    @State private var textFieldText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .trailing) {
                    ProgressView(value: progressPercent,total: 1)
                        .progressViewStyle(customProgressStyle())
                    Text("\(progressPercent * 100, specifier: "%.0f")%")
                        .foregroundStyle(subTextColor)
                        .font(.system(size: 10))
                }
                .padding(0)
                
                Spacer()
                
                //flashCardView Area
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("단어를 맞춰보세요!")
                        .frame(width: .infinity, height: 26, alignment: .leading)
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
                            print("dd")
                        }
                        .foregroundStyle(primaryColor)
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 10)
                    }

                }
            }
            .padding([.leading, .trailing], 42)
            .padding(.bottom, 50)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content:{
                    Button("", systemImage: backButtonSymbol){
                        print("clicked")
                    }
                    .tint(backButtonColor)
                })
            }
        }
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
    wordQuizView()
}
