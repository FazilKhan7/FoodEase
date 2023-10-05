//
//  MainTabBarController.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 22.08.2023.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        setup()
    }
    
    private func setup() {
        
        let homeVC = MainViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house.fill"), selectedImage: nil)
    
        let search = UINavigationController(rootViewController: SearchViewController())
        search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let basket = BasketViewController()
        basket.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "basket"), tag: 2)
        
        let account = AccountViewController()
        account.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.crop.circle"), tag: 3)

        viewControllers = [homeVC, search, basket, account]
        loadAllControllers()
    }
    
    private func loadAllControllers() {
        if let viewControllers = self.viewControllers {
            for viewController in viewControllers {
                if let navVC = viewController as? UINavigationController {
                    let _ = navVC.viewControllers.first?.view
                }
            }
        }
    }
}
