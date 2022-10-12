//
//  MovieFavoriteViewController.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MovieFavoriteDelegate {
    
    func hasUpdateMovieFavStatus()
}

class MovieFavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: MovieFavoriteBusinessLogic?
    var router: (MovieFavoriteRoutingLogic & MovieFavoriteDataPassing)?

    var movieModel: MovieFavorite.ViewModel?
    
    var isBack: Bool = false
    var hasUpdate: Bool = false
    
    var delegate: MovieFavoriteDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        doSomething()
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        if hasUpdate {
            delegate?.hasUpdateMovieFavStatus()
        }
    }
    private func setupView() {
        
        title = "Favorite Movies"
        prepareTableView()
        
        movieModel = MovieFavorite.ViewModel(movieList: router?.dataStore?.movieList)
        reloadData()
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
    
    func registerCells() {
        
        tableView.register(FavMovieCell.self, forCellReuseIdentifier: FavMovieCell.identifier)
        tableView.register(UINib(nibName: FavMovieCell.identifier, bundle: nil),
                           forCellReuseIdentifier: FavMovieCell.identifier)
        
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.identifier)
        tableView.register(UINib(nibName: NoDataCell.identifier, bundle: nil),
                           forCellReuseIdentifier: NoDataCell.identifier)
    }
    
    func reloadData() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func doSomething() {
        let request = MovieFavorite.Request()
        interactor?.doSomething(request: request)
    }
}

extension MovieFavoriteViewController : MovieFavoriteDisplayLogic {
    
    func displaySomethingOnSuccess(viewModel: MovieFavorite.ViewModel) {
        
    }

    func displayErrorMessage(errorMessage: String) {
        
    }
}

extension MovieFavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row < (movieModel?.movieList?.count ?? 0) else { return }

        let movie = movieModel?.movieList?[indexPath.row]
        router?.displayMovieDetail(with: movie)
    }
    
    func presentMovieDetail(with movie: MD_Movie?) {
        
        isBack = false
        
        let identifier = "MovieDetailViewController"
        let viewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: identifier) as? MovieDetailViewController
        viewController?.router?.dataStore?.movie = movie
        viewController?.delegate = self
        viewController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController!, animated: true)
    }
}

extension MovieFavoriteViewController: MovieDetailDelegate {

    func hasUpdateMovieStatus(with updatedMovie: MD_Movie?) {

        if let row = movieModel?.movieList?.firstIndex(where: {$0.title == (updatedMovie?.title ?? "")}) {
            movieModel?.movieList?.remove(at: row)
        }
        
        hasUpdate = true
        reloadData()
    }
}

extension MovieFavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (movieModel?.movieList?.count ?? 0) == 0 {
            return tableView.frame.size.height
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (movieModel?.movieList?.count ?? 0 == 0) {
            return 1
        }
        
        return movieModel?.movieList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row < (movieModel?.movieList?.count ?? 0) else {
            return prepareNoDataCell()
        }
        
        let movie = movieModel?.movieList?[indexPath.row]
        return prepareMovieCell(with: movie)
    }
    
    func prepareMovieCell(with movie: MD_Movie?) -> UITableViewCell {
        
        let identifier: String = FavMovieCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FavMovieCell
        cell?.prepareCell(with: movie)
        return cell!
    }
    
    func prepareNoDataCell() -> UITableViewCell {
        
        let identifier: String = NoDataCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? NoDataCell
        return cell!
    }
}


// MARK: Setup & Configuration
extension MovieFavoriteViewController {
    
    private func configure() {
        MovieFavoriteConfiguration.shared.configure(self)
    }
}
