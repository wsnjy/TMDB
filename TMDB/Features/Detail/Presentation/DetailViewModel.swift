//
//  DetailViewModel.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import UIKit

struct TitleDescriptionMovie: Equatable {
    let title: String
    var description: String
    var releaseDate: String
    let genre: String
    let votes: String
    let language: String
    let reviews: String
    
    static func defaultData() -> TitleDescriptionMovie {
        return TitleDescriptionMovie(title: "", description: "", releaseDate: "", genre: "", votes: "", language: "", reviews: "")
    }
}

protocol DetailViewModelInput {
    func viewDidLoad()
    func setType(item: ItemType)
    func set(itemID: Int?)
    func set(movie: Movie)
}

protocol DetailViewModelOutput {
    var contentDetail: Observable<TitleDescriptionMovie>  { get }
    var reviews: Observable<[Review]>  { get }
    var credits: Observable<[Cast]>  { get }
    var headerData: Observable<HeaderData>  { get }
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput {}

class DefaultDetailViewModel: DetailViewModel {
    
    var contentDetail: Observable<TitleDescriptionMovie> = Observable(TitleDescriptionMovie.defaultData())
    var reviews: Observable<[Review]> = Observable([])
    var credits: Observable<[Cast]> = Observable([])
    var headerData: Observable<HeaderData> = Observable(HeaderData.defaultData())
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

    private func getDetailMovie() {
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
    
    private func getDataReview() {
        
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
    
    private func getDataActors() {
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
