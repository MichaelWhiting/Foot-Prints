//
//  SignInViewController.swift
//  Foot Prints
//
//  Created by Michael Whiting on 4/20/23.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIcon.isHidden = true
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("sign in button tapped")
        loadingIcon.isHidden = false
        loadingIcon.startAnimating()
        guard let emailStr = emailTextField.text, let passwordStr = passwordTextField.text else { return }
        
        signIn(email: emailStr, password: passwordStr)
    }
}

extension SignInViewController {
    // MARK: Functions
    
    func completedLogin() {
        self.view.window?.rootViewController = UIStoryboard(name: "TabBar", bundle: .main).instantiateViewController(withIdentifier: "TabBarVC")
    }
    
    func signIn(email: String, password: String) {
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
