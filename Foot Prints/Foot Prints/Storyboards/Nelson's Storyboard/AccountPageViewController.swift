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
    
    var locations: [Location] = []
    
    //MARK: Outlets
    @IBOutlet weak var nameOfUser: UILabel!
    @IBOutlet weak var badgeTableView: UITableView!
    
    private var refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        badgeTableView.delegate = self
        badgeTableView.dataSource = self
        getUserData()
        getUserEmail()
        
        badgeTableView.refreshControl = refreshControl
        
        badgeTableView.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
                
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as! BadgeTableViewCell
        let name = locations[indexPath.row].name
        cell.nameOfBadge.text! = name
        cell.updateCell(with: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func refresh(sender:AnyObject) {
        locations = []
        getUserData()
        self.badgeTableView.refreshControl?.endRefreshing()
    }
    
    //MARK: we need to refresh this
    func getUserData() {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document("\(Auth.auth().currentUser!.uid)").collection("CollectedBadges")
        
        ref.getDocuments() { snapshot, error in
            if let error {
                print("Error")
            } else {
                for document in snapshot!.documents {
                    let data: [String: Any] = document.data()
                    let decodedLocation = Location(name: data["name"] as! String, latitude: data["latitude"] as! String, longitude: data["longitude"] as! String, sliderRating: data["sliderRating"] as! Double, locationID: data["locationID"] as! String, amountVisited: data["amountVisited"] as! Int)
                    self.locations.append(decodedLocation)
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
        
<<<<<<< HEAD
        // get the cell row of this button when tapped go to the correct map location
        print(sender.tag)
        var selectedLocation = locations[sender.tag]
=======
        var selectedLocation = locations[0]
        
>>>>>>> 448ac88 (bugFixesAndAmountVisited)
        var cooridinate = CLLocationCoordinate2D(latitude: .init(Double(selectedLocation.latitude)!), longitude: .init(Double(selectedLocation.longitude)!))

        guard let tabBarController = self.tabBarController as? TabBarController else {
            fatalError("expected TabBarController instead of UITabBarController!")
        }

        tabBarController.navigate(to: cooridinate)

    }
    
}
