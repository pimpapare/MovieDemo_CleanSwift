//
//  MovieDetailProtocol.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol MovieDetailDisplayLogic {
    func displaySomethingOnSuccess(viewModel: MovieDetail.Something.ViewModel)
    func displayErrorMessage(errorMessage: String)   
}

//MARK: Interactor
protocol MovieDetailBusinessLogic {
    func doSomething(request: MovieDetail.Something.Request)
}

//MARK: Presenter
protocol MovieDetailPresentationLogic {
    func presentSomethingOnSuccess(response: MovieDetail.Something.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
@objc protocol MovieDetailWorkerProtocol {
    func doSomeWork()
}

//MARK: Routable
@objc protocol MovieDetailRoutingLogic {

}

//MARK: DataStore
protocol MovieDetailDataStore {

}

//MARK: DataPassing
protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get }
}
