//
//  StreetArtExplorerApp.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//

import SwiftUI

@main
struct StreetArtExplorerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
