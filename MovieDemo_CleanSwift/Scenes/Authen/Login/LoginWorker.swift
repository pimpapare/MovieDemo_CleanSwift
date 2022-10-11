//
//  LoginWorker.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginWorker: LoginWorkerProtocol {
    
    func userSignin(with email: String, password: String,
                    completion: @escaping (_ user: MD_User?, _ errorMessage: String?)-> Void) {
        
        AuthenRemote.shared.userSignin(with: email, password: password) { result, errorMessage in
            
            if let value = result {
                
                let user = AuthenLocal.shared.saveUser(email, userId: value.user.uid)
                completion(user, errorMessage)
                
            }else {
                
                completion(nil, errorMessage)
            }
        }
    }
}
