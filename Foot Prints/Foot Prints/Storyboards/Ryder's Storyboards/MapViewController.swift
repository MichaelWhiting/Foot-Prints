//
//  MapViewController.swift
//  Foot Prints
//
//  Created by Ryder Claybaugh on 4/19/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        configureLocationServices()
        // Do any additional setup after loading the view.
    }


    private func configureLocationServices() {
        locationManager.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
        
        
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    private func addAnnotations() {
        let appleParkAnnotation = MKPointAnnotation()
        appleParkAnnotation.title = "Apple Park"
        appleParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.332072300, longitude: -122.011138100)
        
        let ortegaParkAnnotation = MKPointAnnotation()
        ortegaParkAnnotation.title = "Ortega Park"
        ortegaParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.342226, longitude: -122.025617)
        
        mapView.addAnnotation(appleParkAnnotation)
        mapView.addAnnotation(ortegaParkAnnotation)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get latest location")
        
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
            addAnnotations()
        }
        
        currentCoordinate = latestLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("The status changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        if let title = annotation.title, title == "Apple Park" {
            annotationView?.image = UIImage(named: "saucer")
        } else if let title = annotation.title, title == "Ortega Park" {
            annotationView?.image = UIImage(named: "tree")
        } else if annotation === mapView.userLocation {
            annotationView?.image = UIImage(named: "car")
        }
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The annotation was selected: \(String(describing: view.annotation?.title))")
    }
    
}
