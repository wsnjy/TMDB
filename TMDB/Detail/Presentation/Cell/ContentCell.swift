//
//  ContentCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 19/05/22.
//

import UIKit

protocol ContentCellInput {
    func setupContent(title: String, description: String)
}

class ContentCell: UITableViewCell {
    
    static let identifier = "ContentCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        detailTextLabel?.numberOfLines = 0
    }
}

extension ContentCell: ContentCellInput {
    
    func setupContent(title: String, description: String) {
        textLabel?.text = title
        detailTextLabel?.text = description
    }
}
