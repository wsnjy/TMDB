//
//  RatingAndGenreCell.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 21/05/22.
//

import XCTest
@testable import TMDB

class RatingAndGenreCellTests: XCTestCase {

    var sut: MockRatingAndGenreCell!
    
    override func setUpWithError() throws {
        sut = MockRatingAndGenreCell()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_InputSetContent_ShouldSetContentValue() {
        // given
        let rate = true
        let genre = "comedy"
        let vote = "1011"
        
        // when
        sut.setContent(rate: rate, genre: genre, vote: vote)
        
        // then
        XCTAssertEqual(sut.rateValue, rate)
        XCTAssertEqual(sut.genreValue, genre)
        XCTAssertEqual(sut.voteValue, vote)
    }
    
}

class MockRatingAndGenreCell: RatingAndGenreCell {
    
    var rateValue: Bool = false
    var genreValue: String = ""
    var voteValue: String = ""
    
    override func setContent(rate: Bool, genre: String, vote: String) {
        rateValue = rate
        genreValue = genre
        voteValue = vote
    }
}
