//
//  CarouselViewController.swift
//  supply_chain_city
//
//  Created by user on 07/05/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController,UIScrollViewDelegate {

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
        
        print("ARRAY_CAROUSEL : \(SysPara.ARRAY_CAROUSEL)")
        
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                self.view.addSubview(self.scrollView)
                
                let myArrayCarousel = ["http://www.simplifiedtechy.net/wp-content/uploads/2017/07/simplified-techy-default.png","http://i.imgur.com/w5rkSIj.jpg"]
                
                self.configurePageControl(total: myArrayCarousel.count)
                
                for index in 0..<myArrayCarousel.count{
                    print("Data :  \(myArrayCarousel[index])")
                    
                    self.frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
                    self.frame.size = self.scrollView.frame.size
                    
                    let subView = UIView(frame: self.frame)
                    //subView.backgroundColor = colors[index]
                    
                    
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
    }
    
    func configurePageControl(total: Int) {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = total
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.gray
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
}
