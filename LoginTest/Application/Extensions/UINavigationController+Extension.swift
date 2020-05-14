//
//  UINavigationController+Extension.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import UIKit

// MARK: - Transition customize methods -
extension UINavigationController {
    func pushScene(_ navigator: BaseNavigator, animated: Bool = true) {
        pushViewController(navigator.scene, animated: animated)
    }
    
    func setRootScene(_ navigator: BaseNavigator, animated: Bool = false) {
        setViewControllers([navigator.scene], animated: animated)
    }
}

