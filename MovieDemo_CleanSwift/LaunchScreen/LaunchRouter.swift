//
//  LaunchRouter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LaunchRouter: NSObject, LaunchRoutingLogic, LaunchDataPassing {
    
    weak var viewController: LaunchViewController?
    var dataStore: LaunchDataStore?
    
    func displayMovieList() {
        
        viewController?.presentMovie()
    }
}
