//
//  ViewController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel = DefaultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func bind(to: HomeViewModel) {
        
        viewModel.trending.observe(on: self) { movies in
            print(movies)
        }
    }
}

