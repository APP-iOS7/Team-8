//
//  ResultView.swift
//  wordE
//
//  Created by 존진 on 2/4/25.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        Spacer()
        HStack {
            Image(systemName: "checkmark")
                .font(.system(size: 20))
            Text("정답 수: ")
        }
        Spacer()
    }
}

#Preview {
    ResultView()
}
