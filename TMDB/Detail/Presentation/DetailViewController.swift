//
//  DetailViewController.swift
//  TMDB
//
//  Created by Wisnu Sanjaya on 18/05/22.
//

import UIKit

protocol DetailViewControllerInput {
    func setDetail(movie: Movie)
}

enum SectionDetail: Int, CaseIterable {
    case ratingAndGenre = 0
    case content
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
    private var movie: Movie?
    private var reviews = [Review]()
    private var contents = [TitleDescriptionMovie]()
    private var reviewState: ReviewState = .none {
        didSet {
            tableView.reloadData()
            tableView.reloadSections(IndexSet(integer: SectionDetail.review.rawValue), with: .fade)
        }
    }

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = UITableView.automaticDimension
        view.rowHeight = UITableView.automaticDimension
        view.register(RatingAndGenreCell.self, forCellReuseIdentifier: RatingAndGenreCell.identifier)
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
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func bind(to: DetailViewModel) {
        viewModel.reviews.observe(on: self) { reviews in
            self.reviews = reviews
            self.reviewState = .showFirst
            self.tableView.reloadSections(IndexSet(integer: SectionDetail.review.rawValue), with: .fade)
        }
        
        viewModel.contentDetail.observe(on: self) {  contents in
            self.contents = contents
            self.tableView.reloadSections(IndexSet(integer: SectionDetail.content.rawValue), with: .fade)
        }
    }
    
    private func setupViews() {
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
        headerTable.setContentHeader(image: movie?.posterPath, title: movie?.title)
        tableView.tableHeaderView = headerTable
    }
    
    private func setupFooter() {
        let footerDetail = FooterDetail(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        footerDetail.actionButton = {
            self.reviewState = self.reviewState == .showFirst ? .showAll : .showFirst
            self.tableView.tableFooterView = UIView(frame: .zero)
        }
        tableView.tableFooterView = footerDetail
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
        case SectionDetail.ratingAndGenre.rawValue:
            return 1
            
        case SectionDetail.content.rawValue:
            return contents.count
            
        case SectionDetail.review.rawValue:
            return sectionReviewDataCount()
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case SectionDetail.ratingAndGenre.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingAndGenreCell.identifier) as? RatingAndGenreCell else {
                return UITableViewCell()
            }
            
            return cell
            
        case SectionDetail.content.rawValue:
            return setupContentMovieCell(cellForRowAt: indexPath)
            
        case SectionDetail.review.rawValue:
            return setupReviewCell(cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func setupContentMovieCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier) as? ContentCell else {
            return UITableViewCell()
        }
        
        let content = contents[indexPath.row]
        cell.setupContent(title: content.title, description: content.description)
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
}

extension DetailViewController: DetailViewControllerInput {
    
    func setDetail(movie: Movie) {
        self.movie = movie
        viewModel.set(movieID: movie.id)
    }
}
