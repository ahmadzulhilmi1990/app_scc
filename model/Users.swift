//
//  Users.swift
//  SupplyChainCity
//
//  Created by user on 04/07/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation

class Users {
    
    var user_id: String!
    var user_email: String?
    var user_fullname: String?
    var user_gender: String?
    var user_role_code: String?
    var user_focus_code: String?
    
    init(user_id: String, user_email: String, user_fullname: String, user_gender: String, user_role_code: String,user_focus_code: String) {
        
        self.user_id = user_id
        self.user_email = user_email
        self.user_fullname = user_fullname
        self.user_gender = user_gender
        self.user_role_code = user_role_code
        self.user_focus_code = user_focus_code
        
    }
}
