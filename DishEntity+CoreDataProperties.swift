//
//  DishEntity+CoreDataProperties.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 20.09.2023.
//
//

import Foundation
import CoreData


extension DishEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DishEntity> {
        return NSFetchRequest<DishEntity>(entityName: "DishEntity")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Int16
    @NSManaged public var quantity: Int16

}

extension DishEntity : Identifiable {
    
}
