//
//  DishesModel.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 22.08.2023.
//

import Foundation

struct DishesModel {
    let id: Int
    let name: String
    let price, weight: Int
    let description: String
    let imageURL: String
    let tegs: [Teg]
    
    init(dish: Dish) {
        id = dish.id
        name = dish.name
        price = dish.price
        weight = dish.weight
        description = dish.description
        imageURL = dish.imageURL
        tegs = dish.tegs
    }
}
