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
                
                /*
 
                 "about_me" = "<null>";
                 "country_code" = "<null>";
                 "created_at" = "2018-05-14 04:39:01";
                 email = "ahmadzulhilmi1990@gmail.com";
                 facebook = "<null>";
                 "focus_code" = "<null>";
                 fullname = "<null>";
                 gender = "<null>";
                 id = 2;
                 instagram = "<null>";
                 "is_active" = Y;
                 linkedIn = "<null>";
                 password = e99a18c428cb38d5f260853678922e03;
                 "phone_no" = "<null>";
                 "role_code" = "<null>";
                 type = T;
                 "updated_at" = "2018-05-14 04:39:01";
                 "user_id" = kh1IGFu;
                 username = nemi;
                 "verify_token" = "$2y$10$L.VudRqS.LMdDUtzoYcj1e4oAvhGqv9.LCAufuRtlC5NSvY6nSHy";
                 
                */
                
            }
            
        }
    }
    
    func onGenerateAllData(){
        let data = SysPara.ARRAY_ALL_DATA
        if let arr = data {
            let focus_area = arr["focus_area"] as? [[String:Any]]
            let country = arr["country"] as? [[String:Any]]
            let experience_role = arr["experience_role"] as? [[String:Any]]
            
            //SysPara.ARRAY_FOCUS_AREA = focus_area
            //SysPara.ARRAY_EXPERIENCE_ROLE = String(describing:experience_role)
            //SysPara.ARRAY_COUNTRY = String(describing:country)
            
            //print("*** focus_area : \(String(describing: SysPara.ARRAY_FOCUS_AREA))")
            //print("experience_role : \(String(describing: SysPara.ARRAY_EXPERIENCE_ROLE))")
            //print("country : \(String(describing: SysPara.ARRAY_COUNTRY))")
            
            /*for anItem in focus_area! {
                
                let focus_id = anItem["id"] as Any!
                let focus_name = anItem["focus_name"] as Any!
                let focus_code = anItem["focus_code"] as Any!
                print("focus_id : \(String(describing: focus_id))")
                print("focus_name : \(String(describing: focus_name))")
                print("focus_code : \(String(describing: focus_code))")
                
            }*/
            
        }
    }
    
    func onGenerateNews(data: NSDictionary?){
        
        if let userArr = data {
            let message = userArr["message"]
            let parent_news = userArr["news"] as? NSDictionary
            //print("message : \(String(describing: message))")
            //print("parent_news : \(String(describing: parent_news))")
            
            if let arr = parent_news {
                
                let current_page = arr["current_page"]
                let child_data = arr["data"] as? [[String:Any]]
                print("child_data : \(String(describing: child_data))")
                print("current_page : \(String(describing: current_page))")
                
                for anItem in child_data! {
                    
                    let id = anItem["id"] as Any!
                    let news_id = anItem["news_id"] as Any!
                    let news_type = anItem["news_type"] as Any!
                    let news_title = anItem["news_title"] as Any!
                    let news_description = anItem["news_description"] as Any!
                    let created_at = anItem["created_at"] as Any!
                    let updated_at = anItem["updated_at"] as Any!
                    
                    print("id : \(String(describing: id))")
                    print("news_id : \(String(describing: news_id))")
                    print("news_type : \(String(describing: news_type))")
                    print("news_title : \(String(describing: news_title))")
                    print("news_description : \(String(describing: news_description))")
                    print("created_at : \(String(describing: created_at))")
                    print("updated_at : \(String(describing: updated_at))")
                    
                }
                
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
