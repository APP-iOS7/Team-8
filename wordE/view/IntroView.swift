//
//  Intro.swift
//  wordE
//
//  Created by Yung Hak Lee on 2/4/25.
//

import SwiftUI

struct IntroView: View {
    @State private var isActive: Bool = false
    @State private var isViewActive = true
    
    let tapGesture: some Gesture = TapGesture()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        HStack(spacing: -20) {
                            Image("Fx2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("Lx2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("Ax2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("Sx2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("Hx2").modifier(BounceImage(isViewActive: isViewActive))
                        }
                        HStack(spacing: -20) {
                            Image("Cx2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("AAx2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("Rx2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("Dx2").modifier(BounceImage(isViewActive: isViewActive))
                        }
                        HStack(spacing: -20) {
                            Image("wx2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("ox2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("rrx2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("ddx2").modifier(BounceImage(isViewActive: isViewActive))
                            Image("Ex2").modifier(BounceImage(isViewActive: isViewActive))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                }
            }
            .defaultScrollAnchor(.center)
            .scrollDisabled(true)
            .contentShape(Rectangle())
            .onTapGesture {
                isActive = true
            }
            .navigationDestination(isPresented: $isActive) {
                ModelSelectView()
            }
            Text("화면을 눌러보세요!")
                .font(.system(size: 15))
                .padding(.bottom, 60)
        }
        .onAppear() {
            isViewActive = true
        }
        .onDisappear() {
            isViewActive = false
        }
    }
}

struct BounceImage: ViewModifier {
    @State private var animation: Bool = false
    let isViewActive: Bool
    
    func body(content: Content) -> some View {
        content
            .offset(x: 0, y: animation ? 0 : CGFloat.random(in: -3 ... 7))
            .animation(
                .smooth(duration: 15, extraBounce: 10)
                .speed(30)
                .delay(Double.random(in: 0 ... 1))
                .repeatForever(autoreverses: true),
                value: animation && isViewActive)
            .onAppear {
                animation = true
            }
    }
}



#Preview {
    IntroView()
}
