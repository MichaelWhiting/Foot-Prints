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

class AddOrCreateBadgeViewController: UIViewController {

    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var ratingSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBadgePressed(_ sender: Any) {
        let annotation = MKPointAnnotation()
        annotation.title = locationNameTextField.text
        annotation.coordinate = CLLocationCoordinate2D( latitude: currentCoordinate?.latitude ?? 0, longitude: currentCoordinate?.longitude ?? 0)
//         mapView.addAnnotation(annotation)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
