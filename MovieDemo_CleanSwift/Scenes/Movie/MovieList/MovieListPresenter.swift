//
//  MovieListPresenter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieListPresenter {
    var viewController: MovieListDisplayLogic?
    
    required init(viewController: MovieListDisplayLogic? = nil) {
        self.viewController = viewController
    }
}

extension MovieListPresenter: MovieListPresentationLogic {
    
    func presentSomethingOnSuccess(response: MovieList.Something.Response) {
        let viewModel = MovieList.Something.ViewModel()
        viewController?.displaySomethingOnSuccess(viewModel: viewModel)
    }

    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage: errorMessage)
    }
}
