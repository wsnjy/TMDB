//
//  ReviewCellTests.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 21/05/22.
//

import XCTest
@testable import TMDB

class ReviewCellTests: XCTestCase {
    
    var sut: ReviewCell!
    
    override func setUpWithError() throws {
        sut = ReviewCell()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_FirstLoad_ShouldShowDefaultValue() {
        
        // when
        sut.layoutIfNeeded()
        
        // then
        XCTAssertNotNil(sut.imageUser)
        XCTAssertNotNil(sut.nameLabel)
        XCTAssertNotNil(sut.commentLabel)
    }
    
    func test_ContentImageURLInvalid_ShowDefaultValue() {
        sut.setContent(imageURL: nil, name: "", comment: "")
        
        // then
        if let textName = sut.nameLabel.text {
            XCTAssertEqual(textName, "")
        }
        
        if let textComment = sut.commentLabel.text {
            XCTAssertEqual(textComment, "")
        }
    }
    
    func test_SetContent_ShowContentCell() {
        // given
        let name = "name"
        let comment = "comment"
        
        // when
        sut.setContent(imageURL: "", name: name, comment: comment)
        
        // then
        if let textName = sut.nameLabel.text {
            XCTAssertEqual(textName, name)
        }
        
        if let textComment = sut.commentLabel.text {
            XCTAssertEqual(textComment, comment)
        }
    }
    
    func test_GetNameInputNil_ShouldShowDefaultValue() {
        // when
        let value = sut.getName(value: nil)
        
        XCTAssertEqual(value, "Unamed")
    }
    
    func test_GetNameInputValue_ShouldGetRightValue() {
        // given
        let name = "mark"
        // when
        let value = sut.getName(value: name)
        
        XCTAssertEqual(value, name)
    }


}
