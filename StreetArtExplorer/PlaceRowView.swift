//
//  PlaceRowView.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//

import SwiftUI

struct PlaceRowView: View {
    let place: Place
    var body: some View {
        HStack {
            Text(place.name ?? "UNKNOWN")
        }
    }
}

#Preview {
    PlaceRowView(place: Place())
}
