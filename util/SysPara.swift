//
//  SysPara.swift
//
//
//  Created by user on 14/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import Foundation
import UIKit

struct SysPara {
    
    /*** CAROUSEL ***/
    static var ARRAY_CAROUSEL = ""
    
    /*** ARRAY ***/
    static var ARRAY_DATA = ""
    
    
    /*** DEVICE DETAILS ***/
    static var DEVICE_MAC_ID = UIDevice.current.identifierForVendor!.uuidString
    static var DEVICE_BRAND = "Apple"
    static var DEVICE_MODEL = UIDevice.current.modelName
    

    /*** UPDATE USER ***/
    static var SESSION_USER_ID = ""
    static var SESSION_USER_NAME = ""
    static var SESSION_USER_LEVEL = ""
    static var SESSION_USER_TYPE = ""
    static var SESSION_USER_PHONE = ""
    static var SESSION_USER_ALLOW_LIST = ""
    
    /*** UITab ***/
    static var SESSION_TAB = 0
    
    /*** MODE ***/
    static var TOKEN = ""
    static var READ = "read"
    static var UPDATE = "update"
    static var DELETE = "delete"
    static var CREATE = "create"
    static var VERIFY = "verify"
    static var NEW = "new"
    static var REMEMBER_ME = ""
    
    /*** USER_PROFILE ***/
    static var ABOUT_ME = ""
    static var COUNTRY_CODE = ""
    static var CREATED_AT = ""
    static var USER_EMAIL = ""
    static var FACEBOOK = ""
    static var FOCUS_CODE = ""
    static var FULLNAME = ""
    static var GENDER = ""
    static var ID = ""
    static var INSTAGRAM = ""
    static var IS_ACTIVE = ""
    static var LINKEDIN = ""
    static var USER_PASSWORD = ""
    static var PHONE_NO = ""
    static var ROLE_CODE = ""
    static var USER_TYPE = ""
    static var UPDATED_AT = ""
    static var USER_ID = ""
    static var USERNAME = ""
    static var VERIFY_TOKEN = ""
    
    /*** USER_DEPARTMENT ***/
    static var dp_id = ""
    static var dp_name = ""
    static var dp_co_id = ""
    static var dp_tms_id = ""
    
    /*** USER_COMPANY ***/
    static var co_id = ""
    static var co_name = ""
    static var co_addr1 = ""
    static var co_addr2 = ""
    static var co_addr3 = ""
    static var co_tel = ""
    static var co_fax = ""
    static var co_tms_id = ""
    static var co_lat = ""
    static var co_lng = ""
    static var co_max_radius = ""
    static var co_timezone = ""
    static var co_gst_no = ""
    
    /*** socket:task ***/
    static var isonline = "0"
    static var task_status = "1"
    static var task_mode = "2"
    
    /*** VARIABLE ***/
    static var ERROR_NETWORK = "No Internet Connection. Make sure your device is connected to the internet."
    static var SUCCESS_UPDATE = "Successfully update data."
    static var SUCCESS_SIGNIN = "Success"
    static var ERROR_SIGNIN = "Failed to Sign In."

    /*** API ***/
    
    static var URL = "http://13.251.53.184/api/v1/"
    static var API_SIGN_IN = URL + "auth/"
    static var API_SIGN_UP = URL + "register/"
    static var API_FORGOT_PASSWORD = URL + "forgotpass/"
    static var API_CAROUSEL = URL + "carousel"
    static var API_CHANGE_PASSWORD = URL + "changepass/"
    static var API_LOGOUT = URL + "logout/"
    static var API_UPDATE_PROFILE = URL + "profile/"
    
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPodTouch5"
        case "iPod7,1":                                 return "iPodTouch6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone4"
        case "iPhone4,1":                               return "iPhone4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone5s"
        case "iPhone7,2":                               return "iPhone6"
        case "iPhone7,1":                               return "iPhone6Plus"
        case "iPhone8,1":                               return "iPhone6s"
        case "iPhone8,2":                               return "iPhone6sPlus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone7Plus"
        case "iPhone8,4":                               return "iPhoneSE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPadAir"
        case "iPad5,3", "iPad5,4":                      return "iPadAir 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPadMini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPadMini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPadMini 3"
        case "iPad5,1", "iPad5,2":                      return "iPadMini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPadPro"
        case "AppleTV5,3":                              return "AppleTV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}
