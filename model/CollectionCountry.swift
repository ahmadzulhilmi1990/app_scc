//
//  CollectionCountry.swift
//  SupplyChainCity
//
//  Created by user on 26/07/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation

class CollectionCountry {
    
    var id: String!
    var country_name: String?
    var country_code: String?
    var country_phone_code: String?
    
    
    init(id: String, country_name: String, country_code: String, country_phone_code: String) {
        
        self.id = id
        self.country_name = country_name
        self.country_code = country_code
        self.country_phone_code = country_phone_code
        
    }
}
