//
//  LaunchInteractor.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LaunchInteractor {
    
    var presenter: LaunchPresentationLogic?
    var worker: LaunchWorkerProtocol?

    required init(presenter: LaunchPresentationLogic? = nil,
                  worker: LaunchWorkerProtocol? = LaunchWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension LaunchInteractor: LaunchDataStore, LaunchBusinessLogic {
    
    func doSomething(request: Launch.Something.Request) {
        
        worker?.doSomeWork()
        
        let response = Launch.Something.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
    
    func verifyAuthen() {
     
        presenter?.presentLogin()
    }
}
