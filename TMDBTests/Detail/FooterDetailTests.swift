//
//  FooterDetailTests.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 21/05/22.
//

import XCTest
@testable import TMDB

class FooterDetailTests: XCTestCase {
    
    var sut: FooterDetailSpy!
    
    override func setUpWithError() throws {
        sut = FooterDetailSpy()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_FirstLoad_ShouldShowDefaultValue() {
        XCTAssertEqual(sut.didTapButtonCount, 0)
    }
    
    func test_DidTapButtonCalled_ShouldShowIncreamentValue() {
        // when
        sut.didTapButton()
        
        // then
        XCTAssertEqual(sut.didTapButtonCount, 1)
    }

}

class FooterDetailSpy: FooterDetail {
    
    var didTapButtonCount = 0
    
    override func didTapButton() {
        didTapButtonCount += 1
    }
}
