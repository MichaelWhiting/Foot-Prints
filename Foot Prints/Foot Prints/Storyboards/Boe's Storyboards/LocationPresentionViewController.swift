//
//  LocationPresentionViewController.swift
//  Foot Prints
//
//  Created by Boe Bogdin on 5/4/23.
//

import UIKit

class LocationPresentationViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    let containerViewTag = 1001
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            UISheetPresentationController.Detent.large()
        ]
        
        makeButton()
    }
    
    func makeButton() {
        let button = UIButton(configuration: .filled(), primaryAction: .init(handler: { _ in
            self.sheetPresentationController.animateChanges {
                if self.sheetPresentationController.selectedDetentIdentifier == .medium {
                    self.sheetPresentationController.selectedDetentIdentifier = .large
                } else {
                    self.sheetPresentationController.selectedDetentIdentifier = .medium
                }
            }
        }))
        button.setTitle("Present Sheet", for: UIControl.State.normal)
        button.configuration?.cornerStyle = .capsule
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 200).isActive = true
        button.widthAnchor.constraint(equalToConstant: 45).isActive = true
    }
}

