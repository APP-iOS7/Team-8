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
                            .font(.system(size: 17))
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(.all)
                    .foregroundStyle(Color("TextColor"))
                    .frame(height: 55)
                    .background(Color("ButtonBackgroundColor"))
                    .cornerRadius(15)
                }
                NavigationLink(destination: ContentView()) {
                    HStack {
                        Text("북마크")
                            .font(.system(size: 17))
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(.all)
                    .foregroundStyle(Color("TextColor"))
                    .frame(height: 55)
                    .background(Color("ButtonBackgroundColor"))
                    .cornerRadius(15)
                }
            }
            .padding(.horizontal, 42)
        }
    }
}

#Preview {
    ModelSelectView()
}
