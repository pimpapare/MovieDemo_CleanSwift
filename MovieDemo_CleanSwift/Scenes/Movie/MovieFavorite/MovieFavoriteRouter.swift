//
//  MovieFavoriteRouter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieFavoriteRouter: NSObject, MovieFavoriteRoutingLogic, MovieFavoriteDataPassing {
    
    weak var viewController: MovieFavoriteViewController?
    var dataStore: MovieFavoriteDataStore?
    
    func displayMovieDetail(with movie: MD_Movie?) {
        
        let identifier = "MovieDetailViewController"
        guard let detailViewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: identifier) as? MovieDetailViewController else { return }
        detailViewController.router?.dataStore?.movie = movie
        detailViewController.delegate = viewController
        detailViewController.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
