//
//  MapViewController.swift
//  Foot Prints
//
//  Created by Ryder Claybaugh on 4/19/23.
//

import UIKit
import MapKit

import FirebaseDatabase
import FirebaseCore
import Firebase
import FirebaseAuth

struct Location {
    let name: String
    let latitude: String
    let longitude: String
    let sliderRating: Double
    let locationID: String
    let amountVisited: Int
}

class MapViewController: UIViewController {
    
    var locationID = ""

    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    var locations: [Location] = []
    var annotations = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureLocationServices()
        readLocations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadLocations()
        }
//        self.tabBarController?.delegate = self
    }
    
    func readLocations() {
        let db = Firestore.firestore()
        
        let readingRef = db.collection("Locations")
        readingRef.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                print("\(error)")
                return
            }
            print("Snapshot Listener Triggered 🔁")
            self.locations = []
            for document in snapshot.documents {
                let data = document.data()
                let newLocation = Location(name: data["name"] as! String, latitude: data["latitude"] as! String, longitude: data["longitude"] as! String, sliderRating: data["sliderRating"] as? Double ?? 0.0, locationID: data["locationID"] as? String ?? "", amountVisited: data["amountVisited"] as? Int ?? 0)
                self.locations.append(newLocation)
//                print("added location: \(newLocation.name)")
            }
            self.loadLocations()
        }
        readingRef.getDocuments { snapshot, error in
            if let error {
                print("There was an error reading from document: Locations")
            } else {
                for document in snapshot!.documents {
                    let data = document.data()
                    let newLocation = Location(name: data["name"] as! String, latitude: data["latitude"] as! String, longitude: data["longitude"] as! String, sliderRating: data["sliderRating"] as? Double ?? 0.0, locationID: data["locationID"] as? String ?? "", amountVisited: data["amountVisited"] as! Int)
//                    print("read . . . \(newLocation)")
                    self.locations.append(newLocation)
                }
            }
        }
        print("read locations")
    }
    
    func loadLocations() {
        mapView.removeAnnotations(annotations)
        annotations = []
        for location in locations {
//            print("loading . . . \(location)")
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!)
            annotations.append(annotation)
            mapView.addAnnotation(annotation)
        }
        print("annotations added")
        print("\(locations)")
    }
    
    private func configureLocationServices() {
        locationManager.delegate = self
        
        let status = CLLocationManager().authorizationStatus
        
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
    
    func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get latest location")
        
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The annotation was selected: \(String(describing: view.annotation?.title))")
        getLocationID(selectedAnnotation: view) { result in
            switch result {
            case .success(let id):
                self.locationID = id
                self.performSegue(withIdentifier: "showBadge", sender: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBadge" {
            guard let vc = segue.destination as? LocationViewController else { return }
//            vc.locationlabel.text = String(describing: view.annotation?.title)
            vc.newLocationID = locationID
        }
    }
    
    func getLocationID(selectedAnnotation: MKAnnotationView, completion: @escaping (Result<String, Error>) -> Void) {
        let db = Firestore.firestore()
        var returnID = ""
        let locationsReference = db.collection("Locations")
        locationsReference.whereField("latitude", isEqualTo: String(selectedAnnotation.annotation?.coordinate.latitude ?? 0)).getDocuments { snapshot, error in
            if let error {
                completion(.failure(error))
            } else {
                do {
                    for document in snapshot!.documents {
                        let data = document.data()
                        returnID = data["locationID"] as! String
                    }
                    completion(.success(returnID))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
}


