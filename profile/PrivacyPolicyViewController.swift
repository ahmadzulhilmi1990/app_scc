//
//  PrivacyPolicyViewController.swift
//  
//
//  Created by user on 11/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    // :widget
    @IBOutlet var txt_title: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_title?.font = UIFont(name: "RNS Camelia", size: 14)!
        // Do any additional setup after loading the view.
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
