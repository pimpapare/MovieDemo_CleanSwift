//
//  MovieFavoriteRouter.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieFavoriteRouter: NSObject, MovieFavoriteRoutingLogic, MovieFavoriteDataPassing {
    weak var viewController: MovieFavoriteViewController?
    var dataStore: MovieFavoriteDataStore?
}
