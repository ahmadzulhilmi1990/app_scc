//
//  SliderMenu.swift
//
//
//  Created by user on 10/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class SliderMenu: UIViewController {

    // :widget
    @IBOutlet var txt_username: UILabel!
    @IBOutlet weak var btn_view_profile: UIButton!
    @IBOutlet weak var btn_change_password: UIButton!
    @IBOutlet weak var btn_settings: UIButton!
    @IBOutlet weak var btn_privacy_policy: UIButton!
    @IBOutlet weak var btn_term_condition: UIButton!
    @IBOutlet weak var btn_logout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txt_username.text = "Hi " + SysPara.USERNAME
        txt_username.font = UIFont(name: "Grotesque MT", size: 16)!
        btn_view_profile.titleLabel!.font = UIFont(name: "RNS Camelia", size: 14)!
        btn_change_password.titleLabel!.font = UIFont(name: "RNS Camelia", size: 14)!
        btn_settings.titleLabel!.font = UIFont(name: "RNS Camelia", size: 14)!
        btn_privacy_policy.titleLabel!.font = UIFont(name: "RNS Camelia", size: 14)!
        btn_term_condition.titleLabel!.font = UIFont(name: "RNS Camelia", size: 14)!
        btn_logout.titleLabel!.font = UIFont(name: "RNS Camelia", size: 14)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // :click View Profile
    @IBAction func toViewProfile(sender: AnyObject){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ViewProfileViewController = storyBoard.instantiateViewController(withIdentifier: "ViewProfileViewController") as! ViewProfileViewController
        ViewProfileViewController.modalTransitionStyle = .crossDissolve
        self.present(ViewProfileViewController, animated: true, completion: { _ in })
    }
    
    func SignInViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let SignInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        SignInViewController.modalTransitionStyle = .crossDissolve
        self.present(SignInViewController, animated: true, completion: { _ in })
        
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
    
    /*func switchToDataTab(){
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(switchToDataTabCont), userInfo: nil,repeats: false)
    }
    
    func switchToDataTabCont(){
        tabBarController!.selectedIndex = 3
    }*/
}
