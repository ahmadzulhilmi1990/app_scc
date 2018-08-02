//
//  BlockViewController.swift
//  SupplyChainCity
//
//  Created by user on 05/07/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class BlockViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    // :widget
    @IBOutlet var tableView: UITableView!
    @IBOutlet var txt_title: UILabel!
    
    // :variable
    var collection_users: [Users] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_title?.font = UIFont(name: "RNS Camelia", size: 14)!
        
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
    
    func GET(token: String){
        
        let myUrl = URL(string: SysPara.API_CONNECTS+SysPara.TOKEN)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //let param = "token="+SysPara.TOKEN+"&connectUserID=ivcWVQl4"
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
                    print("data: \(String(describing: arr))")
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.userLists(data: arr, search: "")
                        
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
    
    /*********************** START TABLE ******************************/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection_users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // grouped vertical sections of the tableview
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Getting the right element
        let model = collection_users[indexPath.row]
        
        // RowDeviceCell Adapter
        let cellIdentifier = "RowConnects"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RowConnects
        
        //cell.sizeToFit()
        //self.tableView.rowHeight = 50.0
        
        //user name
        cell.txt_title?.text = model.user_fullname
        cell.txt_title?.font = UIFont(name: "RNS Camelia", size: 12)!
        cell.txt_position?.font = UIFont(name: "RNS Camelia", size: 10)!
        
        // Returning the cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let model = collection_users[row]
        let userID = model.user_id
        let arr1 = userID?.replacingOccurrences(of: "Optional(", with: "")
        let uid = arr1?.replacingOccurrences(of: ")", with: "")
        print("userID : \(String(describing: uid))")
        
    }
    
    /*********************** END TABLE ******************************/
    
    func userLists(data: NSDictionary?, search : String){
        
        if let userArr = data {
            let user_list = userArr["list"] as? [[String:Any]]
            print("user_list : \(String(describing: user_list))")
            
            for anItem in user_list! {
                
                let user_id = anItem["user_id"] as Any!
                let fullname = anItem["fullname"] as Any!
                let email = ""
                let gender = anItem["gender"] as Any!
                let role_code = anItem["role_code"] as Any!
                let focus_code = anItem["focus_code"] as Any!
                let photo_url = anItem["photo_url"] as Any!
                
                print("user_id : \(String(describing: user_id))")
                print("fullname : \(String(describing: fullname))")
                print("email : \(String(describing: email))")
                print("gender : \(String(describing: gender))")
                print("role_code : \(String(describing: role_code))")
                print("focus_code : \(String(describing: focus_code))")
                
                let arr_users = Users(user_id: String(describing:user_id), user_email: email , user_fullname: fullname as! String, user_gender: gender as! String, user_role_code: role_code as! String,user_focus_code: focus_code as! String, photo_url: photo_url as! String)
                
                print(arr_users)
                collection_users.append(arr_users)
                DispatchQueue.main.async { self.tableView.reloadData() }
                
            }
        }
    }
    
    // :click btn-back
    @IBAction func toBack(sender: AnyObject){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
    }
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
}

