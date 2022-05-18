//
//  DetailRepository.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation

protocol DetailRepository {
    func getReviewMovie(url: URL, completion: @escaping(Result<ReviewResults, HTTPError>) -> Void)
}

class DefaultDetailRepository: DetailRepository {
    var service: Service!
    
    init(service: Service = Service()) {
        self.service = service
    }
    
    func getReviewMovie(url: URL, completion: @escaping (Result<ReviewResults, HTTPError>) -> Void) {
        service.fetchRequest(type: ReviewResults.self, url: url, completion: completion)
    }
}
