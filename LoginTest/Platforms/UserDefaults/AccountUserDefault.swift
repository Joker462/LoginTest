//
//  AccountUserDefault.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/14/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import Foundation

final class AccountUserDefault {
    
    let ACCOUNT_KEY = "SAVEDACCOUNT"
    
    func save(_ account: AccountStore) {
        guard let encoded = try? JSONEncoder().encode(account) else { return }
        UserDefaults.standard.set(encoded, forKey: ACCOUNT_KEY)
        UserDefaults.standard.synchronize()
    }
    
    func getAccount() -> AccountStore? {
        guard let data = UserDefaults.standard.object(forKey: ACCOUNT_KEY) as? Data else { return nil }
        return try? JSONDecoder().decode(AccountStore.self, from: data)
    }
}
