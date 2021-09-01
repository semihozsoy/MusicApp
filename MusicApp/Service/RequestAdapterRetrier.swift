//
//  RequestAdapterRetrier.swift
//  MusicApp
//
//  Created by Semih Özsoy on 23.08.2021.
//

import UIKit
import Alamofire


protocol AccessTokenStorage:class {
    typealias JWT = String
    var accessToken: JWT {get set}
}

class RequestInterceptor: Alamofire.RequestInterceptor {
    
    private let storage: AccessTokenStorage
    init(storage:AccessTokenStorage) {
        self.storage = storage
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("") == true else {
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest
        let token = UserDefaults.standard.string(forKey: "MusicUserToken") ?? ""
        urlRequest.setValue("Bearer \(token)" , forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
   
}
