//
//  News.swift
//  testApp
//
//  Created by Alexander Galkin on 26/04/2019.
//  Copyright © 2019 Alexander Galkin. All rights reserved.
//

import Foundation

struct Articles: Codable {
    let articles: [News]?
    let totalResults: Int?
}

class News: Codable {
    let title: String?
    let description: String?
    let source: NewsSource?
    let autor: String?
    let url: String?
    let urlToImage: String?
    let content: String?
}

struct NewsSource: Codable {
    let id: String?
    let name: String?
}
