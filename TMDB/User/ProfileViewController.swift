//
//  ProfileViewController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 20/05/22.
//

import UIKit

class ProfileViewController: UIViewController {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logoHeader")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    let titleWelcome: UILabel = {
        let view = UILabel()
        view.text = "Welcome, Guest!"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.textColor = UIColor.white.withAlphaComponent(0.7)
        view.font = UIFont.simpleFont.circularTitle1Bold
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textAnnounce: UILabel = {
        let view = UILabel()
        view.text = "The login feature is not ready yet. But you can still use this apps :)"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = UIColor.white.withAlphaComponent(0.7)
        view.font = UIFont.simpleFont.circularTitle3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cafe_1
        
        view.addSubview(imageView)
        view.addSubview(titleWelcome)
        view.addSubview(textAnnounce)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            titleWelcome.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleWelcome.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            titleWelcome.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleWelcome.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            textAnnounce.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textAnnounce.topAnchor.constraint(equalTo: titleWelcome.bottomAnchor, constant: 0),
            textAnnounce.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textAnnounce.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}
