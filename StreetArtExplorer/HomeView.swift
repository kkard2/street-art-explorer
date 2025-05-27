//
//  HomeView.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.name, ascending: true)],
        animation: .default)
    
    private var places: FetchedResults<Place>
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(places) { place in
                    NavigationLink(destination: PlaceDetailView(place: place)) {
                        PlaceRowView(place: place)
                    }
                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: AddPlaceView(user: user)) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: AddPlaceView(user: user)) {
                        Image(systemName: "person.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(user: User())
}
