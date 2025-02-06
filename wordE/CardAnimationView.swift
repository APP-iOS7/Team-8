//
//  CardAnimationView.swift
//  wordE
//
//  Created by Yung Hak Lee on 2/5/25.
//

import SwiftUI

//카드 외형 요한님 코드로 바꿔줘야 함
struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    private var primarySemiColor: Color = Color(hex: "F3F9FC")
    private var imageBorderColor: Color = Color(hex: "B7A1A1")
    private var wordTextColor: Color = Color(.black)
    private var wordInfo: dummyData
    private var image: String
    private var word: String
    
    init(width: CGFloat, height: CGFloat, degree: Binding<Double>, wordInfo: dummyData = loadJsonData(filename: "dummyWordData")[0]) {
        self.width = width
        self.height = height
        self._degree = degree
        self.wordInfo = wordInfo
        self.image = wordInfo.imgPath
        self.word = wordInfo.word
    }
    
    
    var body: some View {
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
            }
        }
        .background(primarySemiColor)
        .frame(minHeight:400, maxHeight: 400)
        .cornerRadius(15)
        .padding(42)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

//카드 외형 요한님 코드로 바꿔줘야 함
struct CardFront : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    private var primarySemiColor: Color = Color(hex: "F3F9FC")
    private var wordTextColor: Color = Color(.black)
    private var wordInfo: dummyData
    private var meaning: String
    
    init(width: CGFloat, height: CGFloat, degree: Binding<Double>, wordInfo: dummyData = loadJsonData(filename: "dummyWordData")[0]) {
        self.width = width
        self.height = height
        self._degree = degree
        self.wordInfo = wordInfo
        self.meaning = wordInfo.meaning
    }

    var body: some View {
        ZStack{
            Color(primarySemiColor)
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    Spacer()
                    Text("\(meaning)")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundStyle(wordTextColor)
                        .frame(maxWidth: .infinity,alignment: .center)
                    Spacer()
                }
            }
        }
        .background(primarySemiColor)
        .frame(minHeight:400, maxHeight: 400)
        .cornerRadius(15)
        .padding(42)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardAnimationView: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false

    let width : CGFloat = 200
    let height : CGFloat = 250
    let durationAndDelay : CGFloat = 0.3

    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: 0.3)) {
                backDegree = isFlipped ? -90 : 0
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = isFlipped ? 0 : -90
            }
        } else {
            withAnimation(.linear(duration: 0.3)) {
                frontDegree = isFlipped ? 0 : 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = isFlipped ? 90 : 0
            }
        }
    }
    
    var body: some View {
        ZStack {
            CardFront(width: width, height: height, degree: $frontDegree)
            CardBack(width: width, height: height, degree: $backDegree)
        }.onTapGesture {
            flipCard ()
        }
    }
}

#Preview {
    CardAnimationView()
}
