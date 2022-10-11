//
//  MovieDetailPresenter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieDetailPresenter {
    var viewController: MovieDetailDisplayLogic?
    
    required init(viewController: MovieDetailDisplayLogic? = nil) {
        self.viewController = viewController
    }
}

extension MovieDetailPresenter: MovieDetailPresentationLogic {
    
    func updateMovieStatusSuccess() {
        viewController?.updateMovieStatusSuccess()
    }

    func presentSafari(with url: URL) {
        viewController?.presentSafari(with: url)
    }
    
    func presentSomethingOnSuccess(response: MovieDetail.Response) {
        let viewModel = MovieDetail.ViewModel()
        viewController?.displaySomethingOnSuccess(viewModel: viewModel)
    }

    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage: errorMessage)
    }
}
