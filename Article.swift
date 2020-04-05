//
//  Article.swift
//  NewsApp
//
//  Created by 廖翊淳 on 2020/3/19.
//  Copyright © 2020 Yi-Chun Liao. All rights reserved.
//

import Foundation

struct Article: Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
}
