//
//  APIHandler.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation

public
protocol APIHandler {
    func fetchData(url: URL, completion: @escaping(Result<Data, HTTPError>) -> Void)
}

public
class DefaultAPIHandler: APIHandler {
    
    public init() {}

    public func fetchData(url: URL, completion: @escaping(Result<Data, HTTPError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let `data` = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            completion(.success(data))
        }.resume()
    }
}
