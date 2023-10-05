//
//  SearchTableViewCell.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 26.09.2023.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let reuseID = "searchCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addAllSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(named: "load")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 7
        
        return stackView
    }()
    
    private lazy var nameOfDish: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var priceOfDish: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func addAllSubviews() {
        stackView.addArrangedSubview(nameOfDish)
        stackView.addArrangedSubview(priceOfDish)
        [dishImageView, stackView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setConstraints() {
        dishImageView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(12)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(dishImageView.snp.trailing).offset(12)
            make.top.equalTo(dishImageView.snp.top)
        }
    }
    
    func configureCell(dish: Dish) {
        priceOfDish.text = "\(dish.price) ₽"
        nameOfDish.text = dish.name
        
        let urlString = dish.imageURL
        if let urlImage = URL(string: urlString) {
            NetworkRequest.shared.loadImage(from: urlImage) { image in
                DispatchQueue.main.async {
                    self.dishImageView.image = image
                }
            }
        }
    }
}
