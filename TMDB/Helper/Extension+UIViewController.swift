//
//  Extension+UIViewController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 20/05/22.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String, handler:@escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Oke", style: .default, handler: { _ in
            handler()
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
