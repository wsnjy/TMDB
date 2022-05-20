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
    
    private func setupViews() {        
        poster.layer.masksToBounds = true
        poster.layer.cornerRadius = 8
    }
}
