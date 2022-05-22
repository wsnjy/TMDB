//
//  HeaderTable.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 19/05/22.
//

import UIKit
import Kingfisher

protocol HeaderTableInput {
    func setContentHeader(image: String?, title: String?)
}

class HeaderTable: UIView {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let movieTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textColor = UIColor.white.withAlphaComponent(0.7)
        view.font = UIFont.simpleFont.circularTitle1Bold
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    private func setupViews() {
        addSubview(imageView)
        addGradient()
        addSubview(movieTitle)
    }
    
    private func setupLayouts() {
        
        NSLayoutConstraint.activate([
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            movieTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            movieTitle.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.cafe_1.cgColor
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}

extension HeaderTable: HeaderTableInput {
    
    func setContentHeader(image: String?, title: String?) {
        
        guard let moviePoster = image, let url = URL(string: "\(Base.URLImage)\(moviePoster)") else {
            return
        }
        
        movieTitle.text = title
        imageView.kf.setImage(with: url, placeholder: UIImage(), options: nil, completionHandler: nil)
    }
}
