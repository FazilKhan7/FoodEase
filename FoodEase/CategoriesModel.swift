//
//  CategoriesModel.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 04.07.2023.
//

import Foundation
import UIKit

struct CategoriesModel {
    var categories: [CategoryModel]
    
    init?(categories: Categories) {
        guard !categories.сategories.isEmpty else {
            return nil
        }
        
        self.categories = categories.сategories.map { CategoryModel(category: $0) }
    }
}


