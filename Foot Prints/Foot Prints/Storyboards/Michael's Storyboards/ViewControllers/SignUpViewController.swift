//
//  SignUpViewController.swift
//  Foot Prints
//
//  Created by Michael Whiting on 4/20/23.
//

import UIKit
import SwiftUI
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var loadingIcon: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIcon.isHidden = true
    }
    
    
    @IBSegueAction func swiftUISegue(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: CustomLoadCircle())
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        loadingIcon.isHidden = false
        guard let emailStr = emailTextField.text,
              let passwordStr = passwordTextField.text,
              let confirmPasswordStr = confirmPasswordTextField.text
        else { return }
        
        if passwordStr != confirmPasswordStr {
            loadingIcon.isHidden = true
            return
        }
        
        createAccount(email: emailStr, password: passwordStr)
    }
}

extension SignUpViewController {
    // MARK: Functions
    
    func createAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] result, error in
            if error != nil {
                loadingIcon.isHidden = true
                print("Error with signing up.")
            } else {
                print("User has been signed up")
                
                if let userUID = result?.user.uid {
                    let db = Firestore.firestore()
                    let usersDocRef = db.collection("Users").document(userUID)
                    
                    usersDocRef.setData(["userID": userUID, "email": email])
                }
                
                self.signIn(email: email, password: password)
            }
        }
    }
    
    func completedLogin() {
        self.view.window?.rootViewController = UIStoryboard(name: "TabBar", bundle: .main).instantiateViewController(withIdentifier: "TabBarVC")
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            if error != nil {
                loadingIcon.isHidden = true
                print("Error with signing in, perhaps the user does not exist.")
            } else {
                print("User has been signed in.")
                completedLogin()
            }
        }
    }
}
