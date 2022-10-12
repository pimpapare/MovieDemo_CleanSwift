//
//  LaunchPresenter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LaunchPresenter {
    var viewController: LaunchDisplayLogic?
    
    required init(viewController: LaunchDisplayLogic? = nil) {
        self.viewController = viewController
    }
}

extension LaunchPresenter: LaunchPresentationLogic {
    
    func presentLogin() {
        viewController?.presentLogin()
    }
    
    func presentSomethingOnSuccess(response: Launch.Something.Response) {
        let viewModel = Launch.Something.ViewModel()
        viewController?.displaySomethingOnSuccess(viewModel: viewModel)
    }
    
    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage: errorMessage)
    }
}
