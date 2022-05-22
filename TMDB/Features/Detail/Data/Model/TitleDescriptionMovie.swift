//
//  TitleDescriptionMovie.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 22/05/22.
//

import Foundation

struct TitleDescriptionMovie: Equatable {
    let title: String
    var description: String
    var releaseDate: String
    let genre: String
    let votes: String
    let language: String
    let reviews: String
    
    static func defaultData() -> TitleDescriptionMovie {
        return TitleDescriptionMovie(title: "", description: "", releaseDate: "", genre: "", votes: "", language: "", reviews: "")
    }
}
