//
//  ModelSelectView.swift
//  wordE
//
//  Created by Yung Hak Lee on 2/4/25.
//

import SwiftUI

struct ModelSelectView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                NavigationLink(destination: ContentView()) {
                    HStack {
                        Text("뒤집으러 가기")
                            .font(.headline)
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(.all)
                    .foregroundStyle(.black.opacity(0.4))
                    .frame(height: 55)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                }
                NavigationLink(destination: ContentView()) {
                    HStack {
                        Text("북마크")
                            .font(.headline)
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(.all)
                    .foregroundStyle(.black.opacity(0.4))
                    .frame(height: 55)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal, 42)
        }
    }
}

#Preview {
    ModelSelectView()
}
