//
//  AddPlaceView.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//

import SwiftUI
import PhotosUI
import MapKit

let categories = [
    "Mural",
    "Graffiti",
    "Sculpture",
]

struct AddPlaceView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var user: User
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var category: String = categories[0]
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
    
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            let position = MapCameraPosition.region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 51.250859500294794, longitude: 22.567931383830516),
                span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            ))
            MapReader { proxy in
                Map(initialPosition: position) {
                    if let selectedCoord = selectedCoordinate {
                        Marker("", coordinate: selectedCoord)
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        selectedCoordinate = coordinate
                    }
                }
            }
            Picker("Category", selection: $category) {
                ForEach(categories, id: \.self) { cat in
                    Text(cat)
                }
            }
            TextField("Name", text: $name)
            TextField("Description", text: $description)
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    if let data = selectedImageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else {
                        ContentUnavailableView("No image selected", systemImage: "photo.badge.plus")
                            .frame(height: 200)
                    }
                }
                .onChange(of: selectedItem) { oldItem, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
            
            Button("Submit") {
                if
                    let data = selectedImageData,
                    let uiImage = UIImage(data: data),
                    let filename = saveImageToDocuments(image: uiImage),
                    let coord = selectedCoordinate
                {
                    let place = Place(context: viewContext)
                    place.author = user
                    place.name = name
                    place.desc = description
                    place.category = category
                    place.imageFilename = filename
                    place.latitude = coord.latitude
                    place.longitude = coord.longitude
                    place.creationDate = Date()
                    do {
                        try viewContext.save()
                    } catch {
                        showingAlert = true
                    }
                } else {
                    showingAlert = true
                }
            }
            .disabled(name == "" || description == "" || selectedImageData == nil || selectedCoordinate == nil)
            .alert("Error when saving", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            }
        }.padding()
    }
    
    func saveImageToDocuments(image: UIImage) -> String? {
        // Create a unique filename
        let filename = UUID().uuidString + ".jpg"
        
        // Get documents directory URL
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not get documents directory")
            return nil
        }
        
        let fileURL = documentsURL.appendingPathComponent(filename)
        
        // Convert image to JPEG data with quality 0.8
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            print("Could not convert image to JPEG")
            return nil
        }
        
        do {
            try data.write(to: fileURL)
            return filename
        } catch {
            print("Error saving file:", error)
            return nil
        }
    }
}

#Preview {
    AddPlaceView(user: User())
}

