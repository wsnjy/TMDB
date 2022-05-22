//
//  DetailViewModel.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import Foundation
import UIKit

struct TitleDescriptionMovie {
    let title: String
    var description: String
}

struct RateAndGenre: Equatable {
    let isAdult: Bool
    let genre: String
    let votes: String
    
    static func defaultData() -> RateAndGenre {
        return RateAndGenre(isAdult: false, genre: "", votes: "")
    }
}

protocol DetailViewModelInput {
    func viewDidLoad()
    func setType(item: ItemType)
    func set(itemID: Int?)
    func set(movie: Movie)
}

protocol DetailViewModelOutput {
    var contentDetail: Observable<[TitleDescriptionMovie]>  { get }
    var reviews: Observable<[Review]>  { get }
    var credits: Observable<[Cast]>  { get }
    var headerData: Observable<HeaderData>  { get }
    var rateAndGenre: Observable<RateAndGenre> { get }
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput {}

class DefaultDetailViewModel: DetailViewModel {
    
    var contentDetail: Observable<[TitleDescriptionMovie]> = Observable([])
    var reviews: Observable<[Review]> = Observable([])
    var credits: Observable<[Cast]> = Observable([])
    var headerData: Observable<HeaderData> = Observable(HeaderData.defaultData())
    var rateAndGenre: Observable<RateAndGenre> = Observable(RateAndGenre.defaultData())
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
    
    private func setRateAndGenre(item: ItemDetail) {
        rateAndGenre.value = RateAndGenre(isAdult: item.adult ?? false,
                                          genre: String(item.genres.map{$0.name}.first ?? "") ,
                                          votes: String(item.voteAverage ?? 0))
    }
    
    private func getTitleHeader(item: Movie?) -> String {
        guard let title = item?.title, !title.isEmpty else {
            return item?.originalName ?? ""
        }
        
        return title
    }

    private func setupContent(detail: ItemDetail) {
        let summary = TitleDescriptionMovie(title: "Summary", description: detail.overview ?? "")
        var releaseData = TitleDescriptionMovie(title: "Release Date", description: detail.releaseDate ?? "")
        let genre = TitleDescriptionMovie(title: "Genre", description: getGenresString(item: detail.genres))
        
        if let seasons = detail.seasons {
            releaseData.description = getReleaseDateTVShow(seasons: seasons)
        }
        
        contentDetail.value = [
            summary,
            releaseData,
            genre
        ]
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
                self.setRateAndGenre(item: detail)
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
