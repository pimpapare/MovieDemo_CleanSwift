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
    
    func presentLogin() {
        
        router?.displayLogin()
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
