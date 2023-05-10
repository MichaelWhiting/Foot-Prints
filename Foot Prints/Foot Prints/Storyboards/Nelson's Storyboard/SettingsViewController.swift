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

//class SettingsViewController: UIViewController{
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presentModal()
//
//    }
//
//    private func presentModal() {
//        let settingsViewController = SettingsViewController()
//        let nav = UINavigationController(rootViewController: settingsViewController)
//        // 1
//        nav.modalPresentationStyle = .pageSheet
//
//
//        // 2
//        if let sheet = nav.sheetPresentationController {
//
//            // 3
//            sheet.detents = [.medium()]
//
//        }
//        // 4
//        present(nav, animated: true, completion: nil)
//
//    }
//
//    }

class SettingsPresentationController: UIPresentationController{
    let blurEffectView: UIVisualEffectView! = nil
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    func dismiss(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
//    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        blurEffectView = UIVisualEffectView(effect: blurEffect)
//        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
//        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.blurEffectView.isUserInteractionEnabled = true
//        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
//    }
    override var frameOfPresentedViewInContainerView: CGRect{
        return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height/2), size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height/2))
    }
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 1
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in

        })
    }
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.layer.masksToBounds = true
        presentedView!.layer.cornerRadius = 10
    }
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        self.presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
}
    
    
