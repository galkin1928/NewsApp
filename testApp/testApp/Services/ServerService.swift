//
//  ServerService.swift
//  testApp
//
//  Created by Alexander Galkin on 29/04/2019.
//  Copyright © 2019 Alexander Galkin. All rights reserved.
//

import Foundation
import UIKit

enum LanguageNews: String {
    case NA = ""
    case ar = "ar"
    case de = "de"
    case en = "en"
    case es = "es"
    case fr = "fr"
    case he = "he"
    case it = "it"
    case nl = "nl"
    case no = "no"
    case pt = "pt"
    case ru = "ru"
}

protocol ServerServiceProtocol: class {
    func getNews(language: LanguageNews, page: Int, completion: @escaping (Data?, Error?) -> Void)
    func openUrl(with urlString: String)
}

class ServerService: ServerServiceProtocol {
    private let apiKey = "b21884496ea146e59fd4fe704f909045"
    
    func getNews(language: LanguageNews, page: Int, completion: @escaping (Data?, Error?) -> Void) {
        let stringUrl = "https://newsapi.org/v2/everything?language=\(language.rawValue)&page=\(page)&q=apple&sortBy=publishedAt&apiKey=\(apiKey)"
        
        if let url = URL(string: stringUrl) {
            getResponseData(url: url, completion: completion)
        }
    }
    
    func openUrl(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:])
    }
    
    private func getResponseData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
                completion(nil, error)
            }
            
            if let responseData = data {
                completion(responseData, nil)
                return
            }
        }
        task.resume()
    }
}
