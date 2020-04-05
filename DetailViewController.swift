//
//  DetailViewController.swift
//  NewsApp
//
//  Created by 廖翊淳 on 2020/3/21.
//  Copyright © 2020 Yi-Chun Liao. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView.navigationDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check that there's a URL
        if articleUrl != nil {
            
            // Create the URl object
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                
                // Couldn't create the URL object
                return
                
            }
            
            // Create the URLRequest object
            let request = URLRequest(url: url!)
            
            // Start spinner
            spinner.alpha = 1
            spinner.startAnimating()
            
            // Load it in the web view
            webView.load(request)
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Stop the spinner and hide it
        spinner.stopAnimating()
        spinner.alpha = 0
        
    }
    
}
