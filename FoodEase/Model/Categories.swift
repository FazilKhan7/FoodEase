//
//  Categories.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 04.07.2023.
//

import Foundation

struct Categories: Codable {
    let сategories: [Сategory]
}

// MARK: - Сategory
struct Сategory: Codable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}
