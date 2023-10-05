//
//  Dishes.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 22.08.2023.
//

import Foundation

// MARK: - Welcome
struct Dishes: Codable {
    let dishes: [Dish]
}

// MARK: - Dish
struct Dish: Codable {
    let id: Int
    let name: String
    let price, weight: Int
    let description: String
    let imageURL: String
    let tegs: [Teg]

    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}

enum Teg: String, Codable {
    case всеМеню = "Все меню"
    case сРисом = "С рисом"
    case сРыбой = "С рыбой"
    case салаты = "Салаты"
}
