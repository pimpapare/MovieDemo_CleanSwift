//
//  MovieDetailProtocol.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol MovieDetailDisplayLogic {
    
    func presentSafari(with url: URL)
    func updateMovieStatusSuccess()
    func displaySomethingOnSuccess(viewModel: MovieDetail.ViewModel)
    func displayErrorMessage(errorMessage: String)   
}

//MARK: Interactor
protocol MovieDetailBusinessLogic {
    
    func updateMovieStatus(request: MovieDetail.Request)
    
    func displayWebsite(with movie: MD_Movie?)
    func doSomething(request: MovieDetail.Request)
}

//MARK: Presenter
protocol MovieDetailPresentationLogic {
    
    func updateMovieStatusSuccess(with movie: MD_Movie?, documentId: String?)
    
    func presentSafari(with url: URL)
    func presentSomethingOnSuccess(response: MovieDetail.Response)
    func presentErrorMessage(errorMessage: String)
}

//MARK: Worker
protocol MovieDetailWorkerProtocol {
    
    func updateMovieStatus(request: MovieDetail.Request,
                           completion: @escaping (_ success: Bool, _ errorMessage: String?, _ documentId: String?)-> Void)
}

//MARK: Routable
@objc protocol MovieDetailRoutingLogic {

    func presentSafari(with url: URL)
}

//MARK: DataStore
protocol MovieDetailDataStore {

    var movie: MD_Movie? { get set }
}

//MARK: DataPassing
protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get set }
}
