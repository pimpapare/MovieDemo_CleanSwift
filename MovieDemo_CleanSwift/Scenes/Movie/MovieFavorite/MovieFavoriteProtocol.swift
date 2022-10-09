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
    func displaySomethingOnSuccess(viewModel: MovieFavorite.Something.ViewModel)
    func displayErrorMessage(errorMessage: String)   
}

//MARK: Interactor
protocol MovieFavoriteBusinessLogic {
    func doSomething(request: MovieFavorite.Something.Request)
}

//MARK: Presenter
protocol MovieFavoritePresentationLogic {
    func presentSomethingOnSuccess(response: MovieFavorite.Something.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
@objc protocol MovieFavoriteWorkerProtocol {
    func doSomeWork()
}

//MARK: Routable
@objc protocol MovieFavoriteRoutingLogic {

}

//MARK: DataStore
protocol MovieFavoriteDataStore {

}

//MARK: DataPassing
protocol MovieFavoriteDataPassing {
    var dataStore: MovieFavoriteDataStore? { get }
}
