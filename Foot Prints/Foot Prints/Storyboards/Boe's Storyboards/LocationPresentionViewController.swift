//
//  LocationPresentionViewController.swift
//  Foot Prints
//
//  Created by Boe Bogdin on 5/4/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase

class LocationPresentationViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    let containerViewTag = 1001
    var backgroundColorAlpha: CGFloat = 0.5
    
    @IBAction func NextButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NextViewController")
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        self.present(viewController, animated: true)
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
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if sheetPresentationController.selectedDetentIdentifier == .medium {
            sheetPresentationController.animateChanges {
                self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            }
        } else {
            sheetPresentationController.animateChanges {
                self.view.backgroundColor = UIColor(white: 0, alpha: 1.0)
            }
        }
    }
}

class MYFadeOutDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    }
    
    let DismissalDuration = 0.15
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return DismissalDuration
    }
}
func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let DismissalDuration = 0.15
    
    let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
    let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
    let containerView = transitionContext.containerView

    containerView.addSubview(toViewController.view)
    containerView.sendSubviewToBack(toViewController.view)

    UIView.animate(withDuration: DismissalDuration, delay: 0.0, options: .curveLinear, animations: {
        //            fromViewController.view.backgroundColor = UIColor.clearColor()
        //            if let pickerContainerView = toViewController.view.viewWithTag(kContainerViewTag) {
        //                let transform = CGAffineTransformMakeTranslation(0.0, pickerContainerView.frame.size.height)
        //                pickerContainerView.transform = transform
        //            }
        fromViewController.view.alpha = 0.0

    }) { (finished) in
        let canceled: Bool = transitionContext.transitionWasCancelled
        transitionContext.completeTransition(true)

        if !canceled {
            UIApplication.shared.keyWindow?.addSubview(toViewController.view)
        }
    }
}
class MyFadeInFadeOutTransitioning: NSObject, UIViewControllerTransitioningDelegate {
    var backgroundColorAlpha: CGFloat = 0.5
    var shouldDismiss = false

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MyPresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyFadeInPresentAnimationController()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyFadeOutDismissAnimationController()
    }
}

class MyPresentationController: UIPresentationController {
    override var shouldRemovePresentersView: Bool {
        return true
    }
}

class MyFadeInPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    let PresentationDuration = 0.3

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return PresentationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }

        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView

        toViewController.view.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: PresentationDuration, delay: 0.0, options: [.curveEaseOut], animations: {
            toViewController.view.frame = finalFrame
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}

class MyFadeOutDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    let DismissalDuration = 0.15

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return DismissalDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }

        let containerView = transitionContext.containerView

        UIView.animate(withDuration: DismissalDuration, delay: 0.0, options: [.curveLinear], animations: {
            fromViewController.view.alpha = 0.0
        }, completion: { finished in
            let canceled: Bool = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!canceled)

            if !canceled {
                containerView.addSubview(fromViewController.view)
            }
        })
    }
}

class MyViewController: UIViewController {
    var customTransitioningDelegate: MyFadeInFadeOutTransitioning?

    init() {
        super.init(nibName: "SomeNibName", bundle: Bundle.main)

        customTransitioningDelegate = MyFadeInFadeOutTransitioning()
        transitioningDelegate = customTransitioningDelegate
        modalPresentationStyle = .custom

        if let customDelegate = customTransitioningDelegate {
            customDelegate.backgroundColorAlpha = 0.0
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // ... other methods and properties ...
}

