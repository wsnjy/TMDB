//
//  HomeUseCase.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import WSNetwork
import RxSwift

protocol HomeUsecase {
    func getTrendingItem(url: URL) -> Observable<MovieResult>
}

class DefaultHomeUsecase: HomeUsecase {
    
    var repository: HomeRepository!
    
    init(repository: HomeRepository = RemoteHomeRepository()) {
        self.repository = repository
    }
    
    func getTrendingItem(url: URL) -> Observable<MovieResult> {
        return repository.getTrendingItem(url: url)
    }    
}
