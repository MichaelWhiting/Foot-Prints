//
//  TestingFirebaseViewController.swift
//  Foot Prints
//
//  Created by Michael Whiting on 5/1/23.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import Firebase
import FirebaseAuth

class TestingFirebaseViewController: UIViewController {
    
    var results: [String: Any] = [:]

    @IBOutlet weak var dataLabel: UILabel!
    
    var displayString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }
    
    func getUserData() {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document("\(Auth.auth().currentUser!.uid)")
        ref.getDocument { snapshot, error in
            if let error {
                print("Error")
            } else {
                let data: [String: Any] = snapshot!.data() ?? [:]
                for thing in data {
                    print("\(thing.key) = \(thing.value)")
                }
            }
        }
        
    }
    
    @IBAction func createNewBadgeButton(_ sender: Any) {
        let db = Firestore.firestore()
        
        let ref = db.collection("Locations").document("Location 1")
        ref.setData(["longitude": "123.4928414", "latitude": "21321.2414218941", "name": "person 1"])
    }

        
    @IBAction func readFirebaseButton(_ sender: Any) {
        let db = Firestore.firestore()
        
        let readingRef = db.collection("TestReading")
        readingRef.getDocuments { snapshot, error in
            if let error {
                print("There was an error")
            } else {
                for document in snapshot!.documents {
                    self.results = document.data()
                    for result in self.results {
                        self.displayString.append("\(result.key):\(result.value) \n")
                        self.dataLabel.text = self.displayString
                    }
                }
            }
        }
    }
}

