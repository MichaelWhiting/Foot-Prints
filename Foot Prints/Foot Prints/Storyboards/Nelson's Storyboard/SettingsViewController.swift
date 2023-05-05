//
//  SettingsViewController.swift
//  Foot Prints
//
//  Created by Nelson Pierce on 5/3/23.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import Firebase

class SettingsViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        presentModal()

    }
    
    private func presentModal() {
        let settingsViewController = SettingsViewController()
        let nav = UINavigationController(rootViewController: settingsViewController)
        // 1
        nav.modalPresentationStyle = .pageSheet

        
        // 2
        if let sheet = nav.sheetPresentationController {

            // 3
            sheet.detents = [.medium()]

        }
        // 4
        present(nav, animated: true, completion: nil)

    }
        
    }
    
    
