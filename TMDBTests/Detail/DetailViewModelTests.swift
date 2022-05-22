//
//  DetailViewModelTests.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 21/05/22.
//

import XCTest
@testable import TMDB
import WSNetwork

class DetailViewModelTests: XCTestCase {

    var sut: DefaultDetailViewModel!

    override func setUpWithError() throws {
        sut = DefaultDetailViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testDidLoad_FirstTimeLoad_ValueIsDefault() {
        // when
        sut.viewDidLoad()
        
        // then
        XCTAssertEqual(sut.contentDetail.value, TitleDescriptionMovie.defaultData())
        XCTAssertTrue(sut.reviews.value.isEmpty)
        XCTAssertTrue(sut.credits.value.isEmpty)
        XCTAssertEqual(sut.headerData.value, HeaderData.defaultData())
    }
    
    func testType_WhenIsSetMovie_ItemTypeSetMovie() {
        // when
        sut.setType(item: .movie)
        
        // then
        XCTAssertEqual(sut.itemType, ItemType.movie)
    }

    func testType_WhenIsSetTV_ItemTypeSetTV() {
        // when
        sut.setType(item: .tv)
        
        // then
        XCTAssertEqual(sut.itemType, ItemType.tv)
    }

    func testItemID_WhenSetItemIDNil_ItemIDSetIsEmpty() {
        sut.set(itemID: nil)
        
        XCTAssertTrue(sut.itemID.isEmpty)
    }
    
    func testItemID_WhenSetItemIDValid_ItemIDSet() {
        // given
        let input = 99

        // when
        sut.set(itemID: input)
        
        // then
        XCTAssertFalse(sut.itemID.isEmpty)
        XCTAssertEqual(sut.itemID, String(input))
    }
    
    func test_HeaderData_WhenSetMovie_HeaderDataSet() {
        // given
        let dummy = Movie.dummyData()
        let headerData = HeaderData(imagePath: "", title: "title")
        
        // when
        sut.set(movie: dummy)
        
        // then
        XCTAssertEqual(sut.headerData.value, headerData)
    }
    
    func test_getDetailMovieSuccess_shouldGetDetailData() {
        // given
        let repository = MockDetailRepository()
        repository.isSuccess = true
        let useCase = DefaultDetailUseCase(repository: repository)
        sut = DefaultDetailViewModel(useCase: useCase)
        
        // when
        sut.getDetailMovie()
        
        // then
        XCTAssertEqual(sut.contentDetail.value.title, "Game of Thrones")
    }
    
    func test_getDetailMovieError_shouldGetShowError() {
        // given
        let repository = MockDetailRepository()
        repository.isSuccess = false
        let useCase = DefaultDetailUseCase(repository: repository)
        sut = DefaultDetailViewModel(useCase: useCase)
        
        // when
        sut.getDetailMovie()
        
        // then
        XCTAssertEqual(sut.contentDetail.value, TitleDescriptionMovie.defaultData())
    }
    
    func test_getDetailReviewSuccess_shouldGetReviewData() {
        // given
        let repository = MockDetailRepository()
        repository.isSuccess = true
        let useCase = DefaultDetailUseCase(repository: repository)
        sut = DefaultDetailViewModel(useCase: useCase)
        
        // when
        sut.getDataReview()
        
        // then
        XCTAssertEqual(sut.reviews.value.count, 1)
    }
    
    func test_getDetailReviewError_shouldShowError() {
        // given
        let repository = MockDetailRepository()
        repository.isSuccess = false
        let useCase = DefaultDetailUseCase(repository: repository)
        sut = DefaultDetailViewModel(useCase: useCase)
        
        // when
        sut.getDataReview()
        
        // then
        XCTAssertEqual(sut.reviews.value.count, 0)
    }
    
    func test_getDataActorsSuccess_shouldShowDataActor() {
        // given
        let repository = MockDetailRepository()
        repository.isSuccess = true
        let useCase = DefaultDetailUseCase(repository: repository)
        sut = DefaultDetailViewModel(useCase: useCase)
        
        // when
        sut.getDataActors()
        
        // then
        XCTAssertEqual(sut.credits.value.count, 1)
    }
    
    func test_getDataActorError_shouldShowError() {
        // given
        let repository = MockDetailRepository()
        repository.isSuccess = false
        let useCase = DefaultDetailUseCase(repository: repository)
        sut = DefaultDetailViewModel(useCase: useCase)
        
        // when
        sut.getDataActors()
        
        // then
        XCTAssertEqual(sut.credits.value.count, 0)
    }
}
