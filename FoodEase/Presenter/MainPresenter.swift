//
//  MainPresenter.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 29.09.2023.
//

import Foundation
import UIKit

protocol MainPresenterDelegate: AnyObject {
    func presentCategories(categories: [CategoryModel])
}

typealias PresenterDelegate = MainPresenterDelegate & UIViewController

class MainPresenter {
    
    weak var delegate: PresenterDelegate?
    
    public func getCategories() {
        NetworkManager.shared.fetchAlbum(urlString: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54") { [weak self] categories, error in
            guard let self = self, let categories = categories else { return }
            
            let newCategories = categories.сategories.map { CategoryModel(name: $0.name, imageURL: $0.imageURL) }
            self.delegate?.presentCategories(categories: newCategories)
        }
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
}
