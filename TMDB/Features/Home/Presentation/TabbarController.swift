//
//  TabbarController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit

class TabbarViewController: UITabBarController {

    private let homeTitle = "Home"
    private let accountTitle = "My Account"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItem()
    }
    
    private func setupItem() {
        
        let home = UINavigationController(rootViewController: HomeRootViewController())
        home.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let account = UINavigationController(rootViewController: ProfileViewController())
        account.tabBarItem.image = UIImage(systemName: "person.fill")
        
        home.title = homeTitle
        account.title = accountTitle
        
        tabBar.tintColor = UIColor.cafe_5
        tabBar.barTintColor = .cafe_1
        
        setViewControllers([home, account], animated: true)
    }
}
