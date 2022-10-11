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
    
    func setTableViewHeight(with visibleCells: [UITableViewCell]) {
        
        var height: CGFloat = 0.0

        for cell in visibleCells {
            height += cell.frame.height
        }
        
        presenter?.setTableViewHeight(with: height)
    }
    
    func verifyForm(request: Register.Request) {
        
        presenter?.presentLoader(true)

        guard let email = request.email, email.count > 0,
                let password = request.password, password.count > 0 else {
            presenter?.presentErrorMessage(errorMessage: "Please input valid informaiton")
            return
        }
        
        userSignup(with: email, password: password)
    }
}

extension RegisterInteractor {
    
    func userSignup(with email: String, password: String) {
                
        worker?.userSignup(with: email, password: password, completion: { user, errorMessage in
            
            if let error = errorMessage {
                self.presenter?.presentErrorMessage(errorMessage: error)
            }else {
             
                var response = Register.Response()
                response.user = user
                self.presenter?.userSignupSuccess(response: response)
            }
        })
    }

    func doSomething(request: Register.Request) {
        
        let response = Register.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
}
