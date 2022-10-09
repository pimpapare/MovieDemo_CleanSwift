//
//  MovieListInteractor.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieListInteractor {
    var presenter: MovieListPresentationLogic?
    var worker: MovieListWorkerProtocol?

    required init(presenter: MovieListPresentationLogic? = nil,
                  worker: MovieListWorkerProtocol? = MovieListWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension MovieListInteractor: MovieListDataStore, MovieListBusinessLogic {
    func doSomething(request: MovieList.Something.Request) {
        worker?.doSomeWork()
        
        let response = MovieList.Something.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
}
