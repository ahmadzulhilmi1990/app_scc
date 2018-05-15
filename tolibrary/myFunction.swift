//
//  myFunction.swift
//  SupplyChainCity
//
//  Created by user on 15/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation
import UIKit

struct myFunction{
    
    func jsonToString(title: String, json: AnyObject) -> String?{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8)
            print(title + " =  \(String(describing: convertedString))")
            return convertedString!
            
        } catch let myJSONError {
            print(myJSONError)
            return "[]"
        }
    }
    
    func onGenerateCarousel(data: NSDictionary?){
        
        if let carouselArr = data {
            //let status = carouselArr["status"]
            let list = carouselArr["data"] as? NSDictionary
            
            if let arr = list {
                SysPara.ARRAY_CAROUSEL = (arr["list"] as AnyObject) as! String
            }
        }
    }
    
    func onGenerateUser(data: NSDictionary?){
        
        if let userArr = data {
            //let message = userArr["message"]
            //let token = userArr["token"]
            let profile = userArr["profile"] as? NSDictionary
            
            if let arr = profile {
                
                SysPara.ABOUT_ME = nullToNil(value: arr["about_me"] as AnyObject) as! String
                SysPara.COUNTRY_CODE = nullToNil(value: arr["country_code"] as AnyObject) as! String
                SysPara.CREATED_AT = nullToNil(value:arr["created_at"] as AnyObject) as! String
                SysPara.USER_EMAIL = nullToNil(value:arr["email"] as AnyObject) as! String
                SysPara.FACEBOOK = nullToNil(value:arr["facebook"] as AnyObject) as! String
                SysPara.FOCUS_CODE = nullToNil(value:arr["focus_code"] as AnyObject) as! String
                SysPara.FULLNAME = nullToNil(value:arr["fullname"] as AnyObject) as! String
                SysPara.GENDER = nullToNil(value:arr["gender"] as AnyObject) as! String
                SysPara.ID = String(describing: arr["id"] as! Int)
                SysPara.INSTAGRAM = nullToNil(value:arr["instagram"] as AnyObject) as! String
                SysPara.IS_ACTIVE = nullToNil(value:arr["is_active"] as AnyObject) as! String
                SysPara.LINKEDIN = nullToNil(value:arr["linkedin"] as AnyObject) as! String
                SysPara.USER_PASSWORD = nullToNil(value:arr["password"] as AnyObject) as! String
                SysPara.PHONE_NO = nullToNil(value:arr["phone_no"] as AnyObject) as! String
                SysPara.ROLE_CODE = nullToNil(value:arr["role_code"] as AnyObject) as! String
                SysPara.USER_TYPE = nullToNil(value:arr["type"] as AnyObject) as! String
                SysPara.UPDATED_AT = nullToNil(value:arr["updated_at"] as AnyObject) as! String
                SysPara.USER_ID = nullToNil(value:arr["user_id"] as AnyObject) as! String
                SysPara.USERNAME = nullToNil(value:arr["username"] as AnyObject) as! String
                SysPara.VERIFY_TOKEN = nullToNil(value:arr["verify_token"] as AnyObject) as! String
                
            }
            
        }
    }
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return "" as AnyObject
        } else {
            return value
        }
    }
}
