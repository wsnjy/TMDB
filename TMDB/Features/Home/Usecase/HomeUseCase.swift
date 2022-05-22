//
//  HomeUseCase.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import WSNetwork

protocol HomeUsecase {
    func getTrendingItem(url: URL, completion: @escaping (Result<MovieResult, HTTPError>) -> Void)
    func getDiscoverItem(url: URL, completion: @escaping (Result<[Movie], HTTPError>) -> Void)
}

class DefaultHomeUsecase: HomeUsecase {
    
    var repository: HomeRepository!
    
    init(repository: HomeRepository = RemoteHomeRepository()) {
        self.repository = repository
    }
    
    func getTrendingItem(url: URL, completion: @escaping (Result<MovieResult, HTTPError>) -> Void) {
        repository.getTrendingItem(url: url, completion: completion)
    }
    
    func getDiscoverItem(url: URL, completion: @escaping (Result<[Movie], HTTPError>) -> Void) {
    }
}
