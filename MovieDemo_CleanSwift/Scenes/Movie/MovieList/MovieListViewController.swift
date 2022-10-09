//
//  MovieListViewController.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Material

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var widthVLeft: NSLayoutConstraint!
    
    @IBOutlet weak var vFooter: UIView!
    
    @IBOutlet weak var btnFavMovie: Button!
    @IBOutlet weak var btnLogout: Button!
    
    var interactor: MovieListBusinessLogic?
    var router: (MovieListRoutingLogic & MovieListDataPassing)?
    
    lazy var searchButton: UIBarButtonItem = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_import_contacts"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonDidTapped), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        return menuBarItem
    }()
    
    var searchController: UISearchController?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        doSomething()
    }

    private func setupView() {

        title = "Movies"
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.setHidesBackButton(true, animated: true)
        
        widthVLeft.constant = Constants.Padding.Field
        
        vFooter.layer.borderWidth = 1
        vFooter.layer.borderColor = UIColor.gray.cgColor
        
        btnFavMovie.setTitle("Favorate Movies", for: .normal)
        btnFavMovie.setTitleColor(.orange, for: .normal)
        btnFavMovie.layer.borderWidth = 1
        btnFavMovie.layer.borderColor = UIColor.orange.cgColor
        btnFavMovie.layer.cornerRadius = 5
        btnFavMovie.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnFavMovie.tintColor = .orange
        
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.backgroundColor = .red
        btnLogout.layer.cornerRadius = 5
        btnLogout.setTitleColor(.white, for: .normal)
        
        prepareTableView()
        prepareSearchBar()
    }
    
    func prepareTableView() {
        
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        
        tableView.bounces = false
        tableView.allowsSelectionDuringEditing = true
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        registerCells()
    }
    
    func prepareSearchBar() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.dimsBackgroundDuringPresentation = false

        searchController?.searchBar.placeholder = "Search"
        searchController?.searchBar.delegate = self
        searchController?.searchBar.sizeToFit()
        
        navigationItem.searchController = searchController
    }
    
    func registerCells() {
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                           forCellReuseIdentifier: MovieCell.identifier)
        
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.identifier)
        tableView.register(UINib(nibName: NoDataCell.identifier, bundle: nil),
                           forCellReuseIdentifier: NoDataCell.identifier)
        
        reloadData()
    }
    
    func reloadData() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @objc func searchButtonDidTapped() {
        
        presentSearchPopup()
    }
    
    func presentSearchPopup() {
        
        let alert = UIAlertController(title: "Movies name", message: "Please enter movie name", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields![0].placeholder = "Movie name"
        
        let submitAction = UIAlertAction(title: "Ok", style: .default) { [unowned alert] _ in
            
            let textfield = alert.textFields![0]
//            self.fetchMovie(with: textfield.text ?? "")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [unowned alert] _ in }
        
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func doSomething() {
        let request = MovieList.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    @IBAction func btnFavMovieDidTapped(_ sender: Any) {
//        presentMovieFavoriteView()
    }
    
    func presentMovieFavoriteView() {
        
        let identifier = "MovieFavoriteViewController"
        let viewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: identifier) as? MovieFavoriteViewController
        viewController?.modalPresentationStyle = .fullScreen
//        viewController?.delegate = self
//        viewController?.movieList = viewModel.filterFavoriteMovie(movies: movieList)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    
    @IBAction func btnLogoutDidTapped(_ sender: Any) {
        
//        viewModel.userLogout()
    }
    
    func presentLogin() {
        
        let identifier = "LoginViewController"
        let viewController = UIStoryboard(name: "Authen", bundle: nil).instantiateViewController(withIdentifier: identifier) as? LoginViewController
        viewController?.modalPresentationStyle = .fullScreen
//        viewController?.delegate = self
        let nav = UINavigationController(rootViewController: viewController!)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}

extension MovieListViewController : MovieListDisplayLogic {
    
    func displaySomethingOnSuccess(viewModel: MovieList.Something.ViewModel) {
        
    }

    func displayErrorMessage(errorMessage: String) {
        
    }
}

// MARK: Setup & Configuration
extension MovieListViewController {
    
    private func configure() {
        MovieListConfiguration.shared.configure(self)
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard indexPath.row < (filterMovieList?.count ?? 0) else { return }
//
//        let movie = filterMovieList?[indexPath.row]
//        presentMovieDetail(with: movie)
    }
    
    func presentMovieDetail(with movie: MD_Movie?) {
        
        let identifier = "MovieDetailViewController"
        let viewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: identifier) as? MovieDetailViewController
//        viewController?.movie = movie
//        viewController?.delegate = self
        viewController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController!, animated: true)
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if (filterMovieList?.count ?? 0) == 0 {
//            return tableView.frame.size.height
//        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if (filterMovieList?.count ?? 0) == 0 {
            return 1
//        }
//
//        return filterMovieList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard indexPath.row < (filterMovieList?.count ?? 0) else {
            return prepareNoDataCell()
//        }
//
//        let movie = filterMovieList?[indexPath.row]
//        return prepareMovieCell(with: movie)
    }
    
    func prepareMovieCell(with movie: MD_Movie?) -> UITableViewCell {
        
        let identifier: String = MovieCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieCell
        cell?.delegate = self
        cell?.prepareCell(with: movie)
        return cell!
    }
    
    func prepareNoDataCell() -> UITableViewCell {
        
        let identifier: String = NoDataCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? NoDataCell
        return cell!
    }
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        self.searchText = searchText
//        filterMovie(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
//        self.searchText = nil
//        filterMovieList = movieList
//        reloadData()
    }
    
    func filterMovie(with text: String) {
        
//        viewModel.filterMovie(with: text, movies: movieList)
    }
    
    func filterMovieSuccess(filterList: [MD_Movie]?) {
        
//        filterMovieList = filterList
//        reloadData()
    }
}

extension MovieListViewController: MovieDelegate {
    
    func userDidTappedFav(with movie: MD_Movie) {
        
//        guard let userId = user?.userId else { return }
//
//        LoadIndicator.showDefaultLoading()
//        viewModel.setMovieStatus(with: movie, userId: userId)
    }
    
    
    func updateMovieStatusSuccess(with movie: MD_Movie) {
        
//        viewModel.fetchLocalMovieList()
//        LoadIndicator.dismissLoading()
    }
}
