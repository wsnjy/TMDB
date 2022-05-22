//
//  Credits.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 20/05/22.
//

import Foundation

// MARK: - CreditResult
struct CreditResult: Codable {
    let id: Int
    let cast, crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let name, originalName: String
    let profilePath: String?
    let character: String?

    enum CodingKeys: String, CodingKey {
        case name
        case originalName = "original_name"
        case profilePath = "profile_path"
        case character
    }
    
    static func defaultdata() -> Cast {
        Cast(name: "No Data", originalName: "", profilePath: "placeholder", character: "")
    }
}
