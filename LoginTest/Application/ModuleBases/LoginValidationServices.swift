//
//  LoginValidationServices.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 7/6/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import Foundation
import RxSwift

final class LoginValidationServices: LoginValidationService {
    
    static let shared = LoginValidationServices()
    
    func validateEmail(_ email: String) -> Observable<ValidationResult> {
        if email.isEmpty {
            return .just(.empty)
        }
        
        func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
        
        if isValidEmail(email) {
            return .just(.ok(message: "Username available"))
        } else {
            return .just(.failed(message: "Username not correct"))
        }
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let minPasswordCount = 6
        guard password.count > 0 else {
            return .empty
        }
        
        if password.count < minPasswordCount {
            return .failed(message: "Password must be at least \(minPasswordCount) characters")
        }
        return .ok(message: "Password acceptable")
    }
}
