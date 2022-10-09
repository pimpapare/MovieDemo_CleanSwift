//
//  MovieFavoriteViewController.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieFavoriteViewController: UIViewController {
    
    var interactor: MovieFavoriteBusinessLogic?
    var router: (MovieFavoriteRoutingLogic & MovieFavoriteDataPassing)?

    // MARK: @IBOutlet

    // MARK: Data
    
    // MARK: View lifecycle
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
        // set view something
    }
    
    // MARK: Do something
    func doSomething() {
        let request = MovieFavorite.Something.Request()
        interactor?.doSomething(request: request)
    }
}

extension MovieFavoriteViewController : MovieFavoriteDisplayLogic {
    func displaySomethingOnSuccess(viewModel: MovieFavorite.Something.ViewModel) {
        
    }

    func displayErrorMessage(errorMessage: String) {
        
    }
}

// MARK: Setup & Configuration
extension MovieFavoriteViewController {
    private func configure() {
        MovieFavoriteConfiguration.shared.configure(self)
    }
}
