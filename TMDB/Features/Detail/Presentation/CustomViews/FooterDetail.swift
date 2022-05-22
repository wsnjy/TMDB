//
//  FooterDetail.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 19/05/22.
//

import UIKit

class FooterDetail: UIView {
    
    var actionButton: () -> () = {}
    
    let showAllButton: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont.simpleFont.circularFootnote
        view.titleLabel?.textColor = UIColor.white.withAlphaComponent(0.7)
        view.contentHorizontalAlignment = .right
        view.setTitle("show all", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
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
        addSubview(showAllButton)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            showAllButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            showAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            showAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    @objc internal func didTapButton() {
        actionButton()
    }
}
