//
//  ContentView.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        UserSelectionView()
    }

    private func addItem() {
    }

    private func deleteItems(offsets: IndexSet) {}
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
