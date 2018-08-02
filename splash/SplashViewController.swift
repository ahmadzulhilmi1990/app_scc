//
//  SplashViewController.swift
//
//
//  Created by user on 10/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    // :variable
    var email: String!
    var password: String!
    var status: String!
    var desc: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                //SwiftLoader.show(title: "please wait...",animated: true)
                self.GET()
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK, id: 0)
        }
    }

    func GET(){
    
        let myUrl = URL(string: SysPara.API_CAROUSEL);
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                //SwiftLoader.hide()
                print("error=\(String(describing: error))")
                self.showDialog(description: String(describing: error), id: 0)
                return
            }
            do {
                let jsonString = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                print("jsonString: \(String(describing: jsonString))")
               
                if let parseJSON = jsonString {
                    
                    let status = parseJSON["status"] as? String
                    let arr = parseJSON["data"] as? NSDictionary
                    print("status: \(status)")
                    print("data: \(data)")
                    
                    DispatchQueue.main.async {
                        //SwiftLoader.hide()
                        myFunction().onGenerateCarousel(data: arr)
                        self.GET_ALL_DATA()
                        
                    }
                }
            } catch {
                //SwiftLoader.hide()
                print(error)
                self.showDialog(description: String(describing: error), id:0)
            }
        }
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // :click btn-sign-up
    @IBAction func toCarouselViewController(_ sender: Any) {
        CarouselViewController()
    }
    
    func CarouselViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let CarouselViewController = storyBoard.instantiateViewController(withIdentifier: "CarouselViewController") as! CarouselViewController
        CarouselViewController.modalTransitionStyle = .crossDissolve
        self.present(CarouselViewController, animated: true, completion: { _ in })
        
    }
    
    func GET_ALL_DATA(){
        
        let myUrl = URL(string: SysPara.API_GETALLDATA);
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                //SwiftLoader.hide()
                print("error=\(String(describing: error))")
                self.showDialog(description: String(describing: error), id:0)
                return
            }
            do {
                let jsonString = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                print("jsonString: \(String(describing: jsonString))")
                
                if let parseJSON = jsonString {
                    
                    let status = parseJSON["status"] as? String
                    let arr = parseJSON["data"] as? NSDictionary
                    //print("status: \(status)")
                    //print("data: \(data)")
                    SysPara.ARRAY_ALL_DATA = arr
                    DispatchQueue.main.async {
                        //SwiftLoader.hide()
                        //myFunction().onGenerateAllData()
                        self.CarouselViewController()
                        
                    }
                }
            } catch {
                //SwiftLoader.hide()
                print(error)
                self.showDialog(description: String(describing: error), id:0)
            }
        }
        task.resume()
        
    }
    
    func showDialog(description: String!, id: Int!){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            if(id == 0){
                exit(0)
            }else{
                self.CarouselViewController()
            }
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

}
