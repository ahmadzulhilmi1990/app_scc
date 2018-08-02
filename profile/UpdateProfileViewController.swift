//
//  UpdateProfileViewController.swift
//  supply_chain_city
//
//  Created by user on 08/05/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    // :variable
    var title_: String!
    var company: String!
    var role: String!
    var focus_area: String!
    var about_me: String!
    var country: String!
    var gender: String!
    var email: String!
    var contact_no: String!
    var social_media: String!
    
    
    // :widget
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var txt_username: UILabel!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var txt_title: UITextField!
    @IBOutlet var txt_company: UITextField!
    @IBOutlet var txt_role: UITextField!
    @IBOutlet var txt_focus_area: UITextField!
    @IBOutlet var txt_about_me: UITextView!
    @IBOutlet var txt_country: UITextField!
    @IBOutlet var txt_gender: UILabel!
    @IBOutlet var btn_gender: UIButton!
    @IBOutlet var txt_email: UITextField!
    @IBOutlet var txt_contact_no: UITextField!
    @IBOutlet var txt_social_media: UITextView!
   
    @IBOutlet var lbl_header: UILabel!
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
        txt_username.text = "Hi " + SysPara.USERNAME
        lbl_header?.font = UIFont(name: "RNS Camelia", size: 14)!
        txt_username?.font = UIFont(name: "RNS Camelia", size: 16)!
        
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
        
        // :button home
        btn_save.backgroundColor = .clear
        btn_save.layer.cornerRadius = 10
        btn_save.layer.borderWidth = 1
        btn_save.layer.borderColor = UIColor.black.cgColor
        
        // :text-view about-me
        txt_about_me.layer.cornerRadius = 10
        txt_about_me.layer.borderWidth = 1
        txt_about_me.layer.borderColor = UIColor.gray.cgColor
        
        // :text-view social-media
        txt_social_media.layer.cornerRadius = 10
        txt_social_media.layer.borderWidth = 1
        txt_social_media.layer.borderColor = UIColor.gray.cgColor
        
        // :btn-gender
        btn_gender.layer.cornerRadius = 5
        btn_gender.layer.borderWidth = 1
        btn_gender.layer.borderColor = UIColor.gray.cgColor
        
        //self.scrollview.frame = self.view.bounds;
        self.scrollview.contentSize.height = 950;
        
        // :setting label-data
        txt_title.text = ""
        txt_company.text = ""
        txt_role.text = SysPara.ROLE_CODE
        txt_focus_area.text = ""
        txt_about_me.text = SysPara.ABOUT_ME
        txt_country.text = SysPara.COUNTRY_CODE
        //txt_gender.text = SysPara.GENDER
        btn_gender.titleLabel?.text = SysPara.GENDER
        txt_email.text = SysPara.USER_EMAIL
        txt_contact_no.text = SysPara.PHONE_NO
        txt_social_media.text = SysPara.FACEBOOK + "\n" + SysPara.INSTAGRAM

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // :click btn-save
    @IBAction func toSave(sender: AnyObject){
        
        if Connection.isConnectedToNetwork() == true {
            
            title_ = txt_title.text
            company = txt_company.text
            role = txt_role.text
            focus_area = txt_focus_area.text
            about_me = txt_about_me.text
            country = txt_country.text
            gender = txt_gender.text
            email = txt_email.text
            contact_no = txt_contact_no.text
            social_media = txt_social_media.text
            
            if(title_.isEmpty == false && company.isEmpty == false && role.isEmpty == false && focus_area.isEmpty == false && about_me.isEmpty == false && country.isEmpty == false && gender.isEmpty == false && contact_no.isEmpty == false && social_media.isEmpty == false){
                
                DispatchQueue.main.async {
                    SwiftLoader.show(title: "please wait...",animated: true)
                    self.PUT(session: SysPara.TOKEN, role_code: self.role, focus_code: self.focus_area,country_code: self.country, about_me: self.about_me, gender: self.gender, phone_no: self.contact_no, fullname: self.title_, facebook: self.social_media, linkedIn: self.social_media, instagram: self.social_media)
                }
                
            }else{
                showDialog(description: "Please fill up form!",id: 0)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
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
    
    func PUT(session: String, role_code: String, focus_code: String,country_code: String, about_me: String, gender: String, phone_no: String, fullname: String, facebook: String, linkedIn: String, instagram: String){
        
        let myUrl = URL(string: SysPara.API_UPDATE_PROFILE)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let param = "session="+session+"&role_code="+role_code+"&focus_code="+focus_code+"&country_code="+country_code+"&about_me="+about_me+"&gender="+gender+"&phone_no="+phone_no+"&fullname="+fullname+"&facebook="+facebook+"&linkedIn="+linkedIn+"&instagram="+instagram
        
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
                        
                        myFunction().onGenerateUser(data: arr)
                        
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
    
    @IBAction func selectGender(sender: AnyObject){
        
        let alert = UIAlertController(title: "Gender", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Male", style: .default , handler:{ (UIAlertAction)in
            print("Male")
            self.txt_gender.text = "Male"
        }))
        
        alert.addAction(UIAlertAction(title: "Female", style: .default , handler:{ (UIAlertAction)in
            print("Female")
            self.txt_gender.text = "Female"
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }

}
