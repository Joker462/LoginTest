//
//  ViewModelType.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 6/29/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

let email = "phule@gmail.com"
let password = "123456"

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

enum LoginState {
    case login(loginState: Bool)
}

protocol LoginValidationService {
    func validateEmail(_ email: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
}
