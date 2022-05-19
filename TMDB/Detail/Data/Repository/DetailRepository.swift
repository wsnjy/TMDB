//
//  DetailRepository.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation

protocol DetailRepository {
    func getDetailItem(url: URL, completion: @escaping(Result<ItemDetail, HTTPError>) -> Void)
    func getReviewMovie(url: URL, completion: @escaping(Result<ReviewResults, HTTPError>) -> Void)
}

class DefaultDetailRepository: DetailRepository {
    
    var service: Service!
    
    init(service: Service = Service()) {
        self.service = service
    }
    
    func getDetailItem(url: URL, completion: @escaping (Result<ItemDetail, HTTPError>) -> Void) {
        service.fetchRequest(type: ItemDetail.self, url: url, completion: completion)
    }
    
    func getReviewMovie(url: URL, completion: @escaping (Result<ReviewResults, HTTPError>) -> Void) {
        service.fetchRequest(type: ReviewResults.self, url: url, completion: completion)
    }
}
