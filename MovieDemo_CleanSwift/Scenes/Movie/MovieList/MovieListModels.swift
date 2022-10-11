//
//  MovieListModels.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum MovieList {
    
    struct Request{
        
        var searchText: String?
        var allAnieme: [Movie] = [Movie]()
        
        var user: MD_User?
        var updatedMovie: MD_Movie?
    }
    
    struct Response{
       
        var user: MD_User?
        var movieList: [MD_Movie]?
        var filterMovieList: [MD_Movie]?
    }
    
    struct ViewModel{
        
        var user: MD_User?

        var searchText: String = "naruto"
        
        var movieList: [MD_Movie]?
        var filterMovieList: [MD_Movie]?
    }
}
