//
//  AccountPageViewController.swift
//  Foot Prints
//
//  Created by Nelson Pierce on 5/1/23.
//

import UIKit

import FirebaseAuth
import FirebaseCore
import Firebase

class AccountPageViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var badgesLabel: UILabel!
    @IBOutlet weak var nameOfUser: UILabel!
    @IBOutlet weak var nameOfLocationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Actions
    @IBAction func locationPageTapped(_ sender: Any) {
    }
    
    @IBAction func locationToMap(_ sender: Any) {
    }
    
    
    
    

}
