//
//  MovieDetailModels.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum MovieDetail {
    
    struct Request{
        
        var movie: MD_Movie?
        var userId: String?
    }
    
    struct Response{
        
    }
    
    struct ViewModel{
        
        var movie: MD_Movie?
        var user: MD_User?
    }
}
