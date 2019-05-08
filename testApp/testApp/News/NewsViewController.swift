//
//  NewsViewController.swift
//  testApp
//
//  Created by Alexander Galkin on 07/05/2019.
//  Copyright © 2019 Alexander Galkin. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class NewsViewController: UIViewController, WKNavigationDelegate {
    var news: News!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        if let news = self.news, let urlString = news.url {
            guard let url = URL(string: urlString) else { return }
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
}
