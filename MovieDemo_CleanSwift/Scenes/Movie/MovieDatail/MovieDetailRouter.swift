//
//  MovieDetailRouter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SafariServices

class MovieDetailRouter: NSObject, MovieDetailRoutingLogic, MovieDetailDataPassing {
    
    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailDataStore?
    
    func presentSafari(with url: URL) {
        
        let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        viewController?.present(vc, animated: true)
    }
}
