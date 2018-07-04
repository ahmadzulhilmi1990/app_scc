//
//  UserDetailsViewController.swift
//  SupplyChainCity
//
//  Created by user on 25/06/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, UIScrollViewDelegate {

    // :widget
    @IBOutlet var btn_message: UIButton!
    @IBOutlet var btn_call: UIButton!
    @IBOutlet var btn_email: UIButton!
    @IBOutlet var btn_edit_profile: UIButton!
    @IBOutlet var btn_logout: UIButton!
    @IBOutlet var btn_home: UIButton!
    @IBOutlet var txt_username: UILabel!
    @IBOutlet var txt_works: UILabel!
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
    @IBOutlet var txt_title_header: UILabel!
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
    @IBOutlet var txt_btn_message: UILabel!
    @IBOutlet var txt_btn_call: UILabel!
    @IBOutlet var txt_btn_email: UILabel!
    @IBOutlet var txt_description: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        
        self.scrollview.contentSize.height = 850;
        
        //txt_about_me.sizeToFit()
        //txt_social_media.sizeToFit()
        
        txt_title_header?.font = UIFont(name: "RNS Camelia", size: 16)!
        txt_username?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_works?.font = UIFont(name: "RNS Camelia", size: 12)!
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
        
        txt_btn_message?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_btn_call?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_btn_email?.font = UIFont(name: "RNS Camelia", size: 12)!
        txt_description?.font = UIFont(name: "RNS Camelia", size: 12)!
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                SwiftLoader.show(title: "please wait...",animated: true)
                self.GET(token: SysPara.TOKEN)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toBack(sender: AnyObject){
        TabManagerViewController()
    }
    
    func TabManagerViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
        
    }
    
    func GET(token: String){
        
        let userID = SysPara.USERDETAILS_ID
        let myUrl = URL(string: SysPara.API_USERDETAILS+userID+"/"+SysPara.TOKEN)
        print("myurl : \(myUrl)")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //let param = "token="+SysPara.TOKEN+"&userID="+userID
        //request.httpBody = param.data(using: String.Encoding.utf8)
        
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
                    
                    let status = parseJSON["status"] as? String
                    let arr = parseJSON["data"] as? NSDictionary
                    print("status: \(String(describing: status))")
                    print("arr: \(String(describing: arr))")
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.onGenerateUsers(data: arr)
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
    
    func onGenerateUsers(data: NSDictionary?){
        
        if let userArr = data {
            let user_list = userArr["info"] as? NSDictionary
            print("user_list : \(String(describing: user_list))")
            
            if let arr = user_list {
                
                let user_id = (arr["user_id"] as! NSString) as String
                let fullname = (arr["fullname"] as! NSString) as String
                let email = (arr["email"] as! NSString) as String
                let gender = (arr["gender"] as! NSString) as String
                let role_code = (arr["role_code"] as! NSString) as String
                let focus_code = (arr["focus_code"] as! NSString) as String
                let about_me = (arr["about_me"] as! NSString) as String
                let country_code = (arr["country_code"] as! NSString) as String
                let facebook = (arr["facebook"] as! NSString) as String
                let instagram = (arr["instagram"] as! NSString) as String
                let linkedIn = (arr["linkedIn"] as! NSString) as String
                let phone_no = (arr["phone_no"] as! NSString) as String
                
                print("user_id : \(String(describing: user_id))")
                print("fullname : \(String(describing: fullname))")
                print("email : \(String(describing: email))")
                print("gender : \(String(describing: gender))")
                print("role_code : \(String(describing: role_code))")
                print("focus_code : \(String(describing: focus_code))")
                print("about_me : \(String(describing: about_me))")
                print("country_code : \(String(describing: country_code))")
                print("facebook : \(String(describing: facebook))")
                print("instagram : \(String(describing: instagram))")
                print("linkedIn : \(String(describing: linkedIn))")
                print("phone_no : \(String(describing: phone_no))")
                
                // :settting value to text or label
                txt_username.text = fullname
                txt_email.text = email
                txt_country.text = country_code
                txt_about_me.text = about_me
                txt_gender.text = gender
                txt_contact_no.text = phone_no
                txt_social_media.text = facebook + "\n" + instagram + "\n" + linkedIn
                txt_focus_area.text = focus_code
                txt_role.text = role_code
            }
            
        }
    }
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
            }else{
                self.TabManagerViewController()
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

}
