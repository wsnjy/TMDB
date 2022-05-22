//
//  ContentCollectionViewCellTests.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 21/05/22.
//

import XCTest
@testable import TMDB

class ContentCollectionViewCellTests: XCTestCase {

    var sut: MockContentCollectionViewCell!
    
    override func setUpWithError() throws {
        sut = MockContentCollectionViewCell()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_FirstLoad_URLIsNil() {
        
        // then
        XCTAssertNil(sut.url)
    }
    
    func test_SetConfigURL_ShouldSetURL() {
        // given
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let urlString = "/C1ntAk0e"
        
        // when
        sut.config(url: urlString)
        
        // then
        XCTAssertEqual(sut.url, URL(string: "\(baseURL)\(urlString)"))
    }
}


class MockContentCollectionViewCell: ContentCollectionViewCellInput {
    var url: URL!
    
    func config(url: String) {
        guard let url = URL(string: "\(Base.URLImage)\(url)") else {
            return
        }
        
        self.url = url
    }
}
