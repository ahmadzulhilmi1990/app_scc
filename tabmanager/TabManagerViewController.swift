//
//  TabManagerViewController.swift
//  SupplyChainCity
//
//  Created by user on 21/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class TabManagerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if(SysPara.TO_TAB == "0"){
            self.selectedIndex = 0
        }else if(SysPara.TO_TAB == "1"){
            self.selectedIndex = 1
        }else if(SysPara.TO_TAB == "2"){
            self.selectedIndex = 2
        }else if(SysPara.TO_TAB == "3"){
            self.selectedIndex = 3
        }else{
            self.selectedIndex = 0
        }
        
        /*if let tabItems = self.tabBarController?.tabBar.items as NSArray!
        {
            // In this case we want to modify the badge number of the third tab:
            //let tabItem = tabItems[0] as! UITabBarItem
            //tabItem.badgeValue = "9"
            
            let tabItemConnect = tabItems[1] as! UITabBarItem
            tabItemConnect.badgeValue = "1"
        }*/
        
        // Access the elements (NSArray of UITabBarItem) (tabs) of the tab Bar
        let tabItems = self.tabBar.items as NSArray!
        
        // In this case we want to modify the badge number of the third tab:
        let tabItem = tabItems![3] as! UITabBarItem
        
        // Now set the badge of the third tab
        tabItem.badgeValue = "1"
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}
