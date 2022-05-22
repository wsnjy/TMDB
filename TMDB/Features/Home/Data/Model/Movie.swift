//
//  Movie.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation

protocol ItemTMDB {
    var title: String? { get set }
    var originalName: String? { get set }
    var originalTitle: String? { get set }
}

struct MovieResult: Codable {
    let page: Int
    let results: [Movie]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Codable, ItemTMDB {
    var title: String?
    var originalName: String?
    var originalTitle: String?
    let posterPath: String?
    let adult: Bool?
    let overview, releaseDate: String?
    let id: Int?
    let originalLanguage: String?
    var backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case id
        case originalName = "original_name"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}
