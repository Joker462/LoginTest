//
//  Account.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import Foundation

struct Account: Encodable {
    let email: String
    let password: String
    
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

struct AccountStore: Codable {
    let id: Int
    let email: String
    let access_token: String
    var password: String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case id, email, access_token, password
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        email = try values.decode(String.self, forKey: .email)
        access_token = try values.decode(String.self, forKey: .access_token)
        let passString = try? values.decode(String.self, forKey: .password)
        password = passString ?? ""
    }
    
}

extension AccountStore: Parsable {
    init(dict: [String : Any]) throws {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
        let result = try JSONDecoder().decode(AccountStore.self, from: jsonData)
        self = result
    }
}

struct AccountResponse: Decodable {
    let result: Bool
    let message: String
    let data: [String: Any]
    
    enum CodingKeys: String, CodingKey {
        case result, message, data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decode(Bool.self, forKey: .result)
        message = try values.decode(String.self, forKey: .message)
        data = try values.decode([String: Any].self, forKey: .data)
    }
}

public protocol Parsable: Decodable {
    init(dict: [String: Any]) throws
}
