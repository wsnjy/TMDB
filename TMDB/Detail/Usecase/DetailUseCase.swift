//
//  DetailUseCase.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import UIKit

protocol DetailUseCase {
    func getDetailItem(url: URL, completion: @escaping(Result<ItemDetail, HTTPError>) -> Void)
    func getReviewMovie(url: URL, completion: @escaping(Result<ReviewResults, HTTPError>) -> Void)
}

class DefaultDetailUseCase: DetailUseCase {
    
    var repository: DetailRepository!
    
    init(repository: DetailRepository = DefaultDetailRepository()) {
        self.repository = repository
    }
    
    func getDetailItem(url: URL, completion: @escaping (Result<ItemDetail, HTTPError>) -> Void) {
        repository.getDetailItem(url: url, completion: completion)
    }

    func getReviewMovie(url: URL, completion: @escaping (Result<ReviewResults, HTTPError>) -> Void) {
        repository.getReviewMovie(url: url, completion: completion)
    }
}
