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
        
        let identifier = "MovieListViewController"
        guard let movieViewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: identifier) as? MovieListViewController else { return }
        movieViewController.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(movieViewController, animated: false)
    }
    
    func displayLogin() {
        
        let identifier = "LoginViewController"
        
        guard let loginViewController = UIStoryboard(name: "Authen", bundle: nil).instantiateViewController(withIdentifier: identifier) as? LoginViewController else { return }
        loginViewController.modalPresentationStyle = .fullScreen
        
        let nav = UINavigationController(rootViewController: loginViewController)
        nav.modalPresentationStyle = .fullScreen
        viewController?.present(nav, animated: true)
    }
}
