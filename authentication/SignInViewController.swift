//
//  SignInViewController.swift
//  supply_chain_city
//
//  Created by user on 07/05/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Foundation
//import DropDown

class SignInViewController: UIViewController,TDDropdownListDelegate{
    
    // :variable
    var email: String!
    var password: String!
    var list = TDDropdownList(frame: CGRect(x:100 , y : 367 , width: 170 , height: 49))
    
    // :widget
    @IBOutlet var btn_back: UIButton!
    @IBOutlet var img_back: UIImageView!
    @IBOutlet var btn_sign_in: UIButton!
    @IBOutlet var email_input: UITextField!
    @IBOutlet var password_input: UITextField!
    @IBOutlet var box: UIView!
    @IBOutlet var bar_email: UILabel!
    @IBOutlet var bar_password: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        
        // :view box
        email_input.backgroundColor = .clear
        password_input.backgroundColor = .clear
        box.layer.cornerRadius = 10
        
        // :button sign-in
        btn_sign_in.layer.cornerRadius = 20
        
        // :button sign-in
        btn_sign_in.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
        btn_sign_in.layer.cornerRadius = 10
        //btn_sign_in.layer.borderWidth = 1
        //btn_sign_in.layer.borderColor = UIColor.black.cgColor
        
        self.img_back.image = self.img_back.image!.withRenderingMode(.alwaysTemplate)
        self.img_back.tintColor = hexStringToUIColor(hex: "#42B4D0")
        
        onSettings()
        
        email_input.addTarget(self, action: #selector(textFieldEmailDidChange(_:)), for: .editingChanged)

        password_input.addTarget(self, action: #selector(textFieldPasswordDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldEmailDidChange(_ textField: UITextField) {
        bar_email.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
        bar_password.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        
        let current_text = isValidEmail(testStr: textField.text!)
        print(current_text)
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @objc func textFieldPasswordDidChange(_ textField: UITextField) {
        bar_email.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        bar_password.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
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
    
    /*AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
     AttachmentHandler.shared.imagePickedBlock = { (image) in
     /* get your image here */
     }
     AttachmentHandler.shared.videoPickedBlock = {(url) in
     /* get your compressed video url here */
     }
     AttachmentHandler.shared.filePickedBlock = {(filePath) in
     /* get your file path url here */
     }*/
    
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
            
            bar_email.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
            bar_password.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
            
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
    
    func onSettings(){
        let alarm_message = KeychainWrapper.standardKeychainAccess().string(forKey: "alarm_message")
        let alarm_update = KeychainWrapper.standardKeychainAccess().string(forKey: "alarm_update")
        let alarm_location = KeychainWrapper.standardKeychainAccess().string(forKey: "alarm_location")
        onGenerateLocationData()
        print("alarm_message: \(String(describing: alarm_message))")
        print("alarm_update: \(String(describing: alarm_update))")
        print("alarm_location: \(String(describing: alarm_location))")
    }
    
    func onGenerateLocationData(){
        let data = SysPara.ARRAY_ALL_DATA
        if let arr = data {
            let location_list = arr["location_list"] as? [[String:Any]]
            print("location_list : \(String(describing: location_list))")
            
            for anItem in location_list! {
                
                let id = anItem["id"] as AnyObject
                let location_name = anItem["location_name"] as AnyObject
                let latitude = anItem["latitude"] as AnyObject
                let longitude = anItem["longitude"] as AnyObject
                let radius = anItem["radius"] as AnyObject
                let created_at = anItem["created_at"] as AnyObject
                let updated_at = anItem["updated_at"] as AnyObject
                
                SysPara.LOC_ID = String(describing: id)
                SysPara.LOC_NAME = location_name as! String
                SysPara.LOC_LAT = latitude as! String
                SysPara.LOC_LNG = longitude as! String
                SysPara.LOC_RAD = radius as! String
                SysPara.LOC_CREATED = created_at as! String
                SysPara.LOC_UPDATED = updated_at as! String
                
                print("id : \(String(describing: id))")
                print("location_name : \(String(describing: location_name))")
                print("latitude : \(String(describing: latitude))")
                print("longitude : \(String(describing: longitude))")
                print("radius : \(String(describing: radius))")
                print("created_at : \(String(describing: created_at))")
                print("updated_at : \(String(describing: updated_at))")
            }
            
        }
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
    
    func listTapped(sender: UIButton) {
        let alert = UIAlertController(title: "TDDropdownList" ,message: "Selected item: \(sender.currentTitle!)", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


