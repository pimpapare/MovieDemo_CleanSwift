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
    
    func displayLoading(_ isLoading: Bool)
    func displayMovieList(with user: MD_User?)

    func displaySomethingOnSuccess(viewModel: Login.ViewModel)
    func displayErrorMessage(errorMessage: String)   
}

//MARK: Interactor
protocol LoginBusinessLogic {
    
    func verifyForm(request: Login.Request)
    func doSomething(request: Login.Request)
}

//MARK: Presenter
protocol LoginPresentationLogic {
    
    func presentLoader(_ isLoading: Bool)
    func userSigninSuccess(response: Login.Response?)

    func presentSomethingOnSuccess(response: Login.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
@objc protocol LoginWorkerProtocol {
    
    func userSignin(with email: String, password: String,
                    completion: @escaping (_ user: MD_User?, _ errorMessage: String?)-> Void)
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
