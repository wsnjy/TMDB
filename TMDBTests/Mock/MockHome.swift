//
//  MockHome.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 22/05/22.
//

import Foundation
@testable import TMDB
import WSNetwork

class MockHomeRepository: HomeRepository {
    
    var isSuccess = true
    
    func getTrendingItem(url: URL, completion: @escaping (Result<MovieResult, HTTPError>) -> Void) {
        if isSuccess {
            completion(.success(MovieResult.mockMovieResult()))
        } else {
            completion(.failure(.noData))
        }
    }
    
    func getDiscoverItem(url: URL, completion: @escaping (Result<[Movie], HTTPError>) -> Void) {
        if isSuccess {
            completion(.success([Movie.dummyData()]))
        } else {
            completion(.failure(.noData))
        }
    }
}

extension MovieResult {
    
    static func mockMovieResult() -> MovieResult {
        return MovieResult(page: 0, results: [
            Movie.dummyData()
        ], totalResults: 0, totalPages: 0)
    }
}
