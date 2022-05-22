//
//  RatingAndGenreCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 19/05/22.
//

import UIKit

protocol RatingAndGenreCellInput {
    func setContent(rate: Bool, genre: String, vote: String)
}

class RatingAndGenreCell: UITableViewCell {

    static let identifier = "RatingAndGenreCell"

    let rate: TagView = {
        let view = TagView()
        return view
    }()
    
    let genre: TagView = {
        let view = TagView()
        return view
    }()

    let vote: TagView = {
        let view = TagView()
        return view
    }()

    let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.axis = .horizontal
        view.alignment = .leading
        view.spacing = 5
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
        
        rate.setLabel(text: "18+")

        NSLayoutConstraint.activate([
            rate.heightAnchor.constraint(equalToConstant: 24),
            genre.heightAnchor.constraint(equalToConstant: 24),
            vote.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        stackView.addArrangedSubview(genre)
        stackView.addArrangedSubview(vote)
        stackView.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 24)))

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -frame.size.width * 0.60),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}

extension RatingAndGenreCell: RatingAndGenreCellInput {
    
    @objc func setContent(rate: Bool, genre: String, vote: String) {
        if rate {
            stackView.addArrangedSubview(self.rate)
        }
        
        self.genre.setLabel(text: genre)
        self.vote.setLabel(text: "vote: \(vote)")
    }
}
