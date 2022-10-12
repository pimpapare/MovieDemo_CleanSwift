//
//  MovieDetailWorker.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieDetailWorker: MovieDetailWorkerProtocol {
    
    func updateMovieStatus(request: MovieDetail.Request,
                           completion: @escaping (_ success: Bool, _ errorMessage: String?, _ documentId: String?)-> Void) {
        
        MovieRemote.shared.updateMovieStatus(documentId: request.movie?.documentId,
                                             movie: request.movie, userId: request.userId) { success, errorMessage, documentId in
            
            completion(success, errorMessage, documentId)
        }
    }
}
