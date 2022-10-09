//
//  RegisterProtocol.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol RegisterDisplayLogic {
    func displaySomethingOnSuccess(viewModel: Register.Something.ViewModel)
    func displayErrorMessage(errorMessage: String)   
}

//MARK: Interactor
protocol RegisterBusinessLogic {
    func doSomething(request: Register.Something.Request)
}

//MARK: Presenter
protocol RegisterPresentationLogic {
    func presentSomethingOnSuccess(response: Register.Something.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
@objc protocol RegisterWorkerProtocol {
    func doSomeWork()
}

//MARK: Routable
@objc protocol RegisterRoutingLogic {

}

//MARK: DataStore
protocol RegisterDataStore {

}

//MARK: DataPassing
protocol RegisterDataPassing {
    var dataStore: RegisterDataStore? { get }
}
