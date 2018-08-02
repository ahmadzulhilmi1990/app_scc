//
//  UpdateProfileViewController.swift
//  supply_chain_city
//
//  Created by user on 08/05/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewProfileViewController: UIViewController,UIScrollViewDelegate {
    
    // :widget
    @IBOutlet var btn_edit_profile: UIButton!
    @IBOutlet var btn_logout: UIButton!
    @IBOutlet var btn_home: UIButton!
    @IBOutlet var txt_title_header: UILabel!
    @IBOutlet var txt_username: UILabel!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var txt_title: UILabel!
    @IBOutlet var txt_company: UILabel!
    @IBOutlet var txt_role: UILabel!
    @IBOutlet var txt_focus_area: UILabel!
    @IBOutlet var txt_about_me: UILabel!
    @IBOutlet var txt_country: UILabel!
    @IBOutlet var txt_gender: UILabel!
    @IBOutlet var txt_email: UILabel!
    @IBOutlet var txt_contact_no: UILabel!
    @IBOutlet var txt_social_media: UILabel!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_company: UILabel!
    @IBOutlet var lbl_role: UILabel!
    @IBOutlet var lbl_focus_area: UILabel!
    @IBOutlet var lbl_about_me: UILabel!
    @IBOutlet var lbl_country: UILabel!
    @IBOutlet var lbl_gender: UILabel!
    @IBOutlet var lbl_email: UILabel!
    @IBOutlet var lbl_contact_no: UILabel!
    @IBOutlet var lbl_social_media: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        txt_username.text = SysPara.USERNAME
        
        
        // :button edit-profile
        btn_edit_profile.backgroundColor = .clear
        btn_edit_profile.layer.borderWidth = 1
        btn_edit_profile.layer.cornerRadius = 8
        btn_edit_profile.layer.borderColor = UIColor.gray.cgColor
        
        // :button logout
        btn_logout.backgroundColor = .clear
        btn_logout.layer.borderWidth = 1
        btn_logout.layer.cornerRadius = 8
        btn_logout.layer.borderColor = UIColor.gray.cgColor
        
        // :button home
        btn_home.backgroundColor = .clear
        btn_home.layer.cornerRadius = 8
        btn_home.layer.borderWidth = 1
        btn_home.layer.borderColor = UIColor.gray.cgColor
        
        //self.scrollview.frame = self.view.bounds;
        self.scrollview.contentSize.height = 900;
        
        txt_about_me.sizeToFit()
        txt_social_media.sizeToFit()
        
        // :setting label-data
        txt_title.text = ""
        txt_company.text = ""
        txt_role.text = SysPara.ROLE_CODE
        txt_focus_area.text = ""
        txt_about_me.text = SysPara.ABOUT_ME
        txt_country.text = SysPara.COUNTRY_CODE
        txt_gender.text = SysPara.GENDER
        txt_email.text = SysPara.USER_EMAIL
        txt_contact_no.text = SysPara.PHONE_NO
        txt_social_media.text = SysPara.FACEBOOK + "\n" + SysPara.INSTAGRAM
        
        txt_title_header?.font = UIFont(name: "RNS Camelia", size: 14)!
        txt_username?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_title?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_company?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_role?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_focus_area?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_about_me?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_country?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_gender?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_email?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_contact_no?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_social_media?.font = UIFont(name: "RNS Camelia", size: 12)!
        
        lbl_title?.font = UIFont(name: "RNS Camelia", size: 12)!
        lbl_company?.font = UIFont(name: "RNS Camelia", size: 12)!
        lbl_role?.font = UIFont(name: "RNS Camelia", size: 12)!
        lbl_focus_area?.font = UIFont(name: "RNS Camelia", size: 12)!
        lbl_about_me?.font = UIFont(name: "RNS Camelia", size: 12)!
        lbl_country?.font = UIFont(name: "RNS Camelia", size: 12)!
        lbl_gender?.font = UIFont(name: "RNS Camelia", size: 12)!
        lbl_email?.font = UIFont(name: "RNS Camelia", size: 12)!
        lbl_contact_no?.font = UIFont(name: "RNS Camelia", size: 12)!
        lbl_social_media?.font = UIFont(name: "RNS Camelia", size: 12)!
        
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
    
    // :click Log Out
    @IBAction func toLogout(sender: AnyObject){
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                SwiftLoader.show(title: "please wait...",animated: true)
                self.POST(token: SysPara.TOKEN)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
    }
    
    // :button Edit Profile
    @IBAction func toUpdate(sender: AnyObject){
        
        UpdateProfileViewController()
        
    }
    
    func POST(token: String){
        
        let myUrl = URL(string: SysPara.API_LOGOUT)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let param = "token="+token
        request.httpBody = param.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                SwiftLoader.hide()
                self.showDialog(description: String(describing: error),id: 0)
                return
            }
            
            do {
                let jsonString = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                print("jsonString: \(String(describing: jsonString))")
                
                if let parseJSON = jsonString {
                    
                    // Now we can access value of First Name by its key
                    let status = parseJSON["status"] as? String
                    let arr = parseJSON["data"] as? NSDictionary
                    print("status: \(String(describing: status))")
                    print("arr: \(String(describing: arr))")
                    
                    if(status == "success"){
                        var message = ""
                        if let userArr = arr {
                            message = (userArr["message"] as! NSString) as String
                        }
                        
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            self.showDialog(description: String(describing: message),id: 1)
                        }
                        
                    }else{
                        
                        var message = ""
                        if let userArr = arr {
                            message = (userArr["message"] as! NSString) as String
                        }
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            self.showDialog(description: String(describing: message),id: 0)
                        }
                    }
                }
            } catch {
                SwiftLoader.hide()
                self.showDialog(description: String(describing: error),id: 0)
                print(error)
            }
        }
        task.resume()
        
    }
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
                self.SignInViewController()
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func SignInViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let SignInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        SignInViewController.modalTransitionStyle = .crossDissolve
        self.present(SignInViewController, animated: true, completion: { _ in })
        
    }
    
    func UpdateProfileViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let UpdateProfileViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateProfileViewController") as! UpdateProfileViewController
        UpdateProfileViewController.modalTransitionStyle = .crossDissolve
        self.present(UpdateProfileViewController, animated: true, completion: { _ in })
        
    }
    
}

