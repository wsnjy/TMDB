//
//  DetailRepository.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import WSNetwork

protocol DetailRepository {
    func getDetailItem(url: URL, completion: @escaping(Result<ItemDetail, HTTPError>) -> Void)
    func getReviewItem(url: URL, completion: @escaping(Result<ReviewResults, HTTPError>) -> Void)
    func getCredits(url: URL, completion: @escaping (Result<CreditResult, HTTPError>) -> Void)
}

public
class DefaultDetailRepository: DetailRepository {
    
    var service: Service!
    
    init(service: Service = Service()) {
        self.service = service
    }
    
    func getDetailItem(url: URL, completion: @escaping (Result<ItemDetail, HTTPError>) -> Void) {
        service.fetchRequest(type: ItemDetail.self, url: url, completion: completion)
    }
    
    func getReviewItem(url: URL, completion: @escaping (Result<ReviewResults, HTTPError>) -> Void) {
        service.fetchRequest(type: ReviewResults.self, url: url, completion: completion)
    }
    
    func getCredits(url: URL, completion: @escaping (Result<CreditResult, HTTPError>) -> Void) {
        service.fetchRequest(type: CreditResult.self, url: url, completion: completion)
    }
}
