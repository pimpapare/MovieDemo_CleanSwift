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
        
        viewController?.presentMovieDetail(with: movie)
    }
}
