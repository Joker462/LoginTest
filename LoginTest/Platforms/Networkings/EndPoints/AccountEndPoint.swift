//
//  AccountEndPoint.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import Foundation


enum AccountEndPoint {
    case login(Account)
}

extension AccountEndPoint: EndPoint {
    var baseURL: URL {
        guard let url = URL(string: "http://yelp-test.kennjdemo.com/api/v1/user") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return "/login"
    }
    
    var method: Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .login(let account):
            let parameters = account.toDictionary ?? [:]
            return .requestParameters(parameters)
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
