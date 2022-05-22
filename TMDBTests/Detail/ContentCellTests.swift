//
//  ContentCellTests.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 21/05/22.
//

import XCTest
@testable import TMDB

class ContentCellTests: XCTestCase {

    var sut: ContentCell!

    override func setUpWithError() throws {
        sut = ContentCell()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_FirstLoad_LabelIsNotNil() {
        
        // then
        XCTAssertNotNil(sut.textLabel)
        XCTAssertNotNil(sut.detailTextLabel)
    }
    
    func test_SetupContent_ShouldSetTextLabel() {
        // given
        let description = "desc"
                
        // when
        sut.setupContent(description: description)
        
        // then
        XCTAssertEqual(sut.descriptionLabel.text, description)
    }
}
