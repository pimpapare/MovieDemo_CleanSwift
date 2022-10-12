//
//  MovieDetailInteractor.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieDetailInteractor {
    
    var movie: MD_Movie?
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorkerProtocol?

    required init(presenter: MovieDetailPresentationLogic? = nil,
                  worker: MovieDetailWorkerProtocol? = MovieDetailWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension MovieDetailInteractor: MovieDetailDataStore, MovieDetailBusinessLogic {
        
    func displayWebsite(with movie: MD_Movie?) {

        guard let url = URL(string: movie?.url ?? "") else { return }
        presenter?.presentSafari(with: url)
    }

    func doSomething(request: MovieDetail.Request) {
                
        let response = MovieDetail.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
    
    func updateMovieStatus(request: MovieDetail.Request) {
        
        worker?.updateMovieStatus(request: request, completion: { success, errorMessage, documentId in
            
            if let error = errorMessage {
                self.presenter?.presentErrorMessage(errorMessage: error)
            }else {
                self.presenter?.updateMovieStatusSuccess(with: request.movie, documentId: documentId)
            }
        })
    }
}
