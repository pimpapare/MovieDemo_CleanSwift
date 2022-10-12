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
    
    func presentLogin() {
        viewController?.presentLogin()
    }
    
    func presentLoader(_ isLoading: Bool) {
        viewController?.displayLoading(isLoading)
    }

    func fetchMovieListSuccess(response: MovieList.Response) {
        
        let viewModel = MovieList.ViewModel(movieList: response.movieList,
                                            filterMovieList: response.filterMovieList)
        viewController?.fetchMovieListSuccess(viewModel: viewModel)
    }
    
    func updateMovieStatusSuccess(response: MovieList.Response) {
        
    }

    func userSignoutSucess(response: MovieList.Response) {
        
    }
    
    func presentSomethingOnSuccess(response: MovieList.Response) {
        let viewModel = MovieList.ViewModel()
        viewController?.displaySomethingOnSuccess(viewModel: viewModel)
    }

    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage: errorMessage)
    }
    
    func presentFavoriteMovie(response: MovieList.Response) {
        viewController?.presentFavoriteMovie(response: response)
    }
}
