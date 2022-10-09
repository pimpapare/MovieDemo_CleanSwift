//
//  RegisterInteractor.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class RegisterInteractor {
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorkerProtocol?

    required init(presenter: RegisterPresentationLogic? = nil,
                  worker: RegisterWorkerProtocol? = RegisterWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension RegisterInteractor: RegisterDataStore, RegisterBusinessLogic {
    func doSomething(request: Register.Something.Request) {
        worker?.doSomeWork()
        
        let response = Register.Something.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
}
