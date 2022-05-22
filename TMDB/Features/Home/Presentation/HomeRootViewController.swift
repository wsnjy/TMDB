//
//  HomeRootViewController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 20/05/22.
//

import UIKit

protocol HomeViewControllerDelegate {
    func didActive(viewController: UIViewController)
}

class HomeRootViewController: UIPageViewController {

    //MARK: - Properties
    let TAB_ITEMS: [String] = ["Movie", "TV Show"]
    private var currentIndex: Int = 0
    private var isFirstTimeLoad: Bool = false
    
    //MARK: - Components
    lazy var ITEMS_VC: [UIViewController] = {
        var items = [UIViewController]()
        
        let movies = HomeViewController(viewModel: DefaultHomeViewModel())
        movies.setItem(itemType: .movie)
        movies.view.tag = 0
        items.append(movies)
        
        let tvShow = HomeViewController(viewModel: DefaultHomeViewModel())
        tvShow.setItem(itemType: .tv)
        tvShow.view.tag = 1
        items.append(tvShow)
        
        return items
    }()
    
    lazy var tab: SegmentedTab = {
        let tab: SegmentedTab = SegmentedTab(items: TAB_ITEMS)
        tab.delegate = self
        tab.backgroundColor = UIColor.cafe_5
        tab.translatesAutoresizingMaskIntoConstraints = false
        return tab
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let image: UIImage = UIImage(named: "logoHeader")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView

        self.setupViews()
        self.setupLayouts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.removeNavBarSeparator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isFirstTimeLoad {
            setActiveVc()
            isFirstTimeLoad = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.removeNavBarSeparator(isRemoved: true)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        view.layoutIfNeeded()
        tab.refreshViews()
    }

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setActiveVc(index: Int = 0) {
        setViewControllers([ITEMS_VC[index]], direction: .forward, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tab.setIndex(index)
        }
    }
}

//MARK: - Private Functions
private extension HomeRootViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tab)
        dataSource = self
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            tab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            tab.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tab.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

//MARK: - UIPageViewControllerDataSource
extension HomeRootViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let prevIndex = viewController.view.tag - 1
        guard prevIndex >= 0 else {
            return nil
        }
        
        return ITEMS_VC[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let nextIndex = viewController.view.tag + 1
        guard nextIndex < ITEMS_VC.count else {
            return nil
        }
        
        return ITEMS_VC[nextIndex]
    }
}

//MARK: - HistoryViewControllerDelegate
extension HomeRootViewController: HomeViewControllerDelegate {
    
    func didActive(viewController: UIViewController) {
        tab.setIndex(viewController.view.tag)
        currentIndex = viewController.view.tag
    }
}

//MARK: - LATabDelegate
extension HomeRootViewController: SegmentedTabDelegate {

    func changedIndex(to index: Int) {
        guard index != currentIndex else { return }

        var direction: UIPageViewController.NavigationDirection = .forward
        if index < currentIndex {
            direction = .reverse
        }

        currentIndex = ITEMS_VC[index].view.tag
        setViewControllers([ITEMS_VC[index]], direction: direction, animated: true, completion: nil)
    }
}
