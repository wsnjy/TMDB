//
//  RatingAndGenreCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 19/05/22.
//

import UIKit

class RatingAndGenreCell: UITableViewCell {

    static let identifier = "RatingAndGenreCell"

    let rate: UILabel = {
        let view = UILabel()
        view.text = "18+"
        view.textAlignment = .center
        view.textColor = .systemTeal
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12, weight: .regular)
        return view
    }()
    
    let genre: UILabel = {
        let view = UILabel()
        view.text = "Drama"
        view.textAlignment = .center
        view.textColor = .systemTeal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12, weight: .regular)
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.axis = .horizontal
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
    }
    
    private func setupLayouts() {
        
        stackView.addArrangedSubview(rate)
        stackView.addArrangedSubview(genre)
                
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -frame.size.width * 0.75),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}
