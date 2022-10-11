//
//  LoginModels.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Login {
    
    struct Request{
        
        var email: String?
        var password: String?
        
        var confirmPassword: String?
    }
    
    struct Response{
        var user: MD_User?
    }
    
    struct ViewModel{
        
        
    }
}
