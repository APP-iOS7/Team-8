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

    private func addItem() {
        withAnimation {
            let newItem = wordDictionary(id: Int(), word: String(), meaning: String(), imgPath: String(), isCorrect: Bool(), isBookmarked: Bool())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: wordDictionary.self, inMemory: true)
}
