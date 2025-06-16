//
//  PlaceDetailView.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//

import SwiftUI
import MapKit

struct PlaceDetailView: View {
    var place: Place
    
    @State private var currentScale: CGFloat = 1.0
    @GestureState var zoomFactor: CGFloat = 1.0
    var magnification: some Gesture {
        return MagnificationGesture()
            .updating($zoomFactor) { value, scale, transaction in
                withAnimation {
                    scale = value
                }
            }
            .onChanged { value in
                withAnimation {
                    currentScale += value
                }
            }
            .onEnded { value in
                currentScale = value
            }
    }
    var body: some View {
        VStack {
            let coord = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            let position = MapCameraPosition.region(MKCoordinateRegion(
                center: coord,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
            Map(initialPosition: position) {
                Marker("", coordinate: coord)
            }
            if let data = place.loadImageFromDocuments() {
                Image(uiImage: data)
                    .resizable()
                    .frame(height: 300)
                    .scaleEffect(zoomFactor * currentScale)
                    .gesture(magnification)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(height: 300)
            }
            VStack {
                HStack {
                    Text("Category: \(place.category ?? "UNKNOWN")")
                    Spacer()
                }
                HStack {
                    Text("Name: \(place.name ?? "UNKNOWN")")
                    Spacer()
                }
                HStack {
                    Text("Description: \(place.desc ?? "UNKNOWN")")
                    Spacer()
                }
                HStack {
                    Text("Author: \(place.author?.username ?? "UNKNOWN")")
                    Spacer()
                }
            }.padding()
        }
    }
}

#Preview {
    PlaceDetailView(place: Place())
}
