//
//  MovieFavoritePresenter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieFavoritePresenter {
    var viewController: MovieFavoriteDisplayLogic?
    
    required init(viewController: MovieFavoriteDisplayLogic? = nil) {
        self.viewController = viewController
    }
}

extension MovieFavoritePresenter: MovieFavoritePresentationLogic {
    
    func presentSomethingOnSuccess(response: MovieFavorite.Response) {
        let viewModel = MovieFavorite.ViewModel()
        viewController?.displaySomethingOnSuccess(viewModel: viewModel)
    }

    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage: errorMessage)
    }
}
