//
//  MovieListWorker.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieListWorker: MovieListWorkerProtocol {
    
    func fetchLocalMovieList(completion: @escaping (_ movieList: [MD_Movie]?)-> Void) {
    
        let movieList = MovieLocal.shared.fetchMovies()
        completion(movieList)
    }
    
    func userSignout(completion: @escaping (_ success: Bool, _ errorMessage: String?)-> Void) {
    
        AuthenRemote.shared.userSignout { success, errorMessage in
            
            completion(success, errorMessage)
        }
    }

    func fetchMovie(request: MovieList.Request,
                    completion: @escaping (_ success: Bool, _ errorMessage: String?,
                                           _ result: [MD_Movie]?)-> Void) {
        
        MovieRemote.shared.fetchMovie(with: request.searchText ?? "") { success, errorMessage, result in
            
            if let value = result {
                
                var favRequest = request
                favRequest.allAnieme = value
                
                self.fetchMovieFavorite(request: favRequest) { success, errorMessage, response in
                    
                    completion(success, errorMessage, response)
                }
                
            }else {
                
                completion(success, errorMessage, nil)
            }
        }
    }
    
    func fetchMovieFavorite(request: MovieList.Request,
                            completion: @escaping (_ success: Bool, _ errorMessage: String?, _ result: [MD_Movie]?)-> Void) {
        
        let allAnieme = request.allAnieme
        
        guard let userId = request.user?.userId, userId.count > 0 else {
            
            let savedMovies = MovieLocal.shared.saveMovies(from: allAnieme)
            completion(true, nil, savedMovies)
            
            return
        }

        MovieRemote.shared.fetchMovieFavorite(of: userId) { success, errorMessage, result in
            
            MovieLocal.shared.removeMovies()
                        
            if let queries = result {
                
                for document in queries.documents {
                    
                    let data = document.data()
                    let title = data["title"] as? String
                    
                    if let row = allAnieme.firstIndex(where: {$0.title == title}) {
                        allAnieme[row].isFav = true
                        allAnieme[row].documentId = document.documentID
                    }
                }
            }
            
            let savedMovies = MovieLocal.shared.saveMovies(from: allAnieme)
            completion(success, errorMessage, savedMovies)
        }
    }
}

extension MovieListWorker {
    
    func updateMovieStatus(request: MovieList.Request,
                           completion: @escaping (_ success: Bool, _ errorMessage: String?)-> Void) {
        
        MovieRemote.shared.updateMovieStatus(documentId: request.updatedMovie?.documentId,
                                             movie: request.updatedMovie, userId: request.user?.userId) { success, errorMessage in
            
            completion(success, errorMessage)
        }
    }
}
