//
//  LoginViewModel.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright (c) 2020 Hung Thai Minh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType {
    
    struct Input {
        let email: Driver<String>
        let password: Driver<String>
        let loginTaps: Signal<Void>
    }
    
    struct Output {
        let validatedEmail: Driver<ValidationResult>
        let validatedPassword: Driver<ValidationResult>
        let login: Driver<AccountResponse>
        let loginProcessing: Driver<Bool>
        let loginEnabled: Driver<Bool>
        let loginError: Driver<Error>
    }
    
    // MARK: - Properties
    private let provider = URLSessionProvider<AccountEndPoint>()
    private let accountUserDefault = AccountUserDefault()
    private let activityIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    
    func transform(input: Input) -> Output {
        let validatedEmail = input.email
            .flatMapLatest { email in
                return LoginValidationServices.shared.validateEmail(email)
                    .asDriver(onErrorJustReturn: .failed(message: "Username not correct"))
        }
        
        let validatedPassword = input.password
            .map { password in
                return LoginValidationServices.shared.validatePassword(password)
        }
        
        let loginProcessing = activityIndicator.asDriver()
        let loginError = errorTracker.asDriver()
        
        let loginEnabled = Driver.combineLatest(
               validatedEmail,
               validatedPassword,
               loginProcessing) { username, password, loginProcessing in
                   username.isValid &&
                   password.isValid &&
                   !loginProcessing
               }
               .distinctUntilChanged()
        
        let usernameAndPassword = Driver.combineLatest(input.email, input.password) { email, password in
            return Account(email: email, password: password)
        }
        
        let login = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { account in
                return self.provider.request(.login(account), withType: AccountResponse.self)
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        return Output(validatedEmail: validatedEmail,
                      validatedPassword: validatedPassword,
                      login: login,
                      loginProcessing: loginProcessing,
                      loginEnabled: loginEnabled,
                      loginError: loginError)
    }
}
