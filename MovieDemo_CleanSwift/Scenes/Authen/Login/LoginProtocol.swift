//
//  LoginProtocol.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol LoginDisplayLogic {
    func displaySomethingOnSuccess(viewModel: Login.Something.ViewModel)
    func displayErrorMessage(errorMessage: String)   
}

//MARK: Interactor
protocol LoginBusinessLogic {
    func doSomething(request: Login.Something.Request)
}

//MARK: Presenter
protocol LoginPresentationLogic {
    func presentSomethingOnSuccess(response: Login.Something.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
@objc protocol LoginWorkerProtocol {
    func doSomeWork()
}

//MARK: Routable
@objc protocol LoginRoutingLogic {

    func displayRegister()
}

//MARK: DataStore
protocol LoginDataStore {

}

//MARK: DataPassing
protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}
