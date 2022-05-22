//
//  CastCellTests.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 21/05/22.
//

import XCTest
@testable import TMDB

class CastCellTests: XCTestCase {

    var sut: CastCellSpy!
    
    override func setUpWithError() throws {
        sut = CastCellSpy()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_FirstLoad_ShouldShowDefaultValue() {
        XCTAssertEqual(sut.layoutSubviewsCallCount, 0)
        XCTAssertEqual(sut.setupViewsCallCount, 0)
    }
    
    func test_FunctionCalled_ShouldShowIncreamentValue() {
        // when
        sut.layoutSubviews()
        sut.setupViews()
        
        // then
        XCTAssertEqual(sut.layoutSubviewsCallCount, 1)
        XCTAssertEqual(sut.setupViewsCallCount, 1)
    }

}

class CastCellSpy: CastCell {
    
    var layoutSubviewsCallCount = 0
    var setupViewsCallCount = 0

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubviewsCallCount = 1
    }
    
    override func setupViews() {
        super.setupViews()
        setupViewsCallCount = 1
    }
}
