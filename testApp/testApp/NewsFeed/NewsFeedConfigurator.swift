//
//  NewsFeedConfigurator.swift
//  testApp
//
//  Created by Alexander Galkin on 26/04/2019.
//  Copyright © 2019 Alexander Galkin. All rights reserved.
//

import Foundation

protocol NewsFeedConfiguratorProtocol: class {
    func configure(with viewController: NewsFeedViewController)
}

class NewsFeedConfigurator: NewsFeedConfiguratorProtocol {
    
    func configure(with viewController: NewsFeedViewController) {
        let presenter = NewsFeedPresenter(view: viewController)
        let interactor = NewsFeedInteractor(presenter: presenter)
        let router = NewsFeedRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
