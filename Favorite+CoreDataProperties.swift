//
//  Favorite+CoreDataProperties.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var user: User?
    @NSManaged public var place: Place?

}

extension Favorite : Identifiable {

}
