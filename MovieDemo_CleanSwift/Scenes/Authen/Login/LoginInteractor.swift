//
//  LoginInteractor.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginInteractor {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkerProtocol?

    required init(presenter: LoginPresentationLogic? = nil,
                  worker: LoginWorkerProtocol? = LoginWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension LoginInteractor: LoginDataStore, LoginBusinessLogic {
    func doSomething(request: Login.Request) {
        worker?.doSomeWork()
        
        let response = Login.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
}
