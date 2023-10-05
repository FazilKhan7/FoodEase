//
//  DishesCategoryCell.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 24.08.2023.
//

import Foundation
import UIKit

class DishesCategoryCell: UICollectionViewCell {
    
    static let reuseId = "categoryCell"
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? #colorLiteral(red: 0.2544889748, green: 0.4875386357, blue: 0.9033587575, alpha: 1) : #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1)
            categoryName.textColor = isSelected ? .white : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(categoryName: String) {
        self.categoryName.text = categoryName
    }
    
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1)
        layer.cornerRadius = 12
        addSubview(categoryName)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            categoryName.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
