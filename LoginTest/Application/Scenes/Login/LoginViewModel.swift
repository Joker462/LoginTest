//
//  LoginViewModel.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright (c) 2020 Hung Thai Minh. All rights reserved.
//

import Foundation

// MARK: - Input -
protocol LoginViewInput {
    // View cycles
    func viewDidLoad()
    
    // Events
    func loginButtonClicked(_ email: String, _ password: String)
}

// MARK: - Output -
protocol LoginViewOutput: class {
    func showView(isLoading: Bool)
}

final class LoginViewModel: LoginViewInput {
    
    // MARK: - Output protocol
    weak var output: LoginViewOutput?
    
    // MARK: - Properties
    fileprivate let navigator: LoginNavigator
    fileprivate let provider = URLSessionProvider<AccountEndPoint>()
    fileprivate let accountUserDefault = AccountUserDefault()
    
    // MARK: - Construction
    init(navigator: LoginNavigator, output: LoginViewOutput) {
        self.navigator = navigator
        self.output = output
    }
    
    // MARK: - View cycles
    func viewDidLoad() {
        if let accountStore = accountUserDefault.getAccount() {
            let account = Account(email: accountStore.email, password: accountStore.password)
            requestLogin(account)
        } else {
            output?.showView(isLoading: false)
        }
    }
    
    // MARK: - Events
    func loginButtonClicked(_ email: String, _ password: String) {
        if email.isEmpty {
            navigator.navigate(option: .alert("Please input your email"))
        } else if password.isEmpty {
            navigator.navigate(option: .alert("Please input your password"))
        } else {
            let account = Account(email: email, password: password)
            requestLogin(account)
        }
    }
}

// MARK: - Private methods
private extension LoginViewModel {
    func requestLogin(_ account: Account) {
        output?.showView(isLoading: true)
        provider.request(.login(account)) { (response) in
            DispatchQueue.main.async {
                self.output?.showView(isLoading: false)
                switch response {
                case .success(let data):
                    do {
                    let accountResponse = try JSONDecoder().decode(AccountResponse.self, from: data)
                        if accountResponse.result {
                            var accountStore = try AccountStore(dict: accountResponse.data)
                            accountStore.password = account.password
                            self.accountUserDefault.save(accountStore)
                            self.navigator.navigate(option: .tabBarScene)
                        } else {
                            self.navigator.navigate(option: .alert(accountResponse.message))
                        }
                    } catch {
                        self.navigator.navigate(option: .alert(error.localizedDescription))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
