//
//  flashCardView.swift
//  wordE
//
//  Created by 고요한 on 2/4/25.
//

import SwiftUI

struct flashCardView: View {
    private var primarySemiColor: Color = Color(hex: "F3F9FC")
    private var imageBorderColor: Color = Color(hex: "B7A1A1")
    private var wordTextColor: Color = Color(.black)
    
    @State private var image: String = ""
    @State private var word: String = ""
    @State private var meaning: String = ""
    @State private var isFlapped: Bool = false
    
    var body: some View {
        Button(action: {isFlapped.toggle()}) {
            ZStack{
                Color(primarySemiColor)
                    GeometryReader { geometry in
                        VStack(alignment: .center) {
                            if !isFlapped {
                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 270, height: 209)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 13)
                                            .stroke(imageBorderColor, lineWidth: 1)
                                    )
                                    .padding([.top, .leading, .trailing], (geometry.size.width - 270)/2)
                            }
                            Spacer()
                            Text("\(word)")
                                .font(.system(size: 35, weight: .bold))
                                .foregroundStyle(wordTextColor)
                                .frame(maxWidth: .infinity,alignment: .center)
                            Spacer()
                        }
                    }
            }
        }
        .background(primarySemiColor)
        .frame(minHeight:400, maxHeight: 400)
        .cornerRadius(15)
//        .padding([.leading, .trailing], 42)
    }
}

#Preview {
    flashCardView()
}
