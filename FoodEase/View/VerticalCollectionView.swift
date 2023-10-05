//
//  VerticalCollectionView.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 24.08.2023.
//

import Foundation
import UIKit

protocol CardViewControllerDelegate: AnyObject {
    func didSelectItem(tegs: Tegs)
}

final class VerticalCollectionView: UICollectionView, DishesPresenterDelegate {
    
    private lazy var horizontalVC = HorizontalCollectionView(frame: .zero)
    private lazy var dishCard = CardView(frame: .zero)
    
    weak var cardViewDelegate: CardViewControllerDelegate?
    private var presenter = DishesPresenter()
    private lazy var dishesBySelectedTeg: [Tegs] = []
    
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 10
        super.init(frame: frame, collectionViewLayout: layout)
        
        presenter.getDishes(teg: "Все меню")
        presenter.setViewDelegate(delegate: self)
        configure()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpViews() {
        delegate = self
        dataSource = self
        register(ListDishesCell.self, forCellWithReuseIdentifier: ListDishesCell.reuseId)
        showsVerticalScrollIndicator = false
    }
    
    func presentDishes(tegs: [Tegs]) {
        self.dishesBySelectedTeg = tegs
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

extension VerticalCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishesBySelectedTeg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListDishesCell.reuseId, for: indexPath) as! ListDishesCell
        
        let tegs = dishesBySelectedTeg[indexPath.row]
        cell.configureCell(teg: tegs)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tegs = dishesBySelectedTeg[indexPath.row]
        cardViewDelegate?.didSelectItem(tegs: tegs)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 20
        let collectionViewSize = collectionView.frame.size.width - padding
        let itemWidth = collectionViewSize / 3
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension VerticalCollectionView: SourceViewControllerDelegate {
    func didSelectItem(tag: String) {
        presenter.getDishes(teg: tag)
    }
}

private extension VerticalCollectionView {
    func sortByTeg(teg: String) {
        presenter.getDishes(teg: teg)
    }
}
