//
//  ExperienceRole.swift
//  SupplyChainCity
//
//  Created by user on 08/08/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation

class ExperienceRole {
    
    var id: String?
    var role_name: String?
    var role_code: String?
    
    init(id: String, role_name: String, role_code: String) {
        
        self.id = id
        self.role_name = role_name
        self.role_code = role_code
        
    }
}
