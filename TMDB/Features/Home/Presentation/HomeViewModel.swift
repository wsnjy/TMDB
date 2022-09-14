//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import RxSwift

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
    var trending: Obsrvbl<[Movie]>  { get }
    var discover: Obsrvbl<[Movie]>  { get }
    var headerData: Obsrvbl<HeaderData>  { get }
    var homeState: Obsrvbl<HomeState>  { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}

class DefaultHomeViewModel: HomeViewModel {
    
    var trending: Obsrvbl<[Movie]> = Obsrvbl([])
    var discover: Obsrvbl<[Movie]> = Obsrvbl([])
    var headerData: Obsrvbl<HeaderData> = Obsrvbl(HeaderData.defaultData())
    var homeState: Obsrvbl<HomeState> = Obsrvbl(.showData)
    var useCase: HomeUsecase!
    
    private let disposeBag = DisposeBag()
    
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
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.trending.value = result.results
                self.homeState.value = .showData
                self.setHeaderData()
            } onError: { error in
                self.homeState.value = .generalError
            }.disposed(by: disposeBag)        
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
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.discover.value = result.results
                self.homeState.value = .showData
            } onError: { error in
                self.homeState.value = .generalError
            }.disposed(by: disposeBag)
    }
}
