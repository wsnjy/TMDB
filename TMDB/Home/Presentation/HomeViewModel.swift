//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation

enum ItemType {
    case movie
    case series
}

protocol HomeViewModelInput {
    func viewDidLoad()
}

protocol HomeViewModelOutput {
    var trending: Observable<[Movie]>  { get }
    var discover: Observable<[Movie]>  { get }
    var errorMessage: Observable<String>  { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}

class DefaultHomeViewModel: HomeViewModel {
    
    var trending: Observable<[Movie]> = Observable([])
    var discover: Observable<[Movie]> = Observable([])
    var errorMessage: Observable<String> = Observable("")
    var useCase: HomeUsecase!
    
    init(useCase: HomeUsecase = DefaultHomeUsecase()) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        getDataItem(type: .movie)
    }
    
    func getDataItem(type: ItemType) {
        getTrending(type)
        getDiscover(type)
    }
    
    private func getTrending(_ item: ItemType) {
        let path = "/3/trending/movie/day?api_key="
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }
        
        useCase.getTrendingItem(url: url) { result in
            switch result {
            case .success(let data):
                self.trending.value = data.results

            case .failure:
                print("show general error")
            }
        }
    }
    
    private func getDiscover(_ item: ItemType) {
        let path = "/3/discover/tv?api_key="
        
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }

        useCase.getTrendingItem(url: url) { result in
            switch result {
            case .success(let data):
                self.discover.value = data.results

            case .failure:
                print("show general error")
            }
        }
    }
}
