//
//  SignUpViewController.swift
//  Foot Prints
//
//  Created by Michael Whiting on 4/20/23.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        print("Create account button tapped")
        guard let emailStr = emailTextField.text,
              let passwordStr = passwordTextField.text,
              let confirmPasswordStr = confirmPasswordTextField.text
        else { return }
        
        guard passwordStr == confirmPasswordStr else { return }
        
        createAccount(email: emailStr, password: passwordStr)
    }
}

extension SignUpViewController {
    // MARK: Functions
    
    func createAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("Error with signing up.")
            } else {
                print("User has been signed up")
                
                if let userUID = result?.user.uid {
                    let db = Firestore.firestore()
                    let usersDocRef = db.collection("Users").document(userUID)
                    
                    usersDocRef.setData(["userID": userUID, "email": email])
                }
            }
        }
    }
}
