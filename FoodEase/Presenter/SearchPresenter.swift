//
//  SearchPresenter.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 29.09.2023.
//

import Foundation
import UIKit

protocol SearchPresenterDelegate: AnyObject {
    func presentSearchedDishes(searchedDishes: [Dish])
}

typealias PresenterSearchDelegate = SearchPresenterDelegate & UIViewController

class SearchPresenter {
    
    weak var delegate: PresenterSearchDelegate?
    
    public func fetchSearchedDishes(searchText: String) {
        NetworkManager.shared.fetchDishes(urlString: "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b") { dishes, error in
            if let dishes = dishes {
                let searchedDishes = dishes.dishes.filter { $0.name.lowercased().contains(searchText) }
                self.delegate?.presentSearchedDishes(searchedDishes: searchedDishes)
            } else if let error = error {
                print("Error fetching dishes: \(error)")
            }
        }
    }
    
    public func setViewDelegate(delegate: PresenterSearchDelegate) {
        self.delegate = delegate
    }
}
