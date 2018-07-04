//
//  CustomAlertDialogViewController.swift
//  SupplyChainCity
//
//  Created by user on 24/06/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class CustomAlertDialogViewController: UIViewController {

    // :widget
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    // :variable
    var delegate: CustomAlertViewDelegate?
    var selectedOption = "First"
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        //cancelButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
        //cancelButton.addBorder(side: .Right, color: alertViewGrayColor, width: 1)
        //okButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
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
        delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapViewProfileButton(_ sender: Any) {
        delegate?.cancelButtonTapped()
        self.UserDetailsViewController()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapMessageButton(_ sender: Any) {
        delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapOkButton(_ sender: Any) {
        //alertTextField.resignFirstResponder()
        //delegate?.okButtonTapped(selectedOption: selectedOption)
        self.dismiss(animated: true, completion: nil)
    }
    
    func UserDetailsViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let UserDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        UserDetailsViewController.modalTransitionStyle = .crossDissolve
        self.present(UserDetailsViewController, animated: true, completion: { _ in })
        
    }

}
