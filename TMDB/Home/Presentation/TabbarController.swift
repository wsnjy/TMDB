//
//  TabbarController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupItem()
    }
    
    private func setupItem() {
        
        let home = UINavigationController(rootViewController: HomeViewController(viewModel: DefaultHomeViewModel()))
        home.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let upcoming = UINavigationController(rootViewController: DetailViewController(viewModel: DefaultDetailViewModel()))
        upcoming.tabBarItem.image = UIImage(systemName: "play.circle")
        
        home.title = "Home"
        upcoming.title = "Upcoming Movies"
        
        tabBar.tintColor = .label
        
        setViewControllers([home, upcoming], animated: true)
    }
}
