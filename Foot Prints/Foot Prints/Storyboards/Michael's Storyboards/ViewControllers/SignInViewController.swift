//
//  SignInViewController.swift
//  Foot Prints
//
//  Created by Michael Whiting on 4/20/23.
//

import UIKit
import SwiftUI
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loadingIcon: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIcon.isHidden = true
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("sign in button tapped")
        guard let emailStr = emailTextField.text, let passwordStr = passwordTextField.text else { return }
        
        signIn(email: emailStr, password: passwordStr)
    }
    
    @IBSegueAction func loadingIconSwiftUI(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: CustomLoadCircle())
    }
}

extension SignInViewController {
    // MARK: Functions
    
    func completedLogin() {
        self.view.window?.rootViewController = UIStoryboard(name: "TabBar", bundle: .main).instantiateViewController(withIdentifier: "TabBarVC")
    }
    
    func signIn(email: String, password: String) {
        loadingIcon.isHidden = false
        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            if error != nil {
                print("Error with signing in, perhaps the user does not exist.")
            } else {
                print("User has been signed in.")
                completedLogin()
            }
        }
    }
}
