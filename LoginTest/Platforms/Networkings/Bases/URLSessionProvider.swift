//
//  URLSessionProvider.swift
//  Covid19
//
//  Created by Hung Thai Minh on 3/29/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import Foundation
import RxSwift

final class URLSessionProvider<EndPointProvider: EndPoint>: Provider {
    
    private var session: URLSessionProtocol
    private var task: URLSessionTask?
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endPoint: EndPointProvider, withType: T.Type) -> Observable<T> {
        return Observable<T>.create { observer in
            guard let request = URLRequest(endPoint: endPoint) else {
                fatalError("URLRequest cannot initialize") }
            
            self.task = self.session.dataTask(request: request, completionHandler: { data, response, error in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                do {
                    let model = try JSONDecoder().decode(withType, from: data ?? Data())
                    observer.onNext(model)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            })
            self.task?.resume()
            
            return Disposables.create {
                self.task?.cancel()
            }
        }
    }
    
    func cancel() {
        task?.cancel()
    }
}
