//
//  BaseCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 22/05/22.
//

import UIKit

class BaseCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = UIColor.cafe_1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
