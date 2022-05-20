//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation

enum ItemType: String {
    case movie
    case tv
}

enum HomeState {
    case empty
    case loading
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

struct HeaderData {
    var imagePath: String
    var title: String
    
    static func defaultData() -> HeaderData {
        return HeaderData(imagePath: "", title: "")
    }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}

class DefaultHomeViewModel: HomeViewModel {
    
    var trending: Observable<[Movie]> = Observable([])
    var discover: Observable<[Movie]> = Observable([])
    var headerData: Observable<HeaderData> = Observable(HeaderData.defaultData())
    var homeState: Observable<HomeState> = Observable(.empty)
    var useCase: HomeUsecase!
    
    init(useCase: HomeUsecase = DefaultHomeUsecase()) {
        self.useCase = useCase
    }
    
    func viewDidLoad(with type: ItemType) {
        getDataItem(type: type)
    }
    
    func getDataItem(type: ItemType) {
        
        guard Reachability.isConnectedToNetwork() else {
            homeState.value = .errorNetwork(message: "Check Your Connection First, Please!")
            return
        }
        
        getTrending(type)
        getDiscover(type)
    }
    
    private func getTrending(_ item: ItemType) {
        let path = "/\(Base.version)/trending/\(item.rawValue)/day?api_key="
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }
        
        useCase.getTrendingItem(url: url) { result in
            switch result {
            case .success(let data):
                self.trending.value = data.results
                self.setHeaderData()
            case .failure:
                print("show general error")
            }
        }
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
        let path = "/\(Base.version)/discover/\(item.rawValue)?api_key="
        
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
