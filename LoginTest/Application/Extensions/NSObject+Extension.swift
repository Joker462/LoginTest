//
//  NSObject+Extension.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import Foundation

extension NSObject {
    
    class var identifier: String {
        let components = String(describing: self).components(separatedBy: ".")
        return components.count > 1 ? components.last! : components.first!
    }
}
