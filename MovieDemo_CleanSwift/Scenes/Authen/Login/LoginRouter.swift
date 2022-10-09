//
//  LoginRouter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func displayRegister() {
        viewController?.presentRegisterView()
    }
}
