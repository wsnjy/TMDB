//
//  ResponseHandler.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation

public protocol ResponseHandler {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: @escaping(Result<T, HTTPError>) -> Void)
}

public class DefaultResponseHandler: ResponseHandler {
    
    public init() {}
    
    public func fetchModel<T: Codable>(type: T.Type, data: Data, completion: @escaping(Result<T, HTTPError>) -> Void) {
       
        let response = try? JSONDecoder().decode(type.self, from: data)
        
        if let `response` = response {
            completion(.success(response))
        } else {
            completion(.failure(.parsingFailed))
        }
    }
}
