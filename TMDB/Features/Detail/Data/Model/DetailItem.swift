//
//  DetailItem.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 19/05/22.
//

import Foundation

// MARK: - DetailItemResult
struct ItemDetail: Codable, ItemTMDB {
    var title: String?
    var originalName: String?
    var originalTitle: String?
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, overview: String?
    let popularity: Double?
    let releaseDate: String?
    let revenue, runtime: Int?
    var status, tagline: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let seasons: [Season]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalName = "original_name"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case seasons
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - Season
struct Season: Codable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview, posterPath: String?
    let seasonNumber: Int?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
