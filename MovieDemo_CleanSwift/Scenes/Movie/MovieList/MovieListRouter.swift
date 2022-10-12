//
//  MovieListRouter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieListRouter: NSObject, MovieListRoutingLogic, MovieListDataPassing {
    
    weak var viewController: MovieListViewController?
    var dataStore: MovieListDataStore?
    
    func displayMovieDetail(with movie: MD_Movie?) {
        
        let identifier = "MovieDetailViewController"
        guard let detailViewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: identifier) as? MovieDetailViewController else { return }
        detailViewController.router?.dataStore?.movie = movie
        detailViewController.delegate = viewController
        detailViewController.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func displayFavoriteMovie(response: MovieList.Response) {
        
        let identifier = "MovieFavoriteViewController"
        guard let favViewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: identifier) as? MovieFavoriteViewController else { return }
        favViewController.delegate = viewController
        favViewController.modalPresentationStyle = .fullScreen
        favViewController.router?.dataStore?.movieList = response.filterMovieList
        viewController?.navigationController?.pushViewController(favViewController, animated: true)
    }
    
    func displayLogin() {
        
        let identifier = "LoginViewController"
        guard let loginViewController = UIStoryboard(name: "Authen", bundle: nil).instantiateViewController(withIdentifier: identifier) as? LoginViewController else { return }
        loginViewController.modalPresentationStyle = .fullScreen

        let nav = UINavigationController(rootViewController: loginViewController)
        nav.modalPresentationStyle = .fullScreen
        viewController?.present(nav, animated: true)
    }
}
