//
//  CreditCell.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 20/05/22.
//

import UIKit

class CreditCell: BaseCell {

    static let identifier = "CreditCell"
    
    var contents = [Cast]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 44, height: 64)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.cafe_1
        view.showsHorizontalScrollIndicator = false
        view.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = CGRect(x: 16, y: 0, width: frame.size.width - 32, height: frame.size.height)
    }
    
    func setupContent(values: [Cast]) {
        contents = values
        collectionView.reloadData()
    }
}

extension CreditCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as? CastCell else {
            return UICollectionViewCell()
        }
        
        let content = contents[indexPath.row]
        if let posterPath = content.profilePath {
            cell.config(url: posterPath)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }    
}
