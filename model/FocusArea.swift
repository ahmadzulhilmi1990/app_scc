//
//  FocusArea.swift
//  SupplyChainCity
//
//  Created by user on 25/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation

class FocusArea {
    
    var id: String?
    var focus_name: String?
    var focus_code: String?
    
    init(id: String, focus_name: String, focus_code: String) {
        
        self.id = id
        self.focus_name = focus_name
        self.focus_code = focus_code
        
    }
}
