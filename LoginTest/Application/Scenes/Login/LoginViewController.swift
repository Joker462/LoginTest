//
//  LoginViewController.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright (c) 2020 Hung Thai Minh. All rights reserved.
//

import UIKit
import RxSwift

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var emailValidationLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordValidationLabel: UILabel!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loadingView: UIView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = LoginViewModel()
    
    // MARK: - View cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingViewModel()
       
    }
    
    private func bindingViewModel() {
        let input = LoginViewModel.Input(email: emailTextField.rx.text.orEmpty.asDriver(),
                                         password: passwordTextField.rx.text.orEmpty.asDriver(),
                                         loginTaps: loginButton.rx.tap.asSignal())
        
        let output = viewModel.transform(input: input)
    
        output.loginEnabled
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.validatedEmail
            .drive(emailValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
    
        output.validatedPassword
            .drive(passwordValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        output.loginProcessing
            .drive(onNext: { isLoading in
                self.loadingView.isHidden = !isLoading
            })
        .disposed(by: disposeBag)
        
        output.loginError
            .drive(onNext: { error in
                print(error.localizedDescription)
            })
        .disposed(by: disposeBag)
        
        output.login
            .drive(onNext: { _ in
                self.performSegue(withIdentifier: "showTabBar", sender: nil)
            })
        .disposed(by: disposeBag)
    }
}
