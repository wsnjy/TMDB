//
//  ContentCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 19/05/22.
//

import UIKit

protocol ContentCellInput {
    func setupContent(description: String)
}

class ContentCell: BaseCell {
    
    static let identifier = "ContentCell"
    
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "Tzersn"
        view.numberOfLines = 0
        view.textColor = UIColor.white.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.simpleFont.circularFootnote
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    private func setupViews() {
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

extension ContentCell: ContentCellInput {
    
    func setupContent(description: String) {
        descriptionLabel.text = description
    }
}
