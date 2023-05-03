//
//  AccountPageViewController.swift
//  Foot Prints
//
//  Created by Nelson Pierce on 5/1/23.
//

import UIKit

import FirebaseDatabase
import FirebaseCore
import Firebase
import FirebaseAuth

class AccountPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: Outlets
    @IBOutlet weak var nameOfUser: UILabel!
    @IBOutlet weak var badgeTableView: UITableView!
    
    var names:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        badgeTableView.delegate = self
        badgeTableView.dataSource = self
        getUserData()
        
//        locationPage.imageView?.contentMode = .scaleAspectFit
//        locationPage.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        locationPage.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as! BadgeTableViewCell
        let name = names[indexPath.row]
//        cell.nameOfBadge.text = name
        cell.nameOfBadge.text! = name
        
        return cell
    }
    
    func getUserData() {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document("\(Auth.auth().currentUser!.uid)").collection("CollectedBadges")
        
        ref.getDocuments() { snapshot, error in
            if let error {
                print("Error")
            } else {
                for document in snapshot!.documents {
                    for result in document.data() {
                        print(document.data())
                        self.names.append("\(result.value)")
                        print(self.names)
                    }
                }
            }
            self.badgeTableView.reloadData()
        }
       
    }
}
