//
//  MovieFavoriteProtocol.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol MovieFavoriteDisplayLogic {
    func displaySomethingOnSuccess(viewModel: MovieFavorite.ViewModel)
    func displayErrorMessage(errorMessage: String)   
}

//MARK: Interactor
protocol MovieFavoriteBusinessLogic {
    func doSomething(request: MovieFavorite.Request)
}

//MARK: Presenter
protocol MovieFavoritePresentationLogic {
    
    func presentSomethingOnSuccess(response: MovieFavorite.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
@objc protocol MovieFavoriteWorkerProtocol {
    func doSomeWork()
}

//MARK: Routable
@objc protocol MovieFavoriteRoutingLogic {

    func displayMovieDetail(with movie: MD_Movie?)
}

//MARK: DataStore
protocol MovieFavoriteDataStore {

    var movieList: [MD_Movie]? { get set }
}

//MARK: DataPassing
protocol MovieFavoriteDataPassing {
    var dataStore: MovieFavoriteDataStore? { get set}
}
