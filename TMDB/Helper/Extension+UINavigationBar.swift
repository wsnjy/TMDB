//
//  Extension+UINavigationBar.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 20/05/22.
//

import UIKit

extension UINavigationController {
        
    func removeNavBarSeparator(isRemoved: Bool = true) {
        let selectedImage: UIImage? = isRemoved ? UIImage() : nil
        
        if #available(iOS 15.0, *) {
            let currentTextStyle = navigationBar.compactAppearance?.titleTextAttributes
            let selectedFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
//            let backButtonImage: UIImage? = LAImage.getImage(image: .arrowLeftOutline)
            
            let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
            backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = selectedImage
            appearance.titleTextAttributes = currentTextStyle ?? [NSAttributedString.Key.font: selectedFont, NSAttributedString.Key.foregroundColor: UIColor.black]
//            appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
            appearance.backButtonAppearance = backButtonAppearance
            if isRemoved {
                appearance.shadowColor = .clear
            }
            
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.compactAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
        } else {
            self.navigationBar.shadowImage = selectedImage
        }
    }
}
