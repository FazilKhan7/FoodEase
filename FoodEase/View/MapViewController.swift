//
//  MapViewController.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 30.09.2023.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var titleCity: String?
    var subtitleCity: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentMap()
    }
    
    private func presentMap() {
        if let latitude = latitude, let longitude = longitude, let title = titleCity, let subtitle = subtitleCity {
            createMap(latitude: latitude, longitude: longitude, title: title, subtitle: subtitle)
        }
    }
    
    private func createMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subtitle: String) {
        let mapView = MKMapView(frame: view.bounds)
        view.addSubview(mapView)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle

        mapView.addAnnotation(annotation)

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
}

