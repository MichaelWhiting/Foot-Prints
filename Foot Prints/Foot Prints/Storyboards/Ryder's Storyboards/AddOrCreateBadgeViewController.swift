//
//  AddOrCreateBadgeViewController.swift
//  Foot Prints
//
//  Created by Ryder Claybaugh on 5/1/23.
//

import UIKit

import FirebaseAuth
import FirebaseCore
import Firebase

import CoreLocation
import MapKit

class AddOrCreateBadgeViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var ratingSlider: UISlider!
    
    var latitude = ""
    var longitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationNameTextField.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        
        print("latitude = \(userLocation.coordinate.latitude)")
        print("longitude = \(userLocation.coordinate.longitude)")
        
        longitude = "\(userLocation.coordinate.longitude)"
        latitude = "\(userLocation.coordinate.latitude)"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    @IBAction func addBadgePressed(_ sender: Any) {
        let locationID = UUID().uuidString
        let db = Firestore.firestore()
        let ref = db.collection("Locations")
        let userRef = db.collection("Users").document(Auth.auth().currentUser!.uid)
        let data: [String : Any] = ["longitude": longitude, "latitude": latitude, "name": locationNameTextField.text ?? "", "sliderRating": ratingSlider.value, "amountVisited": 1, "locationID": locationID]
        
        
        ref.addDocument(data: data)
        
        userRef.collection("CollectedBadges").addDocument(data: data)
        
        print("latitude: \(latitude), longitude: \(longitude)")
    }
}

extension AddOrCreateBadgeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
