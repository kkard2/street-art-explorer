//
//  Place+CoreDataProperties.swift
//  StreetArtExplorer
//
//  Created by student on 03/06/2025.
//
//

import Foundation
import CoreData
import PhotosUI

extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var imageFilename: String?
    @NSManaged public var desc: String?
    @NSManaged public var category: String?
    @NSManaged public var author: User?
    @NSManaged public var favorites: NSSet?

}

// MARK: Generated accessors for favorites
extension Place {

    @objc(addFavoritesObject:)
    @NSManaged public func addToFavorites(_ value: Favorite)

    @objc(removeFavoritesObject:)
    @NSManaged public func removeFromFavorites(_ value: Favorite)

    @objc(addFavorites:)
    @NSManaged public func addToFavorites(_ values: NSSet)

    @objc(removeFavorites:)
    @NSManaged public func removeFromFavorites(_ values: NSSet)

}

extension Place : Identifiable {
    func loadImageFromDocuments() -> UIImage? {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        if let filename = self.imageFilename {
            let fileURL = documentsURL.appendingPathComponent(filename)
            guard let data = try? Data(contentsOf: fileURL) else {
                return nil
            }
            
            return UIImage(data: data)
        } else {
            return nil
        }
    }
}
