//
//  MovieRemote.swift
//  MovieDemo
//
//  Created by Foodstory on 5/10/2565 BE.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

public class MovieRemote {
    
    static let shared = MovieRemote()
    
    var db: Firestore?
    var ref: DatabaseReference!

    init() {
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        ref = Database.database().reference()
    }
    
    func fetchMovie(with name: String, completion: @escaping (_ success: Bool, _ errorMessage: String?, _ result: [Movie]?)-> Void) {
        
        MovieService.getMovie(with: name) { success, errorMessage, result in
            
            completion(success, errorMessage, result)
        }
    }
    
    func fetchMovieFavorite(of userId: String,
                            completion: @escaping (_ success: Bool, _ errorMessage: String?, _ result: QuerySnapshot?)-> Void) {
                
        db?.collection(userId).getDocuments() { (querySnapshot, err) in
            
            completion(err == nil, err?.localizedDescription, querySnapshot)
        }
    }
    
    func updateMovieStatus(documentId: String?, movie: MD_Movie?, userId: String?,
                           completion: @escaping (_ success: Bool, _ errorMessage: String?)-> Void) {
        
        guard let currentUserId = userId, let updateMovie = movie else {
            completion(false, nil)
            return
        }
        
        var movieDocumentId: String? = documentId
        
        if updateMovie.isFav {
            
            setFavoriteMovie(with: movie, userId: currentUserId) { success, errorMessage, responseDocumentId in
                
                if let value = responseDocumentId {
                    
                    completion(true, nil)
                    MovieLocal.shared.saveMovieStatus(of: movie, isFav: true, documentId: value)
                }
            }
            
        }else {
                        
            if (movieDocumentId?.count ?? 0) <= 0 {
                movieDocumentId = MovieLocal.shared.fetchMovie(from: updateMovie.title ?? "")?.documentId ?? ""
            }
            
            guard (movieDocumentId?.count ?? 0) > 0 else {
                completion(false, nil)
                return
            }
            
            removeFavoriteMovie(from: currentUserId, documentId: movieDocumentId ?? "") { success, errorMessage in
                
                completion(true, nil)
                MovieLocal.shared.saveMovieStatus(of: movie, isFav: false, documentId: "")
            }
        }
    }
    
    func setFavoriteMovie(with movie: MD_Movie?, userId: String,
                           completion: @escaping (_ success: Bool, _ errorMessage: String?, _ documentId: String?)-> Void) {
        
        guard let updatedMovie = movie else {
            completion(false, nil, nil)
            return
        }
        
        var ref: DocumentReference? = nil
        
        ref = db?.collection(userId).addDocument(data: [
            "malId": updatedMovie.malId,
            "title": updatedMovie.title ?? "",
            "score": updatedMovie.score,
            "image": updatedMovie.image ?? "",
            "small_image": updatedMovie.smallImage ?? "",
            "large_image": updatedMovie.largeImage ?? ""
        ]) { err in
            
            completion(err == nil, err?.localizedDescription, ref?.documentID)
        }
    }
    
    func removeFavoriteMovie(from userId: String, documentId: String,
                             completion: @escaping (_ success: Bool, _ errorMessage: String?)-> Void) {
        
        db?.collection(userId).document(documentId).delete { error in
            
            print(error?.localizedDescription)
            completion(error == nil, error?.localizedDescription)
        }
    }
}
