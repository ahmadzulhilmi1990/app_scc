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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
