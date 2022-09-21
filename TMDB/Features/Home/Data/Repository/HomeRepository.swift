//
//  HomeRepository.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import WSNetwork
import Combine

protocol HomeRepository {
    func getTrendingItem(url: URL) -> AnyPublisher<MovieResult, Error>
}

class RemoteHomeRepository: HomeRepository {
    
    var service: Service!
    
    init(service: Service = Service()) {
        self.service = service
    }
    
    func getTrendingItem(url: URL) -> AnyPublisher<MovieResult, Error> {
        return Future<MovieResult, Error> { completion in
            self.service.fetchRequest(type: MovieResult.self, url: url) { result in
                switch result {
                case .success(let value):
                    completion(.success(value))
                case .failure:
                    completion(.failure(HTTPError.requestError))
                }
            }
        }.eraseToAnyPublisher()
    }
}
