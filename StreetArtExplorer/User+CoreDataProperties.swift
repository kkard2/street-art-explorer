//
//  User+CoreDataProperties.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var username: String?
    @NSManaged public var addedPlaces: NSSet?
    @NSManaged public var favorites: NSSet?

}

// MARK: Generated accessors for addedPlaces
extension User {

    @objc(addAddedPlacesObject:)
    @NSManaged public func addToAddedPlaces(_ value: Place)

    @objc(removeAddedPlacesObject:)
    @NSManaged public func removeFromAddedPlaces(_ value: Place)

    @objc(addAddedPlaces:)
    @NSManaged public func addToAddedPlaces(_ values: NSSet)

    @objc(removeAddedPlaces:)
    @NSManaged public func removeFromAddedPlaces(_ values: NSSet)

}

// MARK: Generated accessors for favorites
extension User {

    @objc(addFavoritesObject:)
    @NSManaged public func addToFavorites(_ value: Favorite)

    @objc(removeFavoritesObject:)
    @NSManaged public func removeFromFavorites(_ value: Favorite)

    @objc(addFavorites:)
    @NSManaged public func addToFavorites(_ values: NSSet)

    @objc(removeFavorites:)
    @NSManaged public func removeFromFavorites(_ values: NSSet)

}

extension User : Identifiable {

}
