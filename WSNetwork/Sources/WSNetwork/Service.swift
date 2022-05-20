//
//  Service.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation

public
class Service {
    
    var apiHandler: APIHandler!
    var responseHandler: ResponseHandler!
    
    public init(apiHandler: APIHandler = DefaultAPIHandler(),
         responseHandler: ResponseHandler = DefaultResponseHandler()) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }
    
    public func fetchRequest<T: Codable>(type: T.Type, url: URL, completion: @escaping(Result<T, HTTPError>) -> Void) {
        
        apiHandler.fetchData(url: url) { result in
            
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { result in
                    switch result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure:
                        completion(.failure(.noData))
                    }
                }
            case .failure:
                completion(.failure(.requestError))
            }
        }
    }
}
