//
//  RegisterProtocol.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation

//MARK: ViewController
protocol RegisterDisplayLogic {
    
    func setTableViewHeight(with height: CGFloat)

    func displayLoading(_ isLoading: Bool)
    func displayLogin()

    func displaySomethingOnSuccess(viewModel: Register.ViewModel)
    func displayErrorMessage(errorMessage: String)
}

//MARK: Interactor
protocol RegisterBusinessLogic {
    
    func setTableViewHeight(with visibleCells: [UITableViewCell])
    func verifyForm(request: Register.Request)
    func doSomething(request: Register.Request)
}

//MARK: Presenter
protocol RegisterPresentationLogic {
    
    func setTableViewHeight(with height: CGFloat)
    
    func presentLoader(_ isLoading: Bool)
    func userSignupSuccess(response: Register.Response?)
    
    func presentSomethingOnSuccess(response: Register.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
@objc protocol RegisterWorkerProtocol {
    
    func userSignup(with email: String, password: String,
                    completion: @escaping (_ user: MD_User?, _ errorMessage: String?)-> Void)
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
