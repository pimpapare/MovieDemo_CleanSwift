//
//  LaunchConfiguration.swift
//  MovieDemo_CleanSwift
//
//  Created by Pimpaphorn Chaichompoo on 9/10/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class LaunchConfiguration {
    static let shared: LaunchConfiguration = LaunchConfiguration()
    
    func configure(_ viewController: LaunchViewController) {
        let interactor = LaunchInteractor()
        let presenter = LaunchPresenter()
        let router = LaunchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
