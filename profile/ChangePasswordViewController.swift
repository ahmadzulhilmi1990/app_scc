//
//  ChangePasswordViewController.swift
//  
//
//  Created by user on 11/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    // :variable
    var newpass: String!
    var oldpass: String!
    
    // :widget
    @IBOutlet var img_back: UIImageView!
    @IBOutlet var btn_reset_password: UIButton!
    @IBOutlet var newpass_input: UITextField!
    @IBOutlet var oldpass_input: UITextField!
    @IBOutlet var bar_new_password: UILabel!
    @IBOutlet var bar_cnrm_password: UILabel!
    //@IBOutlet var txt_title: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        newpass_input.backgroundColor = .clear
        oldpass_input.backgroundColor = .clear
        
        self.img_back.image = self.img_back.image!.withRenderingMode(.alwaysTemplate)
        self.img_back.tintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        // :button reset-password
        //btn_reset_password.backgroundColor = .clear
        btn_reset_password.layer.cornerRadius = 8
        //btn_reset_password.layer.borderWidth = 1
        //btn_reset_password.layer.borderColor = UIColor.black.cgColor
        
        //txt_title?.font = UIFont(name: "RNS Camelia", size: 14)!
        
        
        newpass_input.addTarget(self, action: #selector(textFieldNewPassDidChange(_:)), for: .editingChanged)
        
        oldpass_input.addTarget(self, action: #selector(textFieldConfirmPassDidChange(_:)), for: .editingChanged)
        
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
    
    @objc func textFieldNewPassDidChange(_ textField: UITextField) {
        bar_new_password.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
        bar_cnrm_password.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
    }
    
    @objc func textFieldConfirmPassDidChange(_ textField: UITextField) {
        bar_new_password.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        bar_cnrm_password.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
    }
    
    // :click btn-submit
    @IBAction func toSubmit(sender: AnyObject){
        
        bar_new_password.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        bar_cnrm_password.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        
        if Connection.isConnectedToNetwork() == true {
            
            newpass = newpass_input.text
            oldpass = oldpass_input.text
            
            if(newpass.isEmpty == false && oldpass.isEmpty == false){
                
                if(newpass == oldpass){
                
                    DispatchQueue.main.async {
                        SwiftLoader.show(title: "please wait...",animated: true)
                        self.POST(token: SysPara.TOKEN, newpass: self.newpass, oldpass: self.oldpass)
                    }
                }else{
                    showDialog(description: "Please re-type password.",id: 0)
                }
                
            }else{
                showDialog(description: "Password is required!",id: 0)
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
    
    func POST(token: String, newpass: String, oldpass: String){
        
        let myUrl = URL(string: SysPara.API_CHANGE_PASSWORD)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let param = "token="+token+"&newpass="+newpass+"&oldpass="+oldpass
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
                self.TabManagerViewController()
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

}
