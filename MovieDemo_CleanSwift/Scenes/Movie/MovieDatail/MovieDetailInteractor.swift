//
//  MovieDetailInteractor.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieDetailInteractor {
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorkerProtocol?

    required init(presenter: MovieDetailPresentationLogic? = nil,
                  worker: MovieDetailWorkerProtocol? = MovieDetailWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension MovieDetailInteractor: MovieDetailDataStore, MovieDetailBusinessLogic {
    func doSomething(request: MovieDetail.Something.Request) {
        worker?.doSomeWork()
        
        let response = MovieDetail.Something.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
}
