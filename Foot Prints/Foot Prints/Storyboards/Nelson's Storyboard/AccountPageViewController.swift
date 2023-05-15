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
import MapKit

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
        getUserEmail()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as! BadgeTableViewCell
        let name = names[indexPath.row]
        cell.nameOfBadge.text! = name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    func getUserEmail() {
        let db = Firestore.firestore()
        
        if let userID = Auth.auth().currentUser?.uid{
            let usersReference = db.collection("Users").document(userID)
            usersReference.getDocument { document, error in
                if let error{
                    print(error.localizedDescription)
                } else {
                    let data = document!.data()
                    let email = data?["email"] as? String
                    self.nameOfUser.text = email ?? ""
                }
            }
        }
    }
    
    @IBAction func settingsPage(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        self.present(viewController, animated: true)
    }
    
    
    @IBAction func toLocationPage(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func toMapPage(_ sender: UIButton) {
        
        var cooridinate = CLLocationCoordinate2D(latitude: .init(40.7127281), longitude: .init(-74.0060152))
        
        guard let tabBarController = self.tabBarController as? TabBarController else { 
            fatalError("expected TabBarController instead of UITabBarController!")
        }
        
        tabBarController.navigate(to: cooridinate)
        
    }
    
}
