//
//  CardAnimationView.swift
//  wordE
//
//  Created by Yung Hak Lee on 2/5/25.
//

import SwiftUI

//카드 외형 요한님 코드로 바꿔줘야 함
struct CardFront : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double

    
    var body: some View {
        ZStack {
            ZStack {
                VStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: width, height: height)
                        .shadow(color: .gray, radius: 2, x: 0, y: 0)
                    
                    Text("Apple")
                        .font(.headline)
                }
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

//카드 외형 요한님 코드로 바꿔줘야 함
struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            Text("사과")
                .font(.title)

        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))

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
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
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
