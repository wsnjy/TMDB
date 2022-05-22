//
//  AppDelegate.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        setupNavigation()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabbarViewController()
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().tintColor = UIColor.cafe_5

        return true
    }
    
    func setupNavigation(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.cafe_1
        UINavigationBar().standardAppearance = appearance;
        UINavigationBar().scrollEdgeAppearance = UINavigationBar().standardAppearance
    }
}
