//
//  wordEApp.swift
//  wordE
//
//  Created by 고요한 on 2/4/25.
//

import SwiftUI
import SwiftData

@main
struct wordEApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            wordDictionary.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
