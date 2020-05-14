//
//  UIViewController+Extension.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import UIKit

// MARK: - Initializations -
public extension UIViewController {
    
    /// Instantiate controller from defaut storyboard 'Main'
    ///
    /// - Returns: View controller
    class func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: "Main")
    }
    
    
    /// Instantiate controller from storyboard name
    ///
    /// - Parameter storyboardName: name of storyboard
    /// - Returns: view controller
    class func instantiateFromStoryboard(storyboardName: String) -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: storyboardName)
    }
    
    /// Instantiate controller from storyboard
    ///
    /// - Parameter storyboard: storyboard contain self
    /// - Returns: view controller
    class func instantiateFromStoryboard(storyboard: UIStoryboard) -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboard: storyboard)
    }
    
    /// Instantiate controller from xib
    ///
    /// - Parameter nibBundleOrNil: bundle contain xib file
    /// - Returns: view controller
    class func instantiateFromNib(bundle nibBundleOrNil: Bundle?) -> Self {
        return self.init(nibName: self.identifier, bundle: nibBundleOrNil)
    }
}

// MARK: - Private extension -
private extension UIViewController {
    class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Not find view controller have identifier \(T.identifier)")
        }
        return controller
    }
    
    class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboard: UIStoryboard) -> T where T: UIViewController {
        guard let controller = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Not find view controller have identifier \(T.identifier)")
        }
        return controller
    }
}

