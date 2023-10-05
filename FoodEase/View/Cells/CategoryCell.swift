//
//  CategoryCell.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 04.07.2023.
//

import Foundation
import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let reuseId = "Cell"
    
    private lazy var categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryName)
    }
    
    private func setupConstraints() {
        categoryImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview()
        }
        
        categoryName.snp.makeConstraints { make in
            make.top.equalTo(categoryImage.snp.top).offset(10)
            make.leading.equalTo(categoryImage.snp.leading).offset(10)
        }
    }
    
    func configureCell(category: CategoryModel) {
        categoryName.text = category.name
        let urlString = category.imageURL
        if let urlImage = URL(string: urlString) {
            NetworkRequest.shared.loadImage(from: urlImage) { image in
                DispatchQueue.main.async {
                    self.categoryImage.image = image
                }
            }
        }
    }
}
