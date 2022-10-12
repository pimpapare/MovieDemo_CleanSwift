//
//  MovieListProtocol.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol MovieListDisplayLogic {
    
    func presentLogin()
    func displayLoading(_ isLoading: Bool)

    func fetchMovieListSuccess(viewModel: MovieList.ViewModel)
    func presentFavoriteMovie(response: MovieList.Response)
    
    func displaySomethingOnSuccess(viewModel: MovieList.ViewModel)
    func displayErrorMessage(errorMessage: String)
}

//MARK: Interactor
protocol MovieListBusinessLogic {
    
    func filterMovie(with searchText: String, movies: [MD_Movie]?)
    
    func fetchMovie(request: MovieList.Request)
    func fetchLocalMovieList()
    
    func updateMovieStatus(request: MovieList.Request)
    
    func userSignout()
    func doSomething(request: MovieList.Request)
    
    func displayMovieFavorite(viewModel: MovieList.ViewModel)
}

//MARK: Presenter
protocol MovieListPresentationLogic {
    
    func presentLogin()
    func presentLoader(_ isLoading: Bool)

    func fetchMovieListSuccess(response: MovieList.Response)
    
    func updateMovieStatusSuccess(response: MovieList.Response)
    
    func userSignoutSucess(response: MovieList.Response)
    func presentFavoriteMovie(response: MovieList.Response)
    
    func presentSomethingOnSuccess(response: MovieList.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
protocol MovieListWorkerProtocol {
    
    func fetchMovie(request: MovieList.Request, completion: @escaping (_ success: Bool, _ errorMessage: String?, _ result: [MD_Movie]?)-> Void)
    func fetchMovieFavorite(request: MovieList.Request, completion: @escaping (_ success: Bool, _ errorMessage: String?, _ result: [MD_Movie]?)-> Void)
    func updateMovieStatus(request: MovieList.Request, completion: @escaping (_ success: Bool, _ errorMessage: String?)-> Void)
    
    func fetchLocalMovieList(completion: @escaping (_ movieList: [MD_Movie]?)-> Void)
    func userSignout(completion: @escaping (_ success: Bool, _ errorMessage: String?)-> Void)
}

//MARK: Routable
protocol MovieListRoutingLogic {
    
    func displayLogin()
    func displayFavoriteMovie(response: MovieList.Response)
    func displayMovieDetail(with movie: MD_Movie?)
}

//MARK: DataStore
protocol MovieListDataStore {
    
    var movie: MD_Movie? { get }
    var movieList: [MD_Movie]? { get }
}

//MARK: DataPassing
protocol MovieListDataPassing {
    var dataStore: MovieListDataStore? { get }
}
