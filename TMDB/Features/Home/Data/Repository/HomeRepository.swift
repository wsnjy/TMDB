//
//  HomeRepository.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import WSNetwork

protocol HomeRepository {
    func getTrendingItem(url: URL, completion: @escaping (Result<MovieResult, HTTPError>) -> Void)
    func getDiscoverItem(url: URL, completion: @escaping (Result<[Movie], HTTPError>) -> Void)
}

class RemoteHomeRepository: HomeRepository {
    
    var service: Service!
    
    init(service: Service = Service()) {
        self.service = service
    }
    
    func getTrendingItem(url: URL, completion: @escaping (Result<MovieResult, HTTPError>) -> Void) {
        service.fetchRequest(type: MovieResult.self, url: url, completion: completion)
    }
    
    func getDiscoverItem(url: URL, completion: @escaping (Result<[Movie], HTTPError>) -> Void) {
        
    }
}
