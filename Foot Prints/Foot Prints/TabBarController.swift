//
//  TabBarController.swift
//  Foot Prints
//
//  Created by Nelson Pierce on 5/15/23.
//

import UIKit
import MapKit

class TabBarController: UITabBarController {

    enum Tab: Int {
        case map
        case add
        case account
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func navigate(to location: CLLocationCoordinate2D) {
        let tab = Tab.map.rawValue
        selectedIndex = tab
        let vc = viewControllers?[tab] as? MapViewController
        vc?.zoomToLatestLocation(with: location)
    }

}
