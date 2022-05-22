//
//  VerticalInfo.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 22/05/22.
//

import UIKit

protocol VerticalInfoInput {
    func setLabel(top: String, bottom: String, alignment: NSTextAlignment)
}

class VerticalInfo: UIView {
    
    let labelTop: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = UIColor.white.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.simpleFont.circularFootnote
        return view
    }()
    
    let labelBottom: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = UIColor.cafe_5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.simpleFont.circularTitle3Bold
        return view
    }()

    let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    internal func setupViews() {
        stackView.addArrangedSubview(labelTop)
        stackView.addArrangedSubview(labelBottom)
        addSubview(stackView)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension VerticalInfo: VerticalInfoInput {
    
    func setLabel(top: String, bottom: String, alignment: NSTextAlignment) {
        labelTop.text = top
        labelBottom.text = bottom
        
        labelTop.textAlignment = alignment
        labelBottom.textAlignment = alignment
    }
}
