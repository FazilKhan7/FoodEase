//
//  DishesPresenter.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 29.09.2023.
//

import Foundation
import UIKit

protocol DishesPresenterDelegate: AnyObject {
    func presentDishes(tegs: [Tegs])
}

typealias PresenterDishesDelegate = DishesPresenterDelegate & UICollectionView

class DishesPresenter {
    
    weak var delegate: PresenterDishesDelegate?
    
    public func getDishes(teg: String) {
        
        NetworkManager.shared.fetchDishes(urlString: "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b") { [weak self] dishes, error in
            guard let self = self else { return }

            if let dishes = dishes {
                let retrievedTeg = dishes.dishes.filter { dish in
                    switch teg {
                    case "Все меню": return dish.tegs.contains(.всеМеню)
                    case "Cалаты": return dish.tegs.contains(.салаты)
                    case "С рисом": return dish.tegs.contains(.сРисом)
                    default: return dish.tegs.contains(.сРыбой)
                    }
                }

                let dishesBySelectedTeg = retrievedTeg.map { dish in
                    return Tegs(
                        id: dish.id,
                        name: dish.name,
                        price: dish.price,
                        weight: dish.weight,
                        description: dish.description,
                        image_url: dish.imageURL,
                        tegs: dish.tegs
                    )
                }

                self.delegate?.presentDishes(tegs: dishesBySelectedTeg)
            }
        }

    }
    
    public func setViewDelegate(delegate: PresenterDishesDelegate) {
        self.delegate = delegate
    }
}
