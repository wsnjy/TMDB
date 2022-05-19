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
        
        let account = UINavigationController(rootViewController: DetailViewController(viewModel: DefaultDetailViewModel()))
        account.tabBarItem.image = UIImage(systemName: "person.fill")
        
        home.title = "Home"
        account.title = "My Account"
        
        tabBar.tintColor = .systemTeal
        
        setViewControllers([home, account], animated: true)
    }
}
