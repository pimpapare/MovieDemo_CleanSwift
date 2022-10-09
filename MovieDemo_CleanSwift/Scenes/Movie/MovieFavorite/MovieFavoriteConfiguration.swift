//
//  MovieFavoriteConfiguration.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class MovieFavoriteConfiguration {
    static let shared: MovieFavoriteConfiguration = MovieFavoriteConfiguration()
    
    func configure(_ viewController: MovieFavoriteViewController) {
        let interactor = MovieFavoriteInteractor()
        let presenter = MovieFavoritePresenter()
        let router = MovieFavoriteRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
