//
//  ViewController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit

enum HomeSection: Int {
    case trending = 0
    case discover
}

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel = DefaultHomeViewModel()
    let sectionTitle = ["Trending", "Discover"]
    lazy var sectionData = [[Movie]](repeating: [Movie](), count: sectionTitle.count)

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupViews()
        setupLayouts()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func bind(to: HomeViewModel) {
        
        viewModel.trending.observe(on: self) { movies in
            self.sectionData[HomeSection.trending.rawValue] = movies
            self.tableView.reloadSections(IndexSet(integer: HomeSection.trending.rawValue), with: .fade)
        }
        
        viewModel.discover.observe(on: self) { movies in
            self.sectionData[HomeSection.discover.rawValue] = movies
            self.tableView.reloadSections(IndexSet(integer: HomeSection.discover.rawValue), with: .fade)
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupContent(values: sectionData[indexPath.section])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + topOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionTableViewCellDelegate {
    
    func collectionTableViewCellDidTap(movie: Movie) {
        print(movie)
//        viewModel.setupDetailMoview(movie: movie)
    }
}
