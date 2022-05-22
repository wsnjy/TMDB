//
//  MockDetail.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 22/05/22.
//

import Foundation
@testable import TMDB
import WSNetwork

extension Movie {
    
    static func dummyData() -> Movie {
        return Movie(title: "title", originalName: "title", originalTitle: "title", posterPath: "", adult: false, overview: "", releaseDate: "", id: 0, originalLanguage: "", backdropPath: "", popularity: 0, voteCount: 0, video: false, voteAverage: 0)
    }
}

class MockDetailRepository: DetailRepository {
    
    var isSuccess = true
    
    func getDetailItem(url: URL, completion: @escaping (Result<ItemDetail, HTTPError>) -> Void) {
        if isSuccess {
            completion(.success(ItemDetail.mockItemDetail()))
        } else {
            completion(.failure(.noData))
        }
    }
    
    func getReviewItem(url: URL, completion: @escaping (Result<ReviewResults, HTTPError>) -> Void) {
        if isSuccess {
            completion(.success(ReviewResults.mockReviewResults()))
        } else {
            completion(.failure(.noData))
        }
    }
    
    func getCredits(url: URL, completion: @escaping (Result<CreditResult, HTTPError>) -> Void) {
        if isSuccess {
            completion(.success(CreditResult.mockCreditResults()))
        } else {
            completion(.failure(.noData))
        }
    }
}

extension ItemDetail {
    
    static func mockItemDetail() -> ItemDetail {
        return ItemDetail(title: "Game of Thrones", originalName: "Game of Thrones", originalTitle: "Game of Thrones", adult: false, backdropPath: nil, budget: nil, genres: [], homepage: nil, id: nil, imdbID: nil, originalLanguage: nil, overview: nil, popularity: nil, releaseDate: nil, revenue: nil, runtime: nil, status: nil, tagline: nil, video: nil, voteAverage: nil, voteCount: nil, seasons: nil)
    }
}

extension ReviewResults {
    
    static func mockReviewResults() -> ReviewResults {
        return ReviewResults(id: 0, page: 0, results: [
            Review(author: "west", authorDetails: nil, content: "", createdAt: "", id: "", updatedAt: "", url: "")
        ], totalPages: 1, totalResults: 99)
    }
}

extension CreditResult {
    
    static func mockCreditResults() -> CreditResult {
        return CreditResult(id: 0, cast: [
            Cast(name: "west", originalName: "borland", profilePath: "", character: "")
        ], crew: [])
    }
}
