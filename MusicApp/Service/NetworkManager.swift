//
//  NetworkManager.swift
//  MusicApp
//
//  Created by Semih Özsoy on 17.08.2021.
//

import UIKit
import Alamofire

public class NetworkManager<EndpointItem:Endpoint> {
    
    public init() {}

    public func request<T:Codable>(endpoint:EndpointItem,type:T.Type,completion:@escaping (Result<T,Error>) -> Void){
        AF.request(endpoint.mainUrl, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: endpoint.headers)
            .validate()
            .response { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decodedObject = try JSONDecoder().decode(type.self, from: data!)
                        completion(.success(decodedObject))
                    } catch let decodingError as NSError {
                        completion(.failure(decodingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

