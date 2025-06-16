//
//  PlaceRowView.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//

import SwiftUI

struct PlaceRowView: View {
    let place: Place
    let isAuthor: Bool
    
    var body: some View {
        HStack {
            if let data = place.loadImageFromDocuments() {
                Image(uiImage: data)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .scaledToFit()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .scaledToFit()
            }
            Text(place.name ?? "UNKNOWN")
                .foregroundColor(isAuthor ? .accentColor : .primary)
        }
    }
}

#Preview {
    PlaceRowView(place: Place(), isAuthor: true)
}
