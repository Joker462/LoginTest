//
//  TabBarViewModel.swift
//  LoginTest
//
//  Created by Hung Thai Minh on 5/15/20.
//  Copyright (c) 2020 Hung Thai Minh. All rights reserved.
//

import Foundation

// MARK: - Input -
protocol TabBarViewInput {}

// MARK: - Output -
protocol TabBarViewOutput: class {}

final class TabBarViewModel: TabBarViewInput {
    
    // MARK: - Output protocol
    weak var output: TabBarViewOutput?
    
    // MARK: - Properties
    fileprivate let navigator: TabBarNavigator
    
    // MARK: - Construction
    init(navigator: TabBarNavigator, output: TabBarViewOutput) {
        self.navigator = navigator
        self.output = output
    }
}
