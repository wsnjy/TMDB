//
//  TagViewTests.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 21/05/22.
//

import XCTest
@testable import TMDB

class TagViewTests: XCTestCase {

    var sut: TagView!
    
    override func setUpWithError() throws {
        sut = TagView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_FirstLoad_ShouldEmptyLabelAndNotNil() {
        // when
        sut.setupViews()
        
        // then
        XCTAssertNotNil(sut.label)
        
        if let textLabel = sut.label.text {
            XCTAssertTrue(textLabel.isEmpty)
        }
    }
    
    func test_SetLabelText_LabelIsNotEmptyAndMatch() {
        // given
        let text = "this is the text for testing"
        
        // when
        sut.setLabel(text: text)
        
        // then
        if let textLabel = sut.label.text {
            XCTAssertFalse(textLabel.isEmpty)
            XCTAssertEqual(textLabel, text)
        }
    }
}
