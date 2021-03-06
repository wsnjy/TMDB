 //
//  ReviewCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 19/05/22.
//

import UIKit

protocol ReviewCellInput {
    func setContent(imageURL: String?, name: String?, comment: String?)
}

class ReviewCell: BaseCell {

    static let identifier = "ReviewCell"
    private let heightImage: CGFloat = 44
    
    lazy var imageUser: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.layer.cornerRadius = heightImage/2
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.white.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.simpleFont.circularSubheadBold
        return view
    }()
    
    let commentLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.white.withAlphaComponent(0.7)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.simpleFont.circularCaption2
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
        contentView.addSubview(imageUser)
        contentView.addSubview(nameLabel)
        contentView.addSubview(commentLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            imageUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageUser.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageUser.widthAnchor.constraint(equalToConstant: heightImage),
            imageUser.heightAnchor.constraint(equalToConstant: heightImage),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageUser.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: imageUser.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            commentLabel.topAnchor.constraint(equalTo: imageUser.bottomAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}

extension ReviewCell: ReviewCellInput {
    
    func setContent(imageURL: String?, name: String?, comment: String?) {

        guard let `imageURL` = imageURL, var finalURL = URL(string: "\(Base.URLImage)\(imageURL)") else {
            return
        }
        
        if imageURL.contains("gravatar.com"), let url = URL(string: String(imageURL.dropFirst())) {
            finalURL = url
        }
        
        imageUser.kf.setImage(with: finalURL, placeholder: UIImage(named: "placeholderProfile"), options: nil, completionHandler: nil)
        nameLabel.text = getName(value: name)
        commentLabel.text = comment
    }
    
    internal func getName(value: String?) -> String {
        
        guard let name = value, !name.isEmpty else {
            return "Unamed"
        }
        
        return name
    }
}
