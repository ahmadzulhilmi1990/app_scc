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
    @IBOutlet var img_back: UIImageView!
    @IBOutlet var img_view: UIImageView!
    @IBOutlet var txt_desc: UITextView!
    @IBOutlet var txt_title: UILabel!
    @IBOutlet var txt_date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.img_back.image = self.img_back.image!.withRenderingMode(.alwaysTemplate)
        self.img_back.tintColor = hexStringToUIColor(hex: "#FFFFFF")
        
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
        txt_date.text = SysPara.NEWS_CREATED_AT
        
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
