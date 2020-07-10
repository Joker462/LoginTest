//
//  Provider.swift
//  Covid19
//
//  Created by Hung Thai Minh on 3/28/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import Foundation
import RxSwift

protocol Provider {
    associatedtype EndPointProvider: EndPoint
    func request<T: Decodable>(_ endPoint: EndPointProvider, withType: T.Type) -> Observable<T>
    func cancel()
}
