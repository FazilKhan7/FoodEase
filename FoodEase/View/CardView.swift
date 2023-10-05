//
//  CardView.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 26.08.2023.
//

import Foundation
import UIKit

final class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAllSubviews()
        setConstarianst()
        setupViews()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 410, height: (UIScreen.main.bounds.height / 2) - 20)
    }
    
    private var selectedTag: Tegs?
    
    private lazy var customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(nil, action: #selector(closeTappedFunc), for: .primaryActionTriggered)
        
        return button
    }()
    
    private lazy var xView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return view
    }()
    
    private lazy var dishImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var nameOfDish: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    private lazy var priceOfDish: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        return label
    }()
    
    private lazy var descriptionOfDish: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var addBascetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить в корзину", for: .normal)
        button.layer.cornerRadius = 12
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = #colorLiteral(red: 0.2, green: 0.3921568627, blue: 0.8784313725, alpha: 1)
        button.configuration = config

        button.addTarget(self, action: #selector(handleSelectedTegs), for: .primaryActionTriggered)
        
        return button
    }()
    
    @objc private func handleSelectedTegs() {
        let managedObject = DishEntity()
        if let selectedTag = selectedTag {
            managedObject.name = selectedTag.name
            managedObject.price = Int16(selectedTag.price)
            managedObject.imageUrl = selectedTag.image_url
            managedObject.quantity = 1
            CoreDataManager.shared.saveContext()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            isHidden = true
        }
    }
    
    @objc private func closeTappedFunc() {
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAllSubviews() {
        customView.addSubview(dishImageView)
        xView.addSubview(closeButton)
        [customView, nameOfDish, priceOfDish, descriptionOfDish, addBascetButton, xView].forEach {
            addSubview($0)
        }
    }
    
    func configureCard(teg: Tegs) {
        selectedTag = teg
        nameOfDish.text = teg.name
        priceOfDish.text = "\(teg.price) ₽ · \(teg.weight)г"
        descriptionOfDish.text = teg.description
        let urlString = teg.image_url
        if let urlImage = URL(string: urlString) {
            NetworkRequest.shared.loadImage(from: urlImage) { image in
                DispatchQueue.main.async {
                    self.dishImageView.image = image
                }
            }
        }
    }
    
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        alpha = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.cornerRadius = 12
    }
    
    private func setConstarianst() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            customView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 4) - 20),
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: xView.topAnchor, constant: 10),
            closeButton.bottomAnchor.constraint(equalTo: xView.bottomAnchor, constant: -10),
            closeButton.leadingAnchor.constraint(equalTo: xView.leadingAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: xView.trailingAnchor, constant: -10),
            xView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            xView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10)
        ])
        
        
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            dishImageView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10),
            dishImageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            dishImageView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10)
        ])
        
        
        NSLayoutConstraint.activate([
            nameOfDish.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 10),
            nameOfDish.leadingAnchor.constraint(equalTo: customView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            priceOfDish.topAnchor.constraint(equalTo: nameOfDish.bottomAnchor, constant: 10),
            priceOfDish.leadingAnchor.constraint(equalTo: customView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionOfDish.topAnchor.constraint(equalTo: priceOfDish.bottomAnchor, constant: 10),
            descriptionOfDish.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            descriptionOfDish.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addBascetButton.topAnchor.constraint(equalTo: descriptionOfDish.bottomAnchor, constant: 10),
            addBascetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            addBascetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addBascetButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            addBascetButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
