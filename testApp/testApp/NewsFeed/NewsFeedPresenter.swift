//
//  NewsFeedPresenter.swift
//  testApp
//
//  Created by Alexander Galkin on 26/04/2019.
//  Copyright © 2019 Alexander Galkin. All rights reserved.
//

import Foundation

protocol NewsFeedPresenterProtocol: class {
    func configureVeiw()
    func getNewsListFromJson(data: Data?)
    func getNewsList(from index: Int)
    func openUrl(with urlString: String)
    func updateNews()
}

class NewsFeedPresenter: NewsFeedPresenterProtocol {
    
    weak var view: NewsFeedViewProtocol!
    var interactor: NewsFeedInteractorProtocol!
    var router: NewsFeedRouterProtocol!
    var articles: Articles!
    private let newsOnPage = 20
    
    required init(view: NewsFeedViewProtocol) {
        self.view = view
    }
    
    func configureVeiw() {
        view.hideTable()
        view.showLoading()
        interactor.getNewsList(page: 1)
    }
    
    func updateNews() {
        view.hideTable()
        view.showLoading()
        view.newsList = []
        interactor.getNewsList(page: 1)
        view.updateTable()
    }
    
    func getNewsList(from index: Int) {
        guard let totalResults = articles.totalResults, index < totalResults else { return }
        let page = index / newsOnPage + 1
        interactor.getNewsList(page: page)
    }
    
    func getNewsListFromJson(data: Data?) {
        if let responseData = data {
            do {
                articles = try JSONDecoder().decode(Articles.self, from: responseData)
                if let news = articles.articles {
                    view.newsList += news
                    view.hideLoading()
                    view.showTable()
                }
            } catch let error as NSError {
                view.hideLoading()
                view.showMessage(text: error.localizedDescription)
                print("Error: \(error)")
            }

        }
    }
    
    func openUrl(with urlString: String) {
        interactor.openUrl(with: urlString)
    }
}
