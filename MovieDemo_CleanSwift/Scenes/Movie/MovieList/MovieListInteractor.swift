//
//  MovieListInteractor.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieListInteractor: MovieListDataStore, MovieListBusinessLogic {
    
    var presenter: MovieListPresentationLogic?
    var worker: MovieListWorkerProtocol?

    var movie: MD_Movie?
    var movieList: [MD_Movie]?

    required init(presenter: MovieListPresentationLogic? = nil,
                  worker: MovieListWorkerProtocol? = MovieListWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
        
    func filterMovie(with searchText: String, movies: [MD_Movie]?) {
        
        let filterMovie = movies?.filter { movie in
            return (movie.title ?? "").contains(searchText)
        }
        
        var filterMovieList: [MD_Movie]?
        
        if filterMovie?.count == 0, searchText.count == 0 {
            
            filterMovieList = movies
        
        }else {

            filterMovieList = filterMovie
        }
        
        let response = MovieList.Response(movieList: movies, filterMovieList: filterMovieList)
        presenter?.fetchMovieListSuccess(response: response)
    }
    
    func fetchMovie(request: MovieList.Request) {
        
        presenter?.presentLoader(true)
        
        worker?.fetchMovie(request: request, completion: { success, errorMessage, result in
            
            let response = MovieList.Response(user: request.user, movieList: result, filterMovieList: result)
            self.presenter?.fetchMovieListSuccess(response: response)
            self.presenter?.presentLoader(false)
        })
    }
    
    func fetchLocalMovieList() {
        
        presenter?.presentLoader(true)
        
        worker?.fetchLocalMovieList(completion: { movieList in
            
            let response = MovieList.Response(movieList: movieList, filterMovieList: movieList)
            self.presenter?.fetchMovieListSuccess(response: response)
            self.presenter?.presentLoader(false)
        })
    }
    
    func updateMovieStatus(request: MovieList.Request) {
        
        presenter?.presentLoader(true)
        
        worker?.updateMovieStatus(request: request, completion: { success, errorMessage in
            
            if let error = errorMessage {
                self.presenter?.presentErrorMessage(errorMessage: error)
            }
            
            self.presenter?.presentLoader(false)
        })
    }

    func userSignout() {
        
        presenter?.presentLoader(true)
        
        worker?.userSignout(completion: { success, errorMessage in
            
            if let error = errorMessage {
                self.presenter?.presentErrorMessage(errorMessage: error)
            }
            
            self.presenter?.presentLoader(false)
        })
    }
    
    func doSomething(request: MovieList.Request) {
        
        let response = MovieList.Response()
        presenter?.presentSomethingOnSuccess(response: response)
    }
    
    func displayMovieFavorite(viewModel: MovieList.ViewModel) {
        
        let favoriteMovie = viewModel.movieList?.filter { movie in
            return movie.isFav == true
        }
        
        var response = MovieList.Response()
        response.filterMovieList = favoriteMovie
        presenter?.presentFavoriteMovie(response: response)
    }
}
