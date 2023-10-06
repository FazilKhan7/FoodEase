//
//  CategoriesViewController.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 04.07.2023.
//

import Foundation
import UIKit
import SnapKit
import CoreData

final class CategoriesViewController: UIViewController {
    
    private lazy var horizontalCollectionView = HorizontalCollectionView(frame: .zero)
    private lazy var verticalCollectioView = VerticalCollectionView(frame: .zero)
    private lazy var cardDish = CardView(frame: .zero)
    var receivedData: String?
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "user")
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    private lazy var leftArrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(leftArrowButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllSubviews()
        setupViews()
        setupDelegates()
        setupConstrainsts()
        setValues()
    }
    
    @objc private func leftArrowButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setValues() {
        if let receivedData = receivedData {
            titleLabel.text = receivedData
        }
    }
    
    private func setupDelegates() {
        horizontalCollectionView.delegateSource = verticalCollectioView
        verticalCollectioView.cardViewDelegate = self
    }
    
    private func addAllSubviews() {
        [leftArrowButton, titleLabel, userImageView, horizontalCollectionView, verticalCollectioView, cardDish].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        cardDish.isHidden = true
    }
    
    private func setupConstrainsts() {
                
        cardDish.snp.makeConstraints { make in
            make.centerY.equalTo(view.center.y)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        leftArrowButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.centerY.equalTo(userImageView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(userImageView.snp.centerY)
        }
        
        userImageView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        horizontalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(40)
        }
        
        verticalCollectioView.snp.makeConstraints { make in
            make.top.equalTo(horizontalCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.bottom.equalToSuperview()
        }
    }
}

extension CategoriesViewController: CardViewControllerDelegate {
    func didSelectItem(tegs: Tegs) {
        cardDish.configureCard(teg: tegs)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            cardDish.isHidden = false
        }
    }
}
