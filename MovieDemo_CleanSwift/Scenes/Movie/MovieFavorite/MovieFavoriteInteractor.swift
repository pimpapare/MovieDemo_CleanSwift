//
//  MovieFavoriteInteractor.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieFavoriteInteractor {
    
    var presenter: MovieFavoritePresentationLogic?
    var worker: MovieFavoriteWorkerProtocol?

    var movieList: [MD_Movie]?

    required init(presenter: MovieFavoritePresentationLogic? = nil,
                  worker: MovieFavoriteWorkerProtocol? = MovieFavoriteWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension MovieFavoriteInteractor: MovieFavoriteDataStore, MovieFavoriteBusinessLogic {
        
    func doSomething(request: MovieFavorite.Request) {
        
        worker?.doSomeWork()
        
        let response = MovieFavorite.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
}
