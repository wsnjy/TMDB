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
}

protocol DetailViewModelOutput {
    var reviews: Observable<[Review]>  { get }
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput {}

class DefaultDetailViewModel: DetailViewModel {
    
    var reviews: Observable<[Review]> = Observable([])
    var useCase: DetailUseCase!
    
    init(useCase: DetailUseCase = DefaultDetailUseCase()) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        getDataReview(for: "756187")
    }
    
    private func getDataReview(for movieID: String) {
        
        let path = "/3/movie/\(movieID)/reviews?api_key="
        guard let url = URL(string: "\(Base.URL)\(path)\(Credential.apiKey)") else {
            return
        }

        useCase.getReviewMovie(url:  url) { result in
            switch result {
            case .success(let data):
                print(data)
                
            case .failure:
                print("error data")
            }
        }
    }
}
