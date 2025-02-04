//
//  Intro.swift
//  wordE
//
//  Created by Yung Hak Lee on 2/4/25.
//

import SwiftUI

struct IntroView: View {
    @State private var isShaking = false
        
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                HStack(spacing: -20) {
                    Image("Fx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("Lx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("Ax1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("Sx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("Hx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                }
                HStack(spacing: -20) {
                    Image("Cx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("AAx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("Rx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("Dx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                }
                HStack(spacing: -20) {
                    Image("wx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("ox1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("rrx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("ddx1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                    Image("Ex1")
                        .resizable()
                        .scaledToFit()
                        .modifier(WiggleModifier())
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            
            Spacer()
            
            Text("화면을 눌러보세요!")
                .fontWeight(.medium)
                .frame(width: .infinity, height: .infinity, alignment: .bottom)
                .padding(.bottom, 50)
        }
    }
}

struct WiggleModifier: ViewModifier {
    @State private var isWiggling = false
    
    private var randomDuration: Double {
        Double.random(in: 0.1...0.3)
    }
    
    private var rotateAnimation: Animation {
        Animation
            .easeInOut(duration: randomDuration)
            .repeatForever(autoreverses: true)
    }
    
    private var bounceAnimation: Animation {
        Animation
            .easeInOut(duration: randomDuration)
            .repeatForever(autoreverses: true)
    }
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(isWiggling ? 2.0 : 0))
            .animation(rotateAnimation, value: isWiggling)
            .offset(x: 0, y: isWiggling ? 2.0 : 0)
            .animation(bounceAnimation, value: isWiggling)
            .onAppear { isWiggling = true }
    }
}

#Preview {
    IntroView()
}
