//
//  ListDishesCell.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 24.08.2023.
//

import Foundation
import UIKit

class ListDishesCell: UICollectionViewCell {
    
    static let reuseId = "listCell"
    
    private lazy var customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) / 3).isActive = true
        view.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) / 3).isActive = true
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private lazy var dishImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "load")
        img.layer.cornerRadius = 12
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    private lazy var dishName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        addAllSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 12
    }
    
    private func addAllSubviews() {
        customView.addSubview(dishImageView)
        addSubview(customView)
        addSubview(dishName)
    }
    
    func configureCell(teg: Tegs) {
        let urlString = teg.image_url
        if let urlImage = URL(string: urlString) {
            NetworkRequest.shared.loadImage(from: urlImage) { image in
                DispatchQueue.main.async {
                    self.dishImageView.image = image
                }
            }
        }
        dishName.text = teg.name
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            customView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 8),
            dishImageView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -8),
            dishImageView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 8),
            dishImageView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            dishName.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 5),
            dishName.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 8),
            dishName.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -1),
        ])
    }
}



