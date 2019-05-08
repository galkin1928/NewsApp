//
//  NewsFeedViewController.swift
//  testApp
//
//  Created by Alexander Galkin on 26/04/2019.
//  Copyright © 2019 Alexander Galkin. All rights reserved.
//

import Foundation
import UIKit

protocol NewsFeedViewProtocol: class {
    var newsList: [News] {get set}
    func showLoading()
    func hideLoading()
    func hideTable()
    func showTable()
    func showMessage(text: String)
    func updateTable()
}

class NewsFeedViewController: UIViewController, NewsFeedViewProtocol {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func updateButtonPressed(_ sender: UIBarButtonItem) {
        presenter.updateNews()
    }
    let configurator: NewsFeedConfiguratorProtocol = NewsFeedConfigurator()
    var presenter: NewsFeedPresenterProtocol!
    var newsList = [News]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureVeiw()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.activityIndicator.stopAnimating()
    }
    
    func showTable() {
        tableView.isHidden = false
    }
    
    func hideTable() {
        tableView.isHidden = true
    }
    
    func showMessage(text: String) {
        let vc = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        vc.addAction(action)
        self.present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "newsListToNewsSegue":
            if let indexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: indexPath, animated: true)
                if let dvc = segue.destination as? NewsViewController {
                    dvc.news = self.newsList[indexPath.row]
                }
            }
        default:
            break
        }
    }
}

extension NewsFeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell {
            let news = self.newsList[indexPath.row]
            cell.titleLabel.text = news.title
            cell.descriotionLabel.text = news.description
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == newsList.count - 1 {
            presenter.getNewsList(from: indexPath.row + 1)
        }
    }
}
