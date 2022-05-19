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
    func set(movieID: Int?)
}

protocol DetailViewModelOutput {
    var contentDetail: Observable<[TitleDescriptionMovie]>  { get }
    var reviews: Observable<[Review]>  { get }
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput {}

class DefaultDetailViewModel: DetailViewModel {
    
    var contentDetail: Observable<[TitleDescriptionMovie]> = Observable([])
    var reviews: Observable<[Review]> = Observable([])
    var useCase: DetailUseCase!
    
    private(set) var movieID: String = ""
    private var item: ItemType = .movie
    
    init(useCase: DetailUseCase = DefaultDetailUseCase()) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        getDetailMovie()
        getDataReview()
    }
    
    func setType(item: ItemType) {
        self.item = item
    }
    
    func set(movieID: Int?) {
        guard let value = movieID else {
            return
        }
        
        self.movieID = String(value)
    }
    
    private func setupContent(detail: ItemDetail) {
        let summary = TitleDescriptionMovie(title: "Summary", description: detail.overview)
        let releaseData = TitleDescriptionMovie(title: "Release Date", description: detail.releaseDate)
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
        let path = "/3/movie/\(movieID)?api_key="
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
        
        let path = "/3/movie/\(movieID)/reviews?api_key="
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }

        useCase.getReviewMovie(url:  url) { result in
            switch result {
            case .success(let data):
                self.reviews.value = data.results
            case .failure:
                print("error data")
            }
        }
    }
}
