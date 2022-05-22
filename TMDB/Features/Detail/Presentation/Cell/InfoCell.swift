//
//  InfoCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 22/05/22.
//

import UIKit

protocol InfoCellInput {
    func setContent(language: String, rating: String, review: String)
}

class InfoCell: BaseCell {
    
    static let identifier = "InfoCell"
    
    var languageView: VerticalInfo = {
        let view = VerticalInfo()
        return view
    }()
    
    var ratingView: VerticalInfo = {
        let view = VerticalInfo()
        return view
    }()
    
    var reviewsView: VerticalInfo = {
        let view = VerticalInfo()
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(languageView)
        stackView.addArrangedSubview(ratingView)
        stackView.addArrangedSubview(reviewsView)
        addSubview(stackView)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension InfoCell: InfoCellInput {
    func setContent(language: String, rating: String, review: String) {
        languageView.setLabel(top: "Language", bottom: language, alignment: .center)
        ratingView.setLabel(top: "Rating", bottom: rating, alignment: .center)
        reviewsView.setLabel(top: "Reviews", bottom: review, alignment: .center)
    }
}
