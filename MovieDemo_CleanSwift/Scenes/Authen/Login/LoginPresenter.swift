//
//  LoginPresenter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginPresenter {
    var viewController: LoginDisplayLogic?
    
    required init(viewController: LoginDisplayLogic? = nil) {
        self.viewController = viewController
    }
}

extension LoginPresenter: LoginPresentationLogic {
    
    func presentSomethingOnSuccess(response: Login.Response) {
        let viewModel = Login.ViewModel()
        viewController?.displaySomethingOnSuccess(viewModel: viewModel)
    }

    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage: errorMessage)
    }
}
