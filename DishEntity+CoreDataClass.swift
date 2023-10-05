//
//  DishEntity+CoreDataClass.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 20.09.2023.
//
//

import Foundation
import CoreData

@objc(DishEntity)
public class DishEntity: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "DishEntity"), insertInto: CoreDataManager.shared.context)
    }
}
