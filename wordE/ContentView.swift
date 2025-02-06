//
//  ContentView.swift
//  wordE
//
//  Created by 고요한 on 2/4/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [wordDictionary]
    @State private var isIntroViewActive = false

    var body: some View {
        IntroView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: wordDictionary.self, inMemory: true)
}
