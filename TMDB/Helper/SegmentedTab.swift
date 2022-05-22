//
//  TabSegmented.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 20/05/22.
//

import UIKit

protocol SegmentedTabInput {
    func setIndex(_ index: Int)
}

protocol SegmentedTabDelegate: AnyObject {
    func changedIndex(to index: Int)
}

class SegmentedTab: UISegmentedControl {
    
    //MARK: - Properties
    let _tabHeight: CGFloat = 2
    var sortedSubViews: [UIView] {
        return subviews.sorted { (before, after) -> Bool in
            return before.frame.origin.x < after.frame.origin.x
        }
    }
    public weak var delegate: SegmentedTabDelegate?
    
    //MARK: - Components
    private lazy var indicatorLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.cafe_5.cgColor
        return layer
    }()
    
    
    //MARK: - Default Functions
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override init(items: [Any]?) {
        super.init(items: items)
        setupViews()
        setupLayouts()
        addTargets()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayouts()
        addTargets()
    }
    
    public func refreshViews() {
        for i in 0 ..< numberOfSegments {
            let item = subviews[i]
            let layer = CALayer()
            
            layer.backgroundColor = UIColor.cafe_1.cgColor
            let newBounds = CGRect(x: item.bounds.origin.x, y: item.bounds.origin.y, width: self.frame.width / CGFloat(numberOfSegments), height: item.bounds.height - _tabHeight)
            layer.frame = newBounds
            item.layer.insertSublayer(layer, at: 0)
        }
        
        self.selectedSegmentIndex = 0
        
        let bottomSeparator: CALayer = CALayer()
        bottomSeparator.backgroundColor = UIColor.cafe_1.cgColor
        bottomSeparator.frame = CGRect(x: 0, y: self.frame.height - _tabHeight, width: self.frame.width, height: _tabHeight)
        self.layer.insertSublayer(bottomSeparator, at: 0)
        
        indicatorLayer.frame = CGRect(x: 0, y: self.frame.height - _tabHeight, width: self.frame.width / CGFloat(numberOfSegments), height: _tabHeight)
        self.layer.addSublayer(indicatorLayer)
    }
    
    
    //MARK: - Private Functions
    private func setupViews() {
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.cafe_5,
                         NSAttributedString.Key.font: UIFont.simpleFont.circularSubheadBold]
        setTitleTextAttributes(attribute, for: .normal)
        
        let attribute1 = [NSAttributedString.Key.foregroundColor: UIColor.cafe_5,
                          NSAttributedString.Key.font: UIFont.simpleFont.circularSubheadBold]
        setTitleTextAttributes(attribute1, for: .selected)
        
        setBackgroundImage(UIImage(named: "AppIcon"), for: .normal, barMetrics: .default)
        setDividerImage(imageWithColor(color: .clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        clipsToBounds = false
    }
    
    private func setupLayouts() {
        
    }
    
    private func addTargets() {
        addTarget(self, action: #selector(handleValueChanged), for: .valueChanged)
    }
    
    @objc private func handleValueChanged(_ sender: UISegmentedControl) {
        
        var targetView: UIView
        
        if #available(iOS 13.0, *) {
            targetView = sender.subviews[sender.selectedSegmentIndex]
        } else {
            targetView = self.sortedSubViews[sender.selectedSegmentIndex]
        }
        
        UIView.animate(withDuration: 0.75) {
            let transform = CGAffineTransform(translationX: targetView.frame.origin.x, y: 0)
            self.indicatorLayer.setAffineTransform(transform)
        }
        
        guard let delegate = delegate else { return }
        delegate.changedIndex(to: sender.selectedSegmentIndex)
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}

extension SegmentedTab: SegmentedTabInput {
    public func setIndex(_ index: Int) {
        self.selectedSegmentIndex = index
        self.handleValueChanged(self)
    }
}
