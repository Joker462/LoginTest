//
//  URLSessionProvider.swift
//  Covid19
//
//  Created by Hung Thai Minh on 3/29/20.
//  Copyright © 2020 Hung Thai Minh. All rights reserved.
//

import Foundation
import Combine

final class URLSessionProvider<EndPointProvider: EndPoint>: Provider {
    
    private var session: URLSessionProtocol
    private var task: URLSessionTask?
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request(_ endPoint: EndPointProvider, completion: @escaping (NetworkResponse) -> ()) {
        guard let request = URLRequest(endPoint: endPoint) else { return }
        // Can be log network request here
        print("URL  \(request.url!)")
        task = session.dataTask(request: request, completionHandler: { data, response, error in
            guard error == nil, let data = data else {
                completion(.failure(error!.localizedDescription))
                return
            }
            
            completion(.success(data))
        })
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
