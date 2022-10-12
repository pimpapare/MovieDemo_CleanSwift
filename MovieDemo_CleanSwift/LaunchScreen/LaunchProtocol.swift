//
//  LaunchProtocol.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol LaunchDisplayLogic {
    
    func presentLogin()
    func displaySomethingOnSuccess(viewModel: Launch.Something.ViewModel)
    func displayErrorMessage(errorMessage: String)   
}

//MARK: Interactor
protocol LaunchBusinessLogic {
    
    func verifyAuthen()
    func doSomething(request: Launch.Something.Request)
}

//MARK: Presenter
protocol LaunchPresentationLogic {
    
    func presentLogin()
    func presentSomethingOnSuccess(response: Launch.Something.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
@objc protocol LaunchWorkerProtocol {
    func doSomeWork()
}

//MARK: Routable
@objc protocol LaunchRoutingLogic {

    func displayLogin()
    func displayMovieList()
}

//MARK: DataStore
protocol LaunchDataStore {

}

//MARK: DataPassing
protocol LaunchDataPassing {
    var dataStore: LaunchDataStore? { get }
}
