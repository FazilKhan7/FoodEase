//
//  HorizontalCollectionView.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 24.08.2023.
//

import Foundation
import UIKit

protocol SourceViewControllerDelegate: AnyObject {
    func didSelectItem(tag: String)
}

final class HorizontalCollectionView: UICollectionView {
        
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
        setUpViews()
    }
    
    weak var delegateSource: SourceViewControllerDelegate?
    private lazy var tegs = ["Все меню", "Cалаты", "С рисом", "С рыбой"]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpViews() {
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        register(DishesCategoryCell.self, forCellWithReuseIdentifier: DishesCategoryCell.reuseId)
    }
}

extension HorizontalCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tegs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishesCategoryCell.reuseId, for: indexPath) as! DishesCategoryCell
        
        cell.configureCell(categoryName: tegs[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DishesCategoryCell {
            cell.isSelected = !cell.isSelected
        }
        collectionView.selectItem(
            at: IndexPath(row: indexPath.row, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally
        )
        let selectedItem = tegs[indexPath.row]
        delegateSource?.didSelectItem(tag: selectedItem)
    }
}

