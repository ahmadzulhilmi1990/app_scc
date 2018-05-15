//
//  UpdateProfileViewController.swift
//  supply_chain_city
//
//  Created by user on 08/05/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    // :widget
    @IBOutlet var btn_edit_profile: UIButton!
    @IBOutlet var btn_logout: UIButton!
    @IBOutlet var txt_username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txt_username.text = SysPara.USERNAME
        
        // :button edit-profile/logout
        btn_edit_profile.layer.cornerRadius = 10
        btn_logout.layer.cornerRadius = 10
        
        // :button edit-profile
        btn_edit_profile.backgroundColor = .clear
        btn_edit_profile.layer.borderWidth = 1
        btn_edit_profile.layer.borderColor = UIColor.black.cgColor
        
        // :button logout
        btn_logout.backgroundColor = .clear
        btn_logout.layer.borderWidth = 1
        btn_logout.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // :click btn-back
    @IBAction func toBack(sender: AnyObject){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
    }

}
