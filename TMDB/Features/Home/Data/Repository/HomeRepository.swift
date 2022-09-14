//
//  HomeRepository.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import WSNetwork
import RxSwift

protocol HomeRepository {
    func getTrendingItem(url: URL) -> Observable<MovieResult>
}

class RemoteHomeRepository: HomeRepository {
    
    var service: Service!
    
    init(service: Service = Service()) {
        self.service = service
    }
    
    func getTrendingItem(url: URL) -> Observable<MovieResult> {
        return Observable<MovieResult>.create { observer in
            self.service.fetchRequest(type: MovieResult.self, url: url) { result in
                switch result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure:
                    observer.onError(HTTPError.requestError)
                }
            }
            
            return Disposables.create()
        }
    }
}
