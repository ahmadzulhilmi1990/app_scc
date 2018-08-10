//
//  SettingsViewController.swift
//
//
//  Created by user on 11/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // :widget
    @IBOutlet var alarm_message: UISwitch!
    @IBOutlet var alarm_update: UISwitch!
    @IBOutlet var alarm_location: UISwitch!
    @IBOutlet var txt_title: UILabel!
    @IBOutlet var img_back: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.img_back.image = self.img_back.image!.withRenderingMode(.alwaysTemplate)
        self.img_back.tintColor = hexStringToUIColor(hex: "#FFFFFF")
        // Do any additional setup after loading the view.
        
        //txt_title?.font = UIFont(name: "RNS Camelia", size: 14)!
        
        alarm_message.addTarget(self, action: #selector(switch_message), for: UIControlEvents.valueChanged)
        
        alarm_update.addTarget(self, action: #selector(switch_update), for: UIControlEvents.valueChanged)
        
        alarm_location.addTarget(self, action: #selector(switch_location), for: UIControlEvents.valueChanged)
        
        if let alarm_message_val = KeychainWrapper.standardKeychainAccess().string(forKey: "alarm_message") {
            if (alarm_message_val.isEmpty == false) {
                alarm_message.isOn = true
            }
        }
        
        if let alarm_update_val = KeychainWrapper.standardKeychainAccess().string(forKey: "alarm_update") {
            if (alarm_update_val.isEmpty == false) {
                alarm_update.isOn = true
            }
        }
        
        if let alarm_location_val = KeychainWrapper.standardKeychainAccess().string(forKey: "alarm_location") {
            if (alarm_location_val.isEmpty == false) {
                alarm_location.isOn = true
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switch_message(mySwitch: UISwitch) {
        if mySwitch.isOn {
            KeychainWrapper.standardKeychainAccess().setString("1", forKey: "alarm_message")
        }else{
            KeychainWrapper.standardKeychainAccess().setString("", forKey: "alarm_message")
        }
    }
    
    func switch_update(mySwitch: UISwitch) {
        if mySwitch.isOn {
            KeychainWrapper.standardKeychainAccess().setString("1", forKey: "alarm_update")
        }else{
            KeychainWrapper.standardKeychainAccess().setString("", forKey: "alarm_update")
        }
    }
    
    func switch_location(mySwitch: UISwitch) {
        if mySwitch.isOn {
            KeychainWrapper.standardKeychainAccess().setString("1", forKey: "alarm_location")
        }else{
            KeychainWrapper.standardKeychainAccess().setString("", forKey: "alarm_location")
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // :click btn-back
    @IBAction func toBack(sender: AnyObject){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
    }

}
