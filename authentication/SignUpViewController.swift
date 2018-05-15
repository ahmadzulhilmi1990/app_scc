//
//  SignUpViewController.swift
//  supply_chain_city
//
//  Created by user on 07/05/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // :widget
    @IBOutlet var btn_back: UIButton!
    @IBOutlet var btn_submit: UIButton!
    @IBOutlet var btn_tenant: UIButton!
    @IBOutlet var btn_visitor: UIButton!
    @IBOutlet var email_input: UITextField!
    @IBOutlet var username_input: UITextField!
    @IBOutlet var password_input: UITextField!
    
    // :variable
    var guest: String!
    var email: String!
    var username: String!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // :button btn_submit
        btn_submit.backgroundColor = .clear
        btn_submit.layer.cornerRadius = 20
        btn_submit.layer.borderWidth = 1
        btn_submit.layer.borderColor = UIColor.black.cgColor
        
        // :default guest type
        btn_tenant.backgroundColor = UIColor.lightGray
        guest = "Tenant"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // :click lbl_tenant
    @IBAction func setTenant(sender: AnyObject){
        guest = "T"
        btn_tenant.backgroundColor = UIColor.lightGray
        btn_visitor.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
    }
    
    // :click lbl_visitor
    @IBAction func setVisitor(sender: AnyObject){
        guest = "V"
        btn_tenant.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        btn_visitor.backgroundColor = UIColor.lightGray
    }
    
    // :click btn-back
    @IBAction func toSignInViewController(sender: AnyObject){
        SignInViewController()
    }
    
    func SignInViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let SignInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        SignInViewController.modalTransitionStyle = .crossDissolve
        self.present(SignInViewController, animated: true, completion: { _ in })
        
    }
    
    // :click btn-submit
    @IBAction func toSubmit(sender: AnyObject){
        
        if Connection.isConnectedToNetwork() == true {
            
            email = email_input.text
            password = password_input.text
            username = username_input.text
            
            if(email.isEmpty == false && password.isEmpty == false && username.isEmpty == false){
                
                DispatchQueue.main.async {
                    SwiftLoader.show(title: "please wait...",animated: true)
                    self.POST(email: self.email, password: self.password, username: self.username, type: self.guest)
                }
                
            }else{
                showDialog(description: "Email, username and password is required!",id: 0)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
    }
    
    func POST(email: String, password: String, username: String, type: String){
        
        let myUrl = URL(string: SysPara.API_SIGN_UP)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let param = "email="+email+"&password="+password+"&username="+username+"&type="+type
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
    
   

}
