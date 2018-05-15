//
//  SignInViewController.swift
//  supply_chain_city
//
//  Created by user on 07/05/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    // :variable
    var email: String!
    var password: String!
    
    // :widget
    @IBOutlet var btn_back: UIButton!
    @IBOutlet var btn_sign_in: UIButton!
    @IBOutlet var btn_sign_up: UIButton!
    @IBOutlet var email_input: UITextField!
    @IBOutlet var password_input: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        
        // :button sign-in
        btn_sign_in.layer.cornerRadius = 20
        
        // :button sign-up
        btn_sign_up.backgroundColor = .clear
        btn_sign_up.layer.cornerRadius = 20
        btn_sign_up.layer.borderWidth = 1
        btn_sign_up.layer.borderColor = UIColor.black.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // :click screen to next page
    @IBAction func toCarouselViewController(sender: AnyObject){
        CarouselViewController()
    }
    
    func CarouselViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let CarouselViewController = storyBoard.instantiateViewController(withIdentifier: "CarouselViewController") as! CarouselViewController
        CarouselViewController.modalTransitionStyle = .crossDissolve
        self.present(CarouselViewController, animated: true, completion: { _ in })
        
    }
    
    // :click Forgot Password?
    @IBAction func toForgotViewController(sender: AnyObject){
        ForgotViewController()
    }
    
    func ForgotViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ForgotViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotViewController") as! ForgotViewController
        ForgotViewController.modalTransitionStyle = .crossDissolve
        self.present(ForgotViewController, animated: true, completion: { _ in })
        
    }
    
    // :click btn-sign-up
    @IBAction func toSignUpViewController(sender: AnyObject){
        SignUpViewController()
    }
    
    func SignUpViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let SignUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        SignUpViewController.modalTransitionStyle = .crossDissolve
        self.present(SignUpViewController, animated: true, completion: { _ in })
        
    }
    
    // :click btn-sign-in
    @IBAction func toSubmit(sender: AnyObject){
        
        if Connection.isConnectedToNetwork() == true {
            
            email = email_input.text
            password = password_input.text
            
            if(email.isEmpty == false && password.isEmpty == false){
                
                DispatchQueue.main.async {
                    SwiftLoader.show(title: "please wait...",animated: true)
                    self.POST(email: self.email, password: self.password)
                }
                
            }else{
                showDialog(description: "Email address and password is required!",id: 0)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
    }
    
    func TabManagerViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
        
    }
    
    func POST(email: String, password: String){
        
        let myUrl = URL(string: SysPara.API_SIGN_IN)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let param = "email="+email+"&password="+password
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
                            let token = (userArr["token"] as! NSString) as String
                            SysPara.TOKEN = token
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
                self.TabManagerViewController()
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

}


