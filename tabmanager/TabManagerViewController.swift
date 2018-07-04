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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
