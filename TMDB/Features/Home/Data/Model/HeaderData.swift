//
//  HeaderData.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 22/05/22.
//

import Foundation

struct HeaderData: Equatable {
    var imagePath: String
    var title: String
    
    static func defaultData() -> HeaderData {
        return HeaderData(imagePath: "", title: "")
    }
}
