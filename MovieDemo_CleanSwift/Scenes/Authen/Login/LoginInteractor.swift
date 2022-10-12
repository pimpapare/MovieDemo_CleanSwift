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
    
    func verifyForm(request: Login.Request) {
        
        presenter?.presentLoader(true)

        guard let email = request.email, email.count > 0,
                let password = request.password, password.count > 0 else {
            presenter?.presentErrorMessage(errorMessage: "Please input username or password")
            return
        }
        
        userSignin(with: email, password: password)
    }
    
    func userSignin(with email: String, password: String) {
                
        worker?.userSignin(with: email, password: password, completion: { [weak self] user, errorMessage in
            
            guard let weakSelf = self else { return }

            if let error = errorMessage {
                weakSelf.presenter?.presentErrorMessage(errorMessage: error)
            }else {
             
                var response = Login.Response()
                response.user = user
                weakSelf.presenter?.userSigninSuccess(response: response)
            }
        })
    }
    
    func doSomething(request: Login.Request) {
        
        let response = Login.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
}
