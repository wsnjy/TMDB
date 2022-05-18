//
//  ContentCollectionViewCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit
import Kingfisher

class ContentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ContentCollectionViewCell"
    
    let poster: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(poster)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        poster.frame = bounds
    }
    
    public func config(url: String) {
        
        guard let url = URL(string: "\(Base.URLImage)\(url)") else {
            return
        }

        poster.kf.setImage(with: url, placeholder: UIImage(), options: nil, completionHandler: nil)
    }
}
