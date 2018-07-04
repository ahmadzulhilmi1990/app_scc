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

        /*for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }*/
        
        // Do any additional setup after loading the view.
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                //SwiftLoader.show(title: "please wait...",animated: true)
                self.GET()
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK)
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
                self.showDialog(description: String(describing: error))
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
                self.showDialog(description: String(describing: error))
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
                self.showDialog(description: String(describing: error))
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
                self.showDialog(description: String(describing: error))
            }
        }
        task.resume()
        
    }
    
    func showDialog(description: String!){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.CarouselViewController()
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

}
