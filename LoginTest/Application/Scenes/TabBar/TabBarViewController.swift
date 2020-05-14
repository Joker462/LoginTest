//
//  TabBarViewController.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/15/20.
//  Copyright (c) 2020 Hung Thai Minh. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Outlets
    
    // MARK: - Properties
    var viewModel: TabBarViewModel?
    
    // MARK: - View cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - TabBarViewOutput - 
extension TabBarViewController: TabBarViewOutput {}
