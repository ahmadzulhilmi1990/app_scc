//
//  NewDetailsViewController.swift
//  SupplyChainCity
//
//  Created by user on 20/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class NewDetailsViewController: UIViewController,UIScrollViewDelegate {

    // :widget
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var img_view: UIImageView!
    @IBOutlet var txt_desc: UITextView!
    @IBOutlet var txt_title: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrollView.delegate = self
        //scrollView.isPagingEnabled = true

        self.title = SysPara.NEWS_TITLE
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Grotesque MT", size: 15)!]
        
        print("SysPara.NEW_ROW_ID : \(String(describing: SysPara.NEW_ROW_ID))")
        print("SysPara.NEW_ROW_ID : \(String(describing: SysPara.NEWS_ID))")
        print("SysPara.NEW_ROW_ID : \(String(describing: SysPara.NEWS_TYPE))")
        print("SysPara.NEW_ROW_ID : \(String(describing: SysPara.NEWS_TITLE))")
        print("SysPara.NEW_ROW_ID : \(String(describing: SysPara.NEWS_DESCRIPTION))")
        print("SysPara.NEW_ROW_ID : \(String(describing: SysPara.NEWS_IMAGE))")
        print("SysPara.NEW_ROW_ID : \(String(describing: SysPara.NEWS_CREATED_AT))")
        print("SysPara.NEW_ROW_ID : \(String(describing: SysPara.NEWS_UPDATED_AT))")
        print("SysPara.NEW_ROW_ID : \(String(describing: SysPara.NEWS_CURRENT_PAGE))")
        
        if(SysPara.NEWS_IMAGE.characters.count > 0){
            img_view.downloadedFrom(link: SysPara.NEWS_IMAGE)
        }
        txt_title.text = SysPara.NEWS_TITLE
        txt_desc.text = SysPara.NEWS_DESCRIPTION
        //txt_desc.sizeToFit()
        
        //[self.txt_desc, setTextContainerInset,:UIEdgeInsetsMake(0, 12, 0, 12)]
        //txt_desc.setTextContainerInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        //img_view.isHidden = true
        //self.txt_desc.contentInset = UIEdgeInsetsMake(-400.0, 0, 0, 0);
        
        txt_title.font = UIFont(name: "RNS Camelia", size: 14)!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // :click btn-sign-in
    @IBAction func toBack(sender: AnyObject){
        TabManagerViewController()
    }
    
    func TabManagerViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
        
    }

}
