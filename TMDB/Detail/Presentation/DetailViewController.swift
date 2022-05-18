//
//  DetailViewController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel = DefaultDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(to: DetailViewModel) {
        viewModel.reviews.observe(on: self) { reviews in
            print(reviews)
        }
    }
}
