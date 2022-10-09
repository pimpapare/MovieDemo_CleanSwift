//
//  MovieDetailViewController.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var interactor: MovieDetailBusinessLogic?
    var router: (MovieDetailRoutingLogic & MovieDetailDataPassing)?

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
        let request = MovieDetail.Something.Request()
        interactor?.doSomething(request: request)
    }
}

extension MovieDetailViewController : MovieDetailDisplayLogic {
    func displaySomethingOnSuccess(viewModel: MovieDetail.Something.ViewModel) {
        
    }

    func displayErrorMessage(errorMessage: String) {
        
    }
}

// MARK: Setup & Configuration
extension MovieDetailViewController {
    private func configure() {
        MovieDetailConfiguration.shared.configure(self)
    }
}
