//
//  HTTPError.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation

public
enum HTTPError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
}
