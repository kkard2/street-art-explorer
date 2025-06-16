//
//  ProfileView.swift
//  StreetArtExplorer
//
//  Created by student on 10/06/2025.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let user: User
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.name, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>

    var body: some View {
        VStack {
            Text(user.username ?? "UNKNOWN")
            List {
                ForEach(places.filter { $0.author?.id == user.id}) { place in
                    let isAuthor = self.user.username == place.author?.username
                    NavigationLink(destination: PlaceDetailView(place: place)) {
                        PlaceRowView(place: place, isAuthor: isAuthor)
                    }
                    .deleteDisabled(!isAuthor)
                }.onDelete { indexSet in
                    for index in indexSet {
                        let item = places[index]
                        viewContext.delete(item)
                        do {
                            try viewContext.save()
                        } catch {
                            // TODO(kk): handle error
                        }
                    }
                }
            }
        }
    }
    
}

