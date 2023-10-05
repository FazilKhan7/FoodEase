//
//  AccountViewController.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 24.09.2023.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
    
    private lazy var customNavigationBar = CustomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(customNavigationBar)
    }
    
    private func setConstraints() {
        customNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview()
        }
    }
}
