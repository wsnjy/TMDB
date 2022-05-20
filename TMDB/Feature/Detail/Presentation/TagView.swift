//
//  TagView.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 20/05/22.
//

import UIKit

protocol TagViewInput {
    func setLabel(text: String)
}

class TagView: UIView {
    
    let label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .systemTeal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12, weight: .semibold)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        layer.masksToBounds = true
        layer.cornerRadius = 5
        
        addSubview(label)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }
}

extension TagView: TagViewInput {
    
    func setLabel(text: String) {
        label.text = text
    }
}
