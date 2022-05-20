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
    let description: String
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
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput {}

class DefaultDetailViewModel: DetailViewModel {
    
    var contentDetail: Observable<[TitleDescriptionMovie]> = Observable([])
    var reviews: Observable<[Review]> = Observable([])
    var credits: Observable<[Cast]> = Observable([])
    var headerData: Observable<HeaderData> = Observable(HeaderData.defaultData())
    var useCase: DetailUseCase!
    
    private(set) var itemID: String = ""
    private var itemType: ItemType = .movie
    
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
    
    private func getTitleHeader(item: Movie?) -> String {
        guard let title = item?.title, !title.isEmpty else {
            return item?.originalName ?? ""
        }
        
        return title
    }

    private func setupContent(detail: ItemDetail) {
        let summary = TitleDescriptionMovie(title: "Summary", description: detail.overview ?? "")
        let releaseData = TitleDescriptionMovie(title: "Release Date", description: detail.releaseDate ?? "")
        let genre = TitleDescriptionMovie(title: "Genre", description: getGenresString(item: detail.genres))
        
        contentDetail.value = [
            summary,
            releaseData,
            genre
        ]
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
                self.credits.value = data.cast
            case .failure:
                print("error data")
            }
        }
    }
}
