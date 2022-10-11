//
//  RegisterPresenter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class RegisterPresenter {
    var viewController: RegisterDisplayLogic?
    
    required init(viewController: RegisterDisplayLogic? = nil) {
        self.viewController = viewController
    }
}

extension RegisterPresenter: RegisterPresentationLogic {
    
    func setTableViewHeight(with height: CGFloat) {
        viewController?.setTableViewHeight(with: height)
    }

    func presentLoader(_ isLoading: Bool) {
        viewController?.displayLoading(isLoading)
    }
    
    func userSignupSuccess(response: Register.Response?) {
        viewController?.displayLogin()
    }
    
    func presentSomethingOnSuccess(response: Register.Response) {
        let viewModel = Register.ViewModel()
        viewController?.displaySomethingOnSuccess(viewModel: viewModel)
    }

    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage: errorMessage)
    }
}
