//
//  LoginNavigator.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright (c) 2020 Hung Thai Minh. All rights reserved.
//

import UIKit

final class LoginNavigator: BaseNavigator {
    
    // MARK: - Construction
    init() {
        let scene = LoginViewController.instantiateFromStoryboard(storyboardName: "Main")
        super.init(scene)
        
        scene.viewModel = LoginViewModel(navigator: self, output: scene)
    }
}

// MARK: - Navigate -
extension LoginNavigator: Navigate {
    enum NavigateOption {
        case alert(String)
        case tabBarScene
    }
    
    func navigate(option: NavigateOption) {
        switch option {
        case .alert(let message):
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            scene.present(alertController, animated: true)
        case .tabBarScene:
            scene.present(TabBarNavigator().scene, animated: true)
        }
    }
}
