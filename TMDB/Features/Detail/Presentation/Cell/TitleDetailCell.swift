//
//  TitleDetailCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 22/05/22.
//

import UIKit

protocol TitleDetailCellInput {
    func setContent(title: String, releaseDate: String, durationAndGenre: String)
}

class TitleDetailCell: BaseCell {
    
    static let identifier = "titleDetailCell"

    let titleMovie: UILabel = {
        let view = UILabel()
        view.text = "Tzersn"
        view.numberOfLines = 0
        view.textColor = UIColor.white.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.simpleFont.circularTitle1
        return view
    }()

    let releaseDate: UILabel = {
        let view = UILabel()
        view.text = "August 15, 2018"
        view.textColor = UIColor.white.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.simpleFont.circularFootnote
        return view
    }()
    
    let durationAndGenre: UILabel = {
        let view = UILabel()
        view.text = "2 hrs 21 min | Action, Thriller"
        view.textColor = UIColor.white.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.simpleFont.circularFootnote
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
        contentView.addSubview(titleMovie)
        contentView.addSubview(releaseDate)
        contentView.addSubview(durationAndGenre)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            titleMovie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleMovie.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleMovie.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            releaseDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            releaseDate.topAnchor.constraint(equalTo: titleMovie.bottomAnchor),
            releaseDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            durationAndGenre.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            durationAndGenre.topAnchor.constraint(equalTo: releaseDate.bottomAnchor),
            durationAndGenre.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            durationAndGenre.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}

extension TitleDetailCell: TitleDetailCellInput {
    
    func setContent(title: String, releaseDate: String, durationAndGenre: String) {
        self.titleMovie.text = title
        self.releaseDate.text = releaseDate
        self.durationAndGenre.text = durationAndGenre
    }
}
