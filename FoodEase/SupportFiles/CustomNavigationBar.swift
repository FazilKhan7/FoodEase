//
//  CustomNavigationBar.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 02.09.2023.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation
import MapKit

final class CustomNavigationBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAllSubviews()
        setupViews()
        tappedGestureImage()
        setConstraints()
        setLocations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
    private lazy var locationManager = CLLocationManager()
    private var title: String?
    private var subTitle: String?
    
    private lazy var locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "location")
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        return imageView
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cityLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        return cityLabel
    }()
    
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        label.text = dateString
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        return label
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "user")
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 7
        
        return stackView
    }()
    
    @objc private func locationImageTapped() {
        let mapViewController = MapViewController()
        
        mapViewController.latitude = locationManager.location?.coordinate.latitude
        mapViewController.longitude = locationManager.location?.coordinate.longitude
        mapViewController.titleCity = title
        mapViewController.subtitleCity = subTitle
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let navController = UINavigationController(rootViewController: mapViewController)
            window.rootViewController?.present(navController, animated: true, completion: nil)
        }
    }
    
    private func addAllSubviews() {
        [locationImage, userImageView, stackView].forEach {
            addSubview($0)
        }
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    
    private func tappedGestureImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(locationImageTapped))
        locationImage.isUserInteractionEnabled = true
        locationImage.addGestureRecognizer(tapGesture)
    }
    
    private func setLocations() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setConstraints() {
        locationImage.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(12)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(locationImage.snp.trailing).offset(5)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        userImageView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-12)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
        }
    }
}


extension CustomNavigationBar: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let location = CLLocation(latitude: latitude, longitude: longitude)
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    return
                }
                
                if let placemark = placemarks?.first {
                    if let city = placemark.locality,
                       let country = placemark.country {
                       let address = "\(city), \(country)"
                       self.title = country
                       self.subTitle = city
                       self.cityLabel.text = address
                    } else {
                        print("Unable to retrieve address components")
                    }
                } else {
                    print("No placemarks found")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error is occured")
    }
}


