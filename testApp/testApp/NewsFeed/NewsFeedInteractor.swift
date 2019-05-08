//
//  NewsFeedInteractor.swift
//  testApp
//
//  Created by Alexander Galkin on 26/04/2019.
//  Copyright © 2019 Alexander Galkin. All rights reserved.
//

import Foundation

protocol NewsFeedInteractorProtocol: class {
    func getNewsList(page: Int)
    func openUrl(with urlString: String)
}

class NewsFeedInteractor: NewsFeedInteractorProtocol {
    
    weak var presenter: NewsFeedPresenterProtocol!
    let serverService = ServerService()
    
    required init(presenter: NewsFeedPresenterProtocol) {
        self.presenter = presenter
    }

    func getNewsList(page: Int) {
        serverService.getNews(language: .ru, page: page) { (data, error) in
            if error != nil {
                print("Error: \(String(describing: error))")
            }
            
            if let newsData = data {
                DispatchQueue.main.async {
                    self.presenter.getNewsListFromJson(data: newsData)
                }
            }
        }
    }
    
    func openUrl(with urlString: String) {
        serverService.openUrl(with: urlString)
    }
}
