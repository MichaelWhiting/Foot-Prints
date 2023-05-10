//
//  SettingsViewController.swift
//  Foot Prints
//
//  Created by Nelson Pierce on 5/10/23.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func changePassword(_ sender: UIButton) {
        
    }
    
    @IBAction func signOut(_ sender: UIButton) {
       try? Auth.auth().signOut()
        completedLogin()
    }
    
    func completedLogin() {
         self.view.window?.rootViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "StartUpScreen")
     }
    
}
