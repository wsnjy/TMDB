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

protocol HomeViewControllerInput {
    func setItem(itemType: ItemType)
}

class HomeViewController: UIViewController {

    private var headerTable: HeaderTable!
    private var viewModel: HomeViewModel = DefaultHomeViewModel()
    private var itemType: ItemType = .movie

    let sectionTitle = ["Trending", "Discover"]
    lazy var sectionData = [[Movie]](repeating: [Movie](), count: sectionTitle.count)

    private let refreshControl = UIRefreshControl()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = UIColor.cafe_1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cafe_1
        setupViews()
        setupLayouts()
        setupHeader()
        bind(to: viewModel)        
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
        
        viewModel.headerData.observe(on: self) { headerData in
            self.setHeaderData(content: headerData)
        }
        
        viewModel.discover.observe(on: self) { movies in
            self.sectionData[HomeSection.discover.rawValue] = movies
            self.tableView.reloadSections(IndexSet(integer: HomeSection.discover.rawValue), with: .fade)
        }
        
        viewModel.homeState.observe(on: self) { state in
            self.handleState(state: state)
        }
    }
    
    private func setHeaderData(content: HeaderData) {
        guard let `headerTable` = headerTable else {
            return
        }
        
        headerTable.setContentHeader(image: content.imagePath, title: content.title)
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = UIColor.cafe_5
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAction),
                                 for: .valueChanged)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupHeader() {
        headerTable = HeaderTable(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 3/4))
        tableView.tableHeaderView = headerTable
    }
    
    @objc private func refreshAction() {
        viewModel.viewDidLoad(with: itemType)
    }
}

extension HomeViewController {
    
    private func handleState(state: HomeState) {
        switch state {
        case .showData:
            self.refreshControl.endRefreshing()
            
        case .errorNetwork(let message):
            showAlert(message: message, handler: {
                self.refreshControl.endRefreshing()
            })
        default: break
        }
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
        
        header.textLabel?.font = UIFont.simpleFont.circularTitle3Bold
        header.textLabel?.textColor = UIColor.cafe_5
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
    
    func collectionTableViewCellDidTap(item: Movie) {
        let detail = DetailViewController(viewModel: DefaultDetailViewModel())
        detail.setDetail(item: item, type: itemType)
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension HomeViewController: HomeViewControllerInput {
    
    func setItem(itemType: ItemType) {
        self.itemType = itemType
        viewModel.viewDidLoad(with: itemType)
    }
}
