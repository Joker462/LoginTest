//
//  LoginViewController.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright (c) 2020 Hung Thai Minh. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loadingView: UIView!
    
    // MARK: - Properties
    var viewModel: LoginViewModel?
    
    // MARK: - View cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - Events
    @IBAction
    private func loginButtonClicked() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel?.loginButtonClicked(email, password)
    }
}

// MARK: - LoginViewOutput - 
extension LoginViewController: LoginViewOutput {
    func showView(isLoading: Bool) {
        loadingView.isHidden = !isLoading
    }
}
