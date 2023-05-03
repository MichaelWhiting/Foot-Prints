//
//  TabBarModifications.swift
//  Foot Prints
//
//  Created by Michael Whiting on 5/3/23.
//

import Foundation
import UIKit

import UIKit

class CustomTabBar: UITabBar {
    var height: CGFloat = 100

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
}

