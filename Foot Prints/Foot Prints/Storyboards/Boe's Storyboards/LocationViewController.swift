//
//  LocationViewController.swift
//  Foot Prints
//
//  Created by Boe Bogdin on 5/1/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase

class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var newLocationID: String?
    var newLocation: Location?
    
    var dataSource: [String] = ["Item 1", "Item2", "Item3"]
    
    @IBOutlet weak var UserstableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocationInfo(from: newLocationID ?? "test")
        // Set the table view's delegate and data source to self
//        UserstableView.delegate = self
//        UserstableView.dataSource = self
    }
    
    // MARK: - Table view data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the data source
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell or create a new one
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! UsersTableViewCell
        
        // Get the data for the current row from the data source
        let rowData = dataSource[indexPath.row]
        
        // Set the text of the label in the cell
        cell.Userslabel.text = rowData
        
        return cell
    }
    
    @IBOutlet weak var collectBadgeNumberLabel: UILabel!
    // MARK: - Table view delegate methods
    @IBAction func RatingSlider(_ sender: UISlider) {
    }
    @IBAction func Addthisbadgebutton(_ sender: Any) {
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(Auth.auth().currentUser!.uid)
        let locationsRef = db.collection("Locations")
        
        locationsRef.whereField("locationID", isEqualTo: newLocationID!).getDocuments {  snapshot, error in
            if let error {
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    if self.newLocationID != nil {
                        let data: [String: Any] = document.data()
                        let currentAmountVisited = data["amountVisited"] as? Int ?? 0
                        locationsRef.document(document.documentID).updateData(["amountVisited": currentAmountVisited + 1])
                        userRef.collection("CollectedBadges").addDocument(data: data)
                    }
                }
                self.dismiss(animated: true)
            }
        }
    }
    
    // Implement any necessary table view delegate methods here
    
    // MARK: - IBActions and IBOutlets
    
    // Connect any necessary IBActions and IBOutlets here
    class UsersTableViewCell: UITableViewCell {
        @IBOutlet weak var Userslabel: UILabel!
    }
    @IBOutlet weak var Locationslabel: UILabel!
}

extension LocationViewController {
    // MARK: Firebase Functions
    
    func loadLocationInfo(from locationID: String) {
        let db = Firestore.firestore()
        let locationsRef = db.collection("Locations")
        
        locationsRef.whereField("locationID", isEqualTo: locationID).getDocuments {  snapshot, error in
            if let error {
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    if self.newLocationID != nil {
                        let data: [String: Any] = document.data()
                        self.newLocation = Location(name: data["name"] as! String, latitude: data["latitude"] as! String, longitude: data["longitude"] as! String, sliderRating: data["sliderRating"] as! Double, locationID: data["locationID"] as! String, amountVisited: data["amountVisited"] as! Int)
                    }
                    self.Locationslabel.text = self.newLocation?.name
                    self.collectBadgeNumberLabel.text = String(self.newLocation?.amountVisited ?? 0)
//                    self.ratingSlider.value = self.newLocation?.sliderRating
                }
            }
        }
    }
}



