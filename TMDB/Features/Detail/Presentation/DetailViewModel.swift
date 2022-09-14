//
//  DetailViewModel.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import UIKit

protocol DetailViewModelInput {
    func viewDidLoad()
    func setType(item: ItemType)
    func set(itemID: Int?)
    func set(movie: Movie)
}

protocol DetailViewModelOutput {
    var contentDetail: Obsrvbl<TitleDescriptionMovie>  { get }
    var reviews: Obsrvbl<[Review]>  { get }
    var credits: Obsrvbl<[Cast]>  { get }
    var headerData: Obsrvbl<HeaderData>  { get }
}

enum DetailState: Equatable {
    case showData
    case errorNetwork(message: String)
    case generalError
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput {}

class DefaultDetailViewModel: DetailViewModel {
    
    var contentDetail: Obsrvbl<TitleDescriptionMovie> = Obsrvbl(TitleDescriptionMovie.defaultData())
    var reviews: Obsrvbl<[Review]> = Obsrvbl([])
    var credits: Obsrvbl<[Cast]> = Obsrvbl([])
    var headerData: Obsrvbl<HeaderData> = Obsrvbl(HeaderData.defaultData())
    var detailState: Obsrvbl<DetailState> = Obsrvbl(.showData)
    var useCase: DetailUseCase!
    
    private(set) var itemID: String = ""
    internal var itemType: ItemType = .movie
    
    init(useCase: DetailUseCase = DefaultDetailUseCase()) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        getDetailMovie()
        getDataReview()
        getDataActors()
    }
    
    func setType(item: ItemType) {
        self.itemType = item
    }
    
    func set(itemID: Int?) {
        guard let value = itemID else {
            return
        }
        
        self.itemID = String(value)
    }
    
    func set(movie: Movie) {
        setHeaderData(item: movie)
    }
    
    private func setHeaderData(item: Movie) {
        headerData.value = HeaderData(imagePath: item.posterPath ?? "",
                                      title: getTitleHeader(item: item))
    }
        
    private func getTitleHeader<T: ItemTMDB>(item: T?) -> String {
        guard let item = `item`, let title = item.originalTitle, !title.isEmpty else {
            return item?.originalName ?? ""
        }
        
        return title
    }

    private func setupContent(detail: ItemDetail) {
        let content = TitleDescriptionMovie(title: getTitleHeader(item: detail),
                                            description: detail.overview ?? "",
                                            releaseDate: detail.releaseDate ?? getReleaseDateTVShow(seasons: detail.seasons ?? []),
                                            genre: String(detail.genres.map{$0.name}.first ?? ""),
                                            votes: "\(String(detail.voteAverage ?? 0))/10",
                                            language: detail.originalLanguage ?? "",
                                            reviews: String(detail.voteCount ?? 0))
        contentDetail.value = content
    }
    
    private func getReleaseDateTVShow(seasons: [Season]) -> String {
        let seasonsArray = seasons.map({ $0.airDate })
        guard let season = seasonsArray.first, let `season` = season else {
            return "-"
        }
                
        return season
    }
    
    private func getGenresString(item: [Genre]) -> String {
        return item.map{ $0.name }.joined(separator: ", ")
    }

    internal func getDetailMovie() {
        let path = "/\(Base.version)/\(itemType)/\(itemID)?api_key="
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }

        useCase.getDetailItem(url: url) { result in
            switch result {
            case .success(let detail):
                self.setupContent(detail: detail)
            case .failure:
                print("error data")
            }
        }
    }
    
    internal func getDataReview() {
        
        let path = "/\(Base.version)/\(itemType)/\(itemID)/reviews?api_key="
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }

        useCase.getReviewItem(url:  url) { result in
            switch result {
            case .success(let data):
                self.reviews.value = data.results
            case .failure:
                print("error data")
            }
        }
    }
    
    internal func getDataActors() {
        let path = "/\(Base.version)/\(itemType)/\(itemID)/credits?api_key="
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }

        useCase.getCredits(url:  url) { result in
            switch result {
            case .success(let data):
                if data.cast.count > 0 {
                    self.credits.value = data.cast
                } else {
                    self.credits.value = [Cast.defaultdata()]
                }
            case .failure:
                print("error data")
            }
        }
    }
}
