//
//  BascetPresenter.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 29.09.2023.
//

import Foundation
import UIKit
import CoreData

class BascetPresenter {
    
    static var shared = BascetPresenter()
    
    private init() {}
        
    func sumPricesOfFetchResultController(fetchResultController: NSFetchedResultsController<NSFetchRequestResult>) -> Int {
        guard let sections = fetchResultController.sections else {
            return 0
        }
        
        var totalSum: Int = 0
        
        for section in sections {
            for item in section.objects as! [DishEntity] {
                totalSum += (Int(item.price) * Int(item.quantity))
            }
        }
        
        return totalSum
    }
}
