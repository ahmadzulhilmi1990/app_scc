//
//  News.swift
//  SupplyChainCity
//
//  Created by user on 18/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation

class News {
    
    var id: String?
    var news_id: String?
    var news_type: String?
    var news_title: String?
    var news_description: String?
    var news_image: String?
    var created_at: String?
    var updated_at: String?
    var current_page: String?
    
    init(id: String, news_id: String, news_type: String, news_title: String, news_description: String,news_image: String, created_at: String, updated_at: String, current_page: String) {
        
        self.id = id
        self.news_id = news_id
        self.news_type = news_type
        self.news_title = news_title
        self.news_description = news_description
        self.news_image = news_image
        self.created_at = created_at
        self.updated_at = updated_at
        self.current_page = current_page
        
    }
}
