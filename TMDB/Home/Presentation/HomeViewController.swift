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

    private var headerTable: HeaderTable!
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
        setupHeader()
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
            self.setHeaderImage(movie: movies.randomElement())
        }
        
        viewModel.discover.observe(on: self) { movies in
            self.sectionData[HomeSection.discover.rawValue] = movies
            self.tableView.reloadSections(IndexSet(integer: HomeSection.discover.rawValue), with: .fade)
        }
    }
    
    private func setHeaderImage(movie: Movie?) {
        guard let `headerTable` = headerTable else {
            return
        }
        
        headerTable.setContentHeader(image: movie?.posterPath, title: movie?.title)
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
    
    private func setupHeader() {
        headerTable = HeaderTable(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 3/4))
        tableView.tableHeaderView = headerTable
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
        header.textLabel?.textColor = .systemTeal
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
}

extension HomeViewController: CollectionTableViewCellDelegate {
    
    func collectionTableViewCellDidTap(movie: Movie) {
        let detail = DetailViewController(viewModel: DefaultDetailViewModel())
        detail.setDetail(movie: movie)
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
