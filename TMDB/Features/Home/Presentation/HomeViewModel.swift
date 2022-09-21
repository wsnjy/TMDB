//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import Combine

enum ItemType: String {
    case movie
    case tv
}

enum HomeState: Equatable {
    case showData
    case errorNetwork(message: String)
    case generalError
}

protocol HomeViewModelInput {
    func viewDidLoad(with type: ItemType)
}

protocol HomeViewModelOutput {
    var trending: Observable<[Movie]>  { get }
    var discover: Observable<[Movie]>  { get }
    var headerData: Observable<HeaderData>  { get }
    var homeState: Observable<HomeState>  { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}

class DefaultHomeViewModel: HomeViewModel {
    
    var trending: Observable<[Movie]> = Observable([])
    var discover: Observable<[Movie]> = Observable([])
    var headerData: Observable<HeaderData> = Observable(HeaderData.defaultData())
    var homeState: Observable<HomeState> = Observable(.showData)
    var useCase: HomeUsecase!
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: HomeUsecase = DefaultHomeUsecase()) {
        self.useCase = useCase
    }
    
    func viewDidLoad(with type: ItemType) {
        getDataItem(type: type)
    }
    
    func getDataItem(type: ItemType) {
        getTrending(type)
        getDiscover(type)
    }
    
    private func getTrending(_ item: ItemType) {
        let path = "/\(Base.version)/trending/\(item.rawValue)/day?api_key="
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }
        
        guard Reachability.isConnectedToNetwork() else {
            return homeState.value = .errorNetwork(message: "Check Your Connection First, Please!")
        }
        
        useCase.getTrendingItem(url: url)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.homeState.value = .generalError
                case .finished:
                    self.homeState.value = .showData
                }
            }, receiveValue: { trending in
                    self.trending.value = trending.results
                    self.setHeaderData()
            })
            .store(in: &cancellables)
    }
    
    private func setHeaderData() {
        let selectedHeader = trending.value.randomElement()
        headerData.value = HeaderData(imagePath: selectedHeader?.posterPath ?? "",
                                      title: getTitleHeader(item: selectedHeader))
    }
    
    private func getTitleHeader(item: Movie?) -> String {
        guard let title = item?.title, !title.isEmpty else {
            return item?.originalName ?? ""
        }
        
        return title
    }
    
    private func getDiscover(_ item: ItemType) {
        
        guard Reachability.isConnectedToNetwork() else {
            return homeState.value = .errorNetwork(message: "Check Your Connection First, Please!")
        }

        let path = "/\(Base.version)/discover/\(item.rawValue)?api_key="
        
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }

        useCase.getTrendingItem(url: url)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.homeState.value = .generalError
                case .finished:
                    self.homeState.value = .showData
                }
            }, receiveValue: { discover in
                self.discover.value = discover.results
            })
            .store(in: &cancellables)
    }
}
