//
//  MapPresenter.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 30.09.2023.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

protocol MapPresenterDelegate: AnyObject {
    func presentMap(searchedDishes: [Dish])
}

typealias PresenterMapDelegate = MapPresenterDelegate & UIViewController

class MapPresenter {
    
    weak var delegate: PresenterMapDelegate?
    
    public func displayMap(view: UIView) {
        
        let mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        let latitude: CLLocationDegrees = 37.7749
        let longitude: CLLocationDegrees = -122.4194

        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "San Francisco"
        annotation.subtitle = "California"

        mapView.addAnnotation(annotation)

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    public func setViewDelegate(delegate: PresenterMapDelegate) {
        self.delegate = delegate
    }
}
