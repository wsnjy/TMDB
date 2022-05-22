//
//  HomeViewModelTests.swift
//  TMDBTests
//
//  Created by Wisnu Sanjaya on 22/05/22.
//

import XCTest
@testable import TMDB
import WSNetwork

class HomeViewModelTests: XCTestCase {

    var sut: DefaultHomeViewModel!
    
    override func setUpWithError() throws {
        sut = DefaultHomeViewModel()
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_getTrendingSuccess_shoudlShowData() {
        let repository = MockHomeRepository()
        let useCase = DefaultHomeUsecase(repository: repository)
        sut = DefaultHomeViewModel(useCase: useCase)
        
        sut.getDataItem(type: .movie)
        
        XCTAssertEqual(sut.homeState.value, HomeState.showData)
    }
    
    func test_getTrendingFailure_shoudlShowError() {
        let repository = MockHomeRepository()
        repository.isSuccess = false
        let useCase = DefaultHomeUsecase(repository: repository)
        sut = DefaultHomeViewModel(useCase: useCase)
        
        sut.getDataItem(type: .movie)
        
        XCTAssertEqual(sut.homeState.value, HomeState.generalError)
    }
    
    func test_getDiscoverSuccess_shoudlShowData() {
        let repository = MockHomeRepository()
        let useCase = DefaultHomeUsecase(repository: repository)
        sut = DefaultHomeViewModel(useCase: useCase)
        
        sut.getDataItem(type: .movie)
        
        XCTAssertEqual(sut.homeState.value, HomeState.showData)
    }
    
    func test_getDiscoverFailure_shoudlShowError() {
        let repository = MockHomeRepository()
        repository.isSuccess = false
        let useCase = DefaultHomeUsecase(repository: repository)
        sut = DefaultHomeViewModel(useCase: useCase)
        
        sut.getDataItem(type: .movie)
        
        XCTAssertEqual(sut.homeState.value, HomeState.generalError)
    }
}
