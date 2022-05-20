//
//  DetailUseCase.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit
import WSNetwork

protocol DetailUseCase {
    func getDetailItem(url: URL, completion: @escaping(Result<ItemDetail, HTTPError>) -> Void)
    func getReviewItem(url: URL, completion: @escaping(Result<ReviewResults, HTTPError>) -> Void)
    func getCredits(url: URL, completion: @escaping (Result<CreditResult, HTTPError>) -> Void)
}

class DefaultDetailUseCase: DetailUseCase {
    
    var repository: DetailRepository!
    
    init(repository: DetailRepository = DefaultDetailRepository()) {
        self.repository = repository
    }
    
    func getDetailItem(url: URL, completion: @escaping (Result<ItemDetail, HTTPError>) -> Void) {
        repository.getDetailItem(url: url, completion: completion)
    }

    func getReviewItem(url: URL, completion: @escaping (Result<ReviewResults, HTTPError>) -> Void) {
        repository.getReviewItem(url: url, completion: completion)
    }
    
    func getCredits(url: URL, completion: @escaping (Result<CreditResult, HTTPError>) -> Void) {
        repository.getCredits(url: url, completion: completion)
    }
}
