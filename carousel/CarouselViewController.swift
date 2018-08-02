//
//  CarouselViewController.swift
//  supply_chain_city
//
//  Created by user on 07/05/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController,UIScrollViewDelegate {

    // :variable
    let offlineArray = ["onboard1.png","onboard2.png","onboard3.png"]
    
    // :widget
    @IBOutlet var btn_signin: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    //let scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:320,height: 300))
    //var colors:[UIColor] = [UIColor.gray, UIColor.gray, UIColor.gray, UIColor.gray]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    //var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:50,y: 300, width:200, height:50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        //btn_signin.titleLabel?.font = UIFont.init(name: "RNS Camelia", size: 14)!
        
        if(SysPara.ARRAY_CAROUSEL.isEmpty){
            print("ARRAY_CAROUSEL : NULL")
            offlineCarousel(myArrayCarousel: offlineArray)
        }else{
            print("ARRAY_CAROUSEL : \(SysPara.ARRAY_CAROUSEL)")
            
            if Connection.isConnectedToNetwork() == true {
                onlineCarousel()
            }else{
                offlineCarousel(myArrayCarousel: offlineArray)
            }
        }
        
    }
    
    func onlineCarousel(){
    
        DispatchQueue.main.async{
            self.view.addSubview(self.scrollView)
            
            let myArrayCarousel = ["http://www.simplifiedtechy.net/wp-content/uploads/2017/07/simplified-techy-default.png","http://i.imgur.com/w5rkSIj.jpg"]
            
            self.configurePageControl(total: myArrayCarousel.count)
            
            for index in 0..<myArrayCarousel.count{
                print("Data :  \(myArrayCarousel[index])")
                
                self.frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
                self.frame.size = self.scrollView.frame.size
                
                let subView = UIView(frame: self.frame)
                
                // :adding imageview
                var imageView: UIImageView!
                let catPictureURL = URL(string: myArrayCarousel[index])!
                let session = URLSession(configuration: .default)
                let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                    // The download has finished.
                     if let e = error {
                     
                        print("Error downloading cat picture: \(e)")
                     
                     } else {
                        
                        if let res = response as? HTTPURLResponse {
                            
                            print("Downloaded cat picture with response code \(res.statusCode)")
                     
                            if let imageData = data {
                                imageView = UIImageView(image: UIImage(data: imageData))
                                imageView.frame.size.width = subView.frame.size.width
                                imageView.frame.size.height = subView.frame.size.height
                                imageView.contentMode = .scaleAspectFit
                                subView.addSubview(imageView)
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                            
                        } else {
                            print("Couldn't get response code for some reason")
                        }
                     }
                 }
                 downloadPicTask.resume()
                
                self.scrollView .addSubview(subView)
            }
            
            let arrtotal = Int(myArrayCarousel.count)
            self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * CGFloat(arrtotal),height: self.scrollView.frame.size.height)
            self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        }
    
    }
    
    func offlineCarousel(myArrayCarousel: Array<Any>){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.view.addSubview(self.scrollView)
            
            self.configurePageControl(total: myArrayCarousel.count)
            
            for index in 0..<myArrayCarousel.count{
                print("Data :  \(myArrayCarousel[index])")
                
                self.frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
                self.frame.size = self.scrollView.frame.size
                
                let subView = UIView(frame: self.frame)
                
                // :adding imageview
                var imageView: UIImageView!
                let image: UIImage = UIImage(named: String(describing:myArrayCarousel[index]))!
                imageView = UIImageView(image: image)
                imageView.frame.size.width = subView.frame.size.width
                imageView.frame.size.height = subView.frame.size.height
                imageView.contentMode = .scaleAspectFit
                subView.addSubview(imageView)
                
                self.scrollView .addSubview(subView)
            }
            
            let arrtotal = Int(myArrayCarousel.count)
            self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * CGFloat(arrtotal),height: self.scrollView.frame.size.height)
            self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        }
        
    }
    
    func configurePageControl(total: Int) {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = total
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = hexStringToUIColor(hex: "#42B4D0")
        self.view.addSubview(pageControl)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }

    // :click screen to next page
    @IBAction func toSignInViewController(sender: AnyObject){
        SignInViewController()
    }
    
    func SignInViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let SignInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        SignInViewController.modalTransitionStyle = .crossDissolve
        self.present(SignInViewController, animated: true, completion: { _ in })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
