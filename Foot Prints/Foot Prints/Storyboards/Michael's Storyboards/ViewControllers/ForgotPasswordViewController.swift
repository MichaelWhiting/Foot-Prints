//
//  ForgotPasswordViewController.swift
//  Foot Prints
//
//  Created by Michael Whiting on 4/20/23.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self

    }
    
    @IBAction func sendResetLinkButtonTapped(_ sender: Any) {
        guard let emailStr = emailTextField.text else { return }
        resetPassword(email: emailStr)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension ForgotPasswordViewController {
    // MARK: Functions
    
    func resetPassword(email: String) {
        print("Reset button tapped")
        Auth.auth().sendPasswordReset(withEmail: email)
    }
}

