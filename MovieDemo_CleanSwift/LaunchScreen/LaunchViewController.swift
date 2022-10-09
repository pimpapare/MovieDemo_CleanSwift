//
//  LaunchViewController.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var interactor: LaunchBusinessLogic?
    var router: (LaunchRoutingLogic & LaunchDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        doSomething()
    }

    private func setupView() {

        router?.displayMovieList()
    }
    
    func doSomething() {
        
        verifyAuth()
        
        let request = Launch.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func verifyAuth() {
        
        interactor?.verifyAuthen()
    }
    
    func presentMovie() {
        
        let identifier = "MovieListViewController"
        let viewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: identifier) as? MovieListViewController
        viewController?.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(viewController!, animated: false)
    }
    
    func presentLogin() {
        
        let identifier = "LoginViewController"
        let viewController = UIStoryboard(name: "Authen", bundle: nil).instantiateViewController(withIdentifier: identifier) as? LoginViewController
        viewController?.modalPresentationStyle = .fullScreen
        
        let nav = UINavigationController(rootViewController: viewController!)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}

extension LaunchViewController : LaunchDisplayLogic {
    
    func displaySomethingOnSuccess(viewModel: Launch.Something.ViewModel) {
        
    }

    func displayErrorMessage(errorMessage: String) {
        
    }
}

// MARK: Setup & Configuration
extension LaunchViewController {
    private func configure() {
        LaunchConfiguration.shared.configure(self)
    }
}
