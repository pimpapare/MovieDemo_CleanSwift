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
    func displaySomethingOnSuccess(viewModel: MovieList.Something.ViewModel)
    func displayErrorMessage(errorMessage: String)   
}

//MARK: Interactor
protocol MovieListBusinessLogic {
    func doSomething(request: MovieList.Something.Request)
}

//MARK: Presenter
protocol MovieListPresentationLogic {
    func presentSomethingOnSuccess(response: MovieList.Something.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
@objc protocol MovieListWorkerProtocol {
    func doSomeWork()
}

//MARK: Routable
@objc protocol MovieListRoutingLogic {

}

//MARK: DataStore
protocol MovieListDataStore {

}

//MARK: DataPassing
protocol MovieListDataPassing {
    var dataStore: MovieListDataStore? { get }
}
