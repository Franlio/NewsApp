//
//  ArticleModel.swift
//  NewsApp
//
//  Created by 廖翊淳 on 2020/3/19.
//  Copyright © 2020 Yi-Chun Liao. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol {
    
    func articlesRetrieved(_ articles:[Article])
    
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        
        // Fire off the request to the API
        
        // Create a string URL
        let stringUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4a69315943df42ebaab0ec0afe70e263"
        
        // Create a URL object
        let url = URL(string: stringUrl)
        
        // Check that it isn't nil
        guard url != nil else {
            
            print("Couldn't create url object")
            return
            
        }
        
        // Get the URL Session
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there are no errors and that there is data
            if error == nil && data != nil {
                
                // Attempt to parse the JSON
                let decoder = JSONDecoder()
                
                do {
                    
                    // Parse the JSON into ArticleService
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    
                    // Get the articles
                    let articles = articleService.articles!
                    
                    // Pass it back to the view controller in the main thread
                    DispatchQueue.main.async {
                        
                        self.delegate?.articlesRetrieved(articles)
                        
                    }
                } catch {
                    
                    print("Error parsing the JSON")
                    
                } // End Do - Catch
            } // End if
        } // End Data Task
        
        // Start the data task
        dataTask.resume()
        
    }
    
}
