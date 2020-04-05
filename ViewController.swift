//
//  ViewController.swift
//  NewsApp
//
//  Created by 廖翊淳 on 2020/3/19.
//  Copyright © 2020 Yi-Chun Liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = ArticleModel()
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set the viewcontroller as the datasource and delegate of the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the articles from the article model
        model.delegate = self
        model.getArticles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Detect the index path the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            
            // The user hasn't selected anything
            return
            
        }
        
        // Get the article the user tapped on
        let article = articles[indexPath!.row]
        
        // Get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Pass the article URL to the detail view controller
        detailVC.articleUrl = article.url!
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // Get the article that the tableview is asking about
        let article = articles[indexPath.row]
        
        // TODO: Customize it
        cell.displayArticle(article)
        
        // Return the cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // User has just selected a row, trigger the segue to go to detail
        performSegue(withIdentifier: "goToDetail", sender: self)
        
    }
}

extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Method
    func articlesRetrieved(_ articles: [Article]) {
        
        // Set the articles property of the view controller to the articles passed back from the model
        self.articles = articles
        
        // Refresh the tableview
        tableView.reloadData()
        
    }
    
}
