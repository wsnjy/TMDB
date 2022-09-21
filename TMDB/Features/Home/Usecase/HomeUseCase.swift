//
//  HomeUseCase.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import WSNetwork
import Combine

protocol HomeUsecase {
    func getTrendingItem(url: URL) -> AnyPublisher<MovieResult, Error>
}

class DefaultHomeUsecase: HomeUsecase {
    
    var repository: HomeRepository!
    
    init(repository: HomeRepository = RemoteHomeRepository()) {
        self.repository = repository
    }
    
    func getTrendingItem(url: URL) -> AnyPublisher<MovieResult, Error> {
        return repository.getTrendingItem(url: url)
    }
}
