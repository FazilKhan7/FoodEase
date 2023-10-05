//
//  BascetTableViewCell.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 02.09.2023.
//

import Foundation
import UIKit
import SnapKit

protocol BascetTableViewCellDelegate: AnyObject {
    func stepperValueChanged(inCell cell: BascetTableViewCell, quantity: Int)
}

final class BascetTableViewCell: UITableViewCell {
    
    static let reuseId = "cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addAllSubviews()
        setConstraints()
    }
    
    weak var delegate: BascetTableViewCellDelegate?
    
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
    
    private lazy var stepperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus")?.withTintColor(.black), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(increment), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func addAllSubviews() {
        stackView.addArrangedSubview(nameOfDish)
        stackView.addArrangedSubview(priceOfDish)
        [minusButton, countLabel, plusButton].forEach {
            stepperView.addSubview($0)
        }
        [dishImageView, stackView, stepperView].forEach {
            contentView.addSubview($0)
        }
    }
    
    @objc private func increment() {
        delegate?.stepperValueChanged(inCell: self, quantity: 1)
    }
    
    @objc private func decrement() {
        delegate?.stepperValueChanged(inCell: self, quantity: -1)
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
        
        stepperView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-12)
            make.centerY.equalTo(stackView.snp.centerY)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(stepperView.snp.centerY)
            make.trailing.equalTo(stepperView.snp.trailing).offset(-6)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(stepperView.snp.centerY)
            make.centerX.equalTo(stepperView.snp.centerX)
        }
        
        minusButton.snp.makeConstraints { make in
            make.centerY.equalTo(stepperView.snp.centerY)
            make.leading.equalTo(stepperView.snp.leading).offset(6)
        }
    }
    
    func configureCell(entity: DishEntity) {
        priceOfDish.text = "\(entity.price) ₽"
        nameOfDish.text = entity.name
        countLabel.text = "\(entity.quantity)"
        
        let urlString = entity.imageUrl
        guard let urlString = urlString else { return }
        
        if let urlImage = URL(string: urlString) {
            NetworkRequest.shared.loadImage(from: urlImage) { image in
                DispatchQueue.main.async {
                    self.dishImageView.image = image
                }
            }
        }
    }
}
