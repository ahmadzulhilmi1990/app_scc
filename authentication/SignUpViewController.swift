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
    @IBOutlet var img_back: UIImageView!
    @IBOutlet var btn_submit: UIButton!
    @IBOutlet var txt_tenant: UILabel!
    @IBOutlet var txt_visitor: UILabel!
    @IBOutlet var email_input: UITextField!
    @IBOutlet var username_input: UITextField!
    @IBOutlet var password_input: UITextField!
    @IBOutlet var box: UIView!
    @IBOutlet var box_tenant: UIView!
    @IBOutlet var box_visitor: UIView!
    @IBOutlet var box_tnc: UILabel!
    @IBOutlet var bar_username: UILabel!
    @IBOutlet var bar_email: UILabel!
    @IBOutlet var bar_password: UILabel!
    
    // :variable
    var guest: String!
    var tnc: String!
    var email: String!
    var username: String!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.img_back.image = self.img_back.image!.withRenderingMode(.alwaysTemplate)
        self.img_back.tintColor = hexStringToUIColor(hex: "#42B4D0")
        
        email_input.backgroundColor = .clear
        username_input.backgroundColor = .clear
        password_input.backgroundColor = .clear
        box.layer.cornerRadius = 10
        box_tnc.layer.masksToBounds = true
        box_tnc.layer.cornerRadius = 5
        box_tenant.layer.cornerRadius = 5
        box_visitor.layer.cornerRadius = 5
        
        // :button btn_submit
        btn_submit.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
        btn_submit.layer.cornerRadius = 10
        
        // :default guest type
        guest = "T"
        
        txt_tenant.textColor = hexStringToUIColor(hex: "#42B4D0")
        box_tenant.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
        box_visitor.backgroundColor = hexStringToUIColor(hex: "#EBEBEB")
        
        let gestureT = UITapGestureRecognizer(target: self, action:  #selector(self.someActionTenant))
        self.box_tenant.addGestureRecognizer(gestureT)
        
        let gestureV = UITapGestureRecognizer(target: self, action:  #selector(self.someActionVisitor))
        self.box_visitor.addGestureRecognizer(gestureV)
        
        username_input.addTarget(self, action: #selector(textFieldUsernameDidChange(_:)), for: .editingChanged)
        
        email_input.addTarget(self, action: #selector(textFieldEmailDidChange(_:)), for: .editingChanged)
        
        password_input.addTarget(self, action: #selector(textFieldPasswordDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldUsernameDidChange(_ textField: UITextField) {
        bar_username.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
        bar_email.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        bar_password.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
    }
    
    @objc func textFieldEmailDidChange(_ textField: UITextField) {
        bar_username.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        bar_email.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
        bar_password.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
    }
    
    @objc func textFieldPasswordDidChange(_ textField: UITextField) {
        bar_username.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        bar_email.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        bar_password.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
    }
    
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func someActionTenant(_ sender:UITapGestureRecognizer){
        // do other task
        guest = "T"
        txt_tenant.textColor = hexStringToUIColor(hex: "#42B4D0")
        txt_visitor.textColor = hexStringToUIColor(hex: "#000000")
        box_tenant.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
        box_visitor.backgroundColor = hexStringToUIColor(hex: "#EBEBEB")
    }
    
    @objc func someActionVisitor(_ sender:UITapGestureRecognizer){
        // do other task
        guest = "V"
        txt_tenant.textColor = hexStringToUIColor(hex: "#000000")
        txt_visitor.textColor = hexStringToUIColor(hex: "#42B4D0")
        box_tenant.backgroundColor = hexStringToUIColor(hex: "#EBEBEB")
        box_visitor.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
    }
    
    // :click btn-back
    @IBAction func toSignInViewController(sender: AnyObject){
        SignInViewController()
    }
    
    // :click btn-back
    @IBAction func clickTermsAndConditions(sender: AnyObject){
        tnc = "1"
        box_tnc.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
    }
    
    func SignInViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let SignInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        SignInViewController.modalTransitionStyle = .crossDissolve
        self.present(SignInViewController, animated: true, completion: { _ in })
        
    }
    
    func CreateProfileViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let CreateProfileViewController = storyBoard.instantiateViewController(withIdentifier: "CreateProfileViewController") as! CreateProfileViewController
        CreateProfileViewController.modalTransitionStyle = .crossDissolve
        self.present(CreateProfileViewController, animated: true, completion: { _ in })
        
    }
    
    // :click btn-submit
    @IBAction func toSubmit(sender: AnyObject){
        
        bar_username.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        bar_email.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        bar_password.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        
        if Connection.isConnectedToNetwork() == true {
            
            email = email_input.text
            password = password_input.text
            username = username_input.text
            
            if(email.isEmpty == false && password.isEmpty == false && username.isEmpty == false){
                
                if(tnc != "1"){
                    showDialog(description: "Terms and Conditions is required!",id: 0)
                }else{
                    onTapCustomAlertButton()
                    /*DispatchQueue.main.async {
                        SwiftLoader.show(title: "please wait...",animated: true)
                        self.POST(email: self.email, password: self.password, username: self.username, type: self.guest)
                    }*/
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
                            self.AutoSignInPOST(email: email, password: password)
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
   
    func onTapCustomAlertButton() {
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "DialogProfileViewController") as! DialogProfileViewController
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.delegate = self
        self.present(customAlert, animated: true, completion: nil)
    }
    
    func AutoSignInPOST(email: String, password: String){
        
        let myUrl = URL(string: SysPara.API_SIGN_IN)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let fcm = randomAlphaNumericString(length: 15)
        let param = "email="+email+"&password="+password+"&fcm="+fcm+"&deviceType=IOS"
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
                            self.onTapCustomAlertButton()
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
    
    func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }

}

extension SignUpViewController: DialogProfileDelegate {
    func sureButtonTapped() {
        //self.CreateProfileViewController()
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }
}
