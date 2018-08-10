//
//  DialogProfileViewController.swift
//  SupplyChainCity
//
//  Created by user on 23/07/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class DialogProfileViewController: UIViewController {
    
    // :widget
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var btn_sure: UIButton!
    @IBOutlet weak var btn_later: UIButton!
    @IBOutlet weak var lbl_header: UILabel!
    
    // :variable
    var delegate: DialogProfileDelegate?
    var selectedOption = "First"
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_header.text = "Welcome,"+SysPara.FULLNAME
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @IBAction func onTapCancelButton(_ sender: Any) {
        //delegate?.cancelButtonTapped()
        //self.dismiss(animated: true, completion: nil)
        self.TabManagerViewController()
    }
    
    @IBAction func sureButtonTapped(_ sender: Any) {
        //delegate?.cancelButtonTapped()
        //self.dismiss(animated: true, completion: nil)
        self.CreateProfileViewController()
    }
    
    func CreateProfileViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let CreateProfileViewController = storyBoard.instantiateViewController(withIdentifier: "CreateProfileViewController") as! CreateProfileViewController
        CreateProfileViewController.modalTransitionStyle = .crossDissolve
        self.present(CreateProfileViewController, animated: true, completion: { _ in })
        
    }
    
    func TabManagerViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
        
    }
    
}
