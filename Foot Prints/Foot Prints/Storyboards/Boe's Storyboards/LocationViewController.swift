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

class LocationViewController: UIViewController {
    
    @IBOutlet weak var PeoplecollectedBadgeLabel: UILabel!
    @IBOutlet weak var NumberThisBadgeLabel: UILabel!
    
    @IBOutlet weak var UsersLabel: UILabel!
    
    @IBOutlet weak var LocationsLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    @IBAction func DifficultyRatingButton(_ sender: Any) {
    }
    
    
    @IBAction func AddthisBadgeButton(_ sender: Any) {
    }
}
