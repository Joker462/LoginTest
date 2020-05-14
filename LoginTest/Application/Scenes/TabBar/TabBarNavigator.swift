//
//  TabBarNavigator.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/15/20.
//  Copyright (c) 2020 Hung Thai Minh. All rights reserved.
//

import UIKit

final class TabBarNavigator: BaseNavigator {
    
    // MARK: - Construction
    init() {
        let scene = TabBarViewController.instantiateFromStoryboard(storyboardName: "Main")
        super.init(scene)
        
        scene.viewModel = TabBarViewModel(navigator: self, output: scene)
    }
}

// MARK: - Navigate -
extension TabBarNavigator: Navigate {
    enum NavigateOption {}
    
    func navigate(option: NavigateOption) {}
}
