//
//  DetailViewController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit

protocol DetailViewControllerInput {
    func setDetail(item: Movie, type: ItemType)
}

enum SectionDetail: Int, CaseIterable {
    case titleDetail = 0
    case info
    case content
    case credit
    case review
}

enum ReviewState {
    case none
    case showFirst
    case showAll
}

class DetailViewController: UIViewController {
    
    private var headerTable: HeaderTable!
    private var viewModel: DetailViewModel = DefaultDetailViewModel()
    private var reviews = [Review]()
    private var content: TitleDescriptionMovie?
    private var credits = [Cast]()
    private var reviewState: ReviewState = .none {
        didSet {
            tableView.reloadData()
            tableView.reloadSections(IndexSet(integer: SectionDetail.review.rawValue), with: .fade)
        }
    }
    
    private let refreshControl = UIRefreshControl()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = UIColor.cafe_1
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = UITableView.automaticDimension
        view.rowHeight = UITableView.automaticDimension
        view.register(TitleDetailCell.self, forCellReuseIdentifier: TitleDetailCell.identifier)
        view.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        view.register(CreditCell.self, forCellReuseIdentifier: CreditCell.identifier)
        view.register(ContentCell.self, forCellReuseIdentifier: ContentCell.identifier)
        view.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayouts()
        setupHeader()
        setupFooter()
        setupRefreshControl()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
        
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = UIColor.cafe_5
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAction),
                                 for: .valueChanged)
    }
    
    private func bind(to: DetailViewModel) {
        
        viewModel.headerData.observe(on: self) { headerData in
            self.setHeaderData(content: headerData)
        }
        
        viewModel.reviews.observe(on: self) { reviews in
            self.setupReviews(value: reviews)
        }
        
        viewModel.contentDetail.observe(on: self) {  content in
            self.setupContent(content: content)
        }
        
        viewModel.credits.observe(on: self) { credits in
            self.credits = credits
            self.refreshControl.endRefreshing()
            self.tableView.reloadSections(IndexSet(integer: SectionDetail.credit.rawValue), with: .fade)
        }
    }
    
    private func setupReviews(value: [Review]) {
        self.reviews = value
        self.reviewState = .showFirst
        self.setupFooter()
        self.refreshControl.endRefreshing()
        self.tableView.reloadSections(IndexSet(integer: SectionDetail.review.rawValue), with: .fade)
    }
    
    private func setupContent(content: TitleDescriptionMovie) {
        self.title = content.title
        self.content = content
        self.refreshControl.endRefreshing()
        self.tableView.reloadSections(IndexSet(integer: SectionDetail.titleDetail.rawValue), with: .fade)
        self.tableView.reloadSections(IndexSet(integer: SectionDetail.info.rawValue), with: .fade)
        self.tableView.reloadSections(IndexSet(integer: SectionDetail.content.rawValue), with: .fade)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.cafe_1
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
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

    private func setHeaderData(content: HeaderData) {
        guard let `headerTable` = headerTable else {
            return
        }

        headerTable.setContentHeader(image: content.imagePath, title: "")
    }
    
    private func setupFooter() {
        let footerDetail = FooterDetail(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        footerDetail.actionButton = {
            self.reviewState = self.reviewState == .showFirst ? .showAll : .showFirst
            self.tableView.tableFooterView = UIView(frame: .zero)
        }
        
        if reviews.count > 1 {
            tableView.tableFooterView = footerDetail
        }
    }
    
    @objc private func refreshAction() {
        viewModel.viewDidLoad()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionDetail.allCases.count
    }
    
    fileprivate func sectionReviewDataCount() -> Int {
        switch reviewState {
        case .showFirst:
            return 1
        case .showAll:
            return reviews.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case SectionDetail.titleDetail.rawValue, SectionDetail.info.rawValue,
            SectionDetail.credit.rawValue, SectionDetail.content.rawValue:
            return 1
            
        case SectionDetail.review.rawValue:
            return reviews.count > 0 ? sectionReviewDataCount() : 0
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case SectionDetail.titleDetail.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailCell.identifier) as? TitleDetailCell else {
                return UITableViewCell()
            }
            
            if let content = content {
                cell.setContent(title: content.title, releaseDate: content.releaseDate, durationAndGenre: content.genre)
            }
                    
            return cell
            
        case SectionDetail.info.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier) as? InfoCell else {
                return UITableViewCell()
            }
            
            if let content = content {
                cell.setContent(language: content.language, rating: content.votes, review: content.reviews)
            }

            return cell
            
        case SectionDetail.content.rawValue:
            return setupContentMovieCell(cellForRowAt: indexPath)
            
        case SectionDetail.review.rawValue:
            return setupReviewCell(cellForRowAt: indexPath)
            
        case SectionDetail.credit.rawValue:
            return setupCreditCell(cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func setupCreditCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditCell.identifier) as? CreditCell else {
            return UITableViewCell()
        }
        
        cell.setupContent(values: credits)
        return cell
    }
    
    fileprivate func setupContentMovieCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier) as? ContentCell else {
            return UITableViewCell()
        }
        
        cell.setupContent(description: content?.description ?? "")
        return cell
    }
    
    fileprivate func setupReviewCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !reviews.isEmpty else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier) as? ReviewCell else {
            return UITableViewCell()
        }
        
        let review = reviews[indexPath.row]
        cell.setContent(imageURL: review.authorDetails.avatarPath, name: review.authorDetails.name, comment: review.content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if SectionDetail.credit.rawValue == indexPath.section {
            return 100
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView, let textLabel = header.textLabel {
            textLabel.font = UIFont.simpleFont.circularBody
            textLabel.textColor = UIColor.cafe_5
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case SectionDetail.credit.rawValue:
            return "Actors"
            
        case SectionDetail.content.rawValue:
            return "About Movie"
            
        case SectionDetail.review.rawValue:
            return reviews.count > 0 ? "Reviews" : ""
            
        default:
            return ""
        }
    }
}

extension DetailViewController: DetailViewControllerInput {
    
    func setDetail(item: Movie, type: ItemType) {
        viewModel.set(movie: item)
        viewModel.setType(item: type)
        viewModel.set(itemID: item.id)
    }
}
