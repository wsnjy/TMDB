//
//  CastCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 20/05/22.
//

import UIKit

class CastCell: ContentCollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    internal func setupViews() {
        poster.layer.masksToBounds = true
        poster.layer.cornerRadius = 8
    }
    
    override func config(url: String) {
        guard let url = URL(string: "\(Base.URLImage)\(url)") else {
            return
        }

        poster.kf.setImage(with: url, placeholder: UIImage(named: "placeholderProfile"), options: nil, completionHandler: nil)
    }
}
