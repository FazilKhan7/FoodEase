//
//  MainViewController.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 04.07.2023.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation

final class MainViewController: UIViewController, MainPresenterDelegate {
    
    private lazy var customNavigationBar = CustomNavigationBar()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        
        return collectionView
    }()
    
   private lazy var categoriesArray = [CategoryModel]()
   private var presenter = MainPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllSubviews()
        setupViews()
        setupConstraints()
    }
    
    func presentCategories(categories: [CategoryModel]) {
        self.categoriesArray = categories
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func addAllSubviews() {
        [collectionView, customNavigationBar].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        presenter.setViewDelegate(delegate: self)
        presenter.getCategories()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        customNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(customNavigationBar.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.layer.frame.width, height: 148)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
        
        let category = categoriesArray[indexPath.row]
        cell.configureCell(category: category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CategoriesViewController()
        vc.receivedData = categoriesArray[indexPath.row].name
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
