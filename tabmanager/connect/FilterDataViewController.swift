//
//  FilterDataViewController.swift
//  SupplyChainCity
//
//  Created by user on 31/07/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class FilterDataViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    // :variable
    var collection_focus_area: [FocusArea] = []
    var collection_experience_role: [ExperienceRole] = []
    
    // :widget
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var myCollectionRole: UICollectionView!
    @IBOutlet var img_back: UIImageView!
    @IBOutlet var img_new_users: UIImageView!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var btn_reset: UIButton!
    @IBOutlet var interest_input: UITextField!
    @IBOutlet var bar_interest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.img_back.image = self.img_back.image!.withRenderingMode(.alwaysTemplate)
        self.img_back.tintColor = hexStringToUIColor(hex: "#42B4D0")
        
        btn_save.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
        btn_save.layer.cornerRadius = 10
        
        interest_input.addTarget(self, action: #selector(textFieldEmailDidChange(_:)), for: .editingChanged)
        
        onGenerateFocusAreaData()
        onGenerateExperienceRoleData()
        
        print("ARRAY_FILTER_INDUSTRY = \(SysPara.ARRAY_FILTER_INDUSTRY)")
        print("ARRAY_FILTER_EXPERIENCE_ROLE = \(SysPara.ARRAY_FILTER_EXPERIENCE_ROLE)")
        
        if let filter_user = KeychainWrapper.standardKeychainAccess().string(forKey: "filter_user") {
            
            print(filter_user)
            if(filter_user == "new"){
                
                self.img_new_users.image = self.img_new_users.image!.withRenderingMode(.alwaysTemplate)
                self.img_new_users.tintColor = hexStringToUIColor(hex: "#42B4D0")
                
                btn_reset.setTitle("Reset", for: UIControlState.normal)
                
                // :SETTINGS FILTER_USER
                KeychainWrapper.standardKeychainAccess().setString("new", forKey: "filter_user")
                
            }else{ //all
                self.img_new_users.image = self.img_new_users.image!.withRenderingMode(.alwaysTemplate)
                self.img_new_users.tintColor = hexStringToUIColor(hex: "#000000")
                
                btn_reset.setTitle("All", for: UIControlState.normal)
                
                // :SETTINGS FILTER_USER
                KeychainWrapper.standardKeychainAccess().setString("all", forKey: "filter_user")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func textFieldEmailDidChange(_ textField: UITextField) {
        bar_interest.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
    }
    
    func onGenerateFocusAreaData(){
        let data = SysPara.ARRAY_ALL_DATA
        if let arr = data {
            let focus_area = arr["focus_area"] as? [[String:Any]]
            
            print("focus_area : \(String(describing: focus_area))")
            
            for anItem in focus_area! {
                
                let focus_id = anItem["id"] as AnyObject
                let focus_name = anItem["focus_name"] as AnyObject
                let focus_code = anItem["focus_code"] as AnyObject
                print("focus_id : \(String(describing: focus_id))")
                print("focus_name : \(String(describing: focus_name))")
                print("focus_code : \(String(describing: focus_code))")
                
                let arr_focus_area = FocusArea(id: String(describing: focus_id),focus_name: String(describing: focus_name),focus_code: String(describing: focus_code))
                
                print(arr_focus_area)
                collection_focus_area.append(arr_focus_area)
                DispatchQueue.main.async { self.myCollection.reloadData() }
                
            }
            
            print(collection_focus_area.count)
            
        }
    }
    
    func onGenerateExperienceRoleData(){
        let data = SysPara.ARRAY_ALL_DATA
        if let arr = data {
            let role = arr["experience_role"] as? [[String:Any]]
            
            print("role : \(String(describing: role))")
            
            for anItem in role! {
                
                let role_id = anItem["id"] as AnyObject
                let role_name = anItem["role_name"] as AnyObject
                let role_code = anItem["role_code"] as AnyObject
                print("role_id : \(String(describing: role_id))")
                print("role_name : \(String(describing: role_name))")
                print("role_code : \(String(describing: role_code))")
                
                let arr_role = ExperienceRole(id: String(describing: role_id),role_name: String(describing: role_name),role_code: String(describing: role_code))
                
                print(arr_role)
                collection_experience_role.append(arr_role)
                DispatchQueue.main.async { self.myCollectionRole.reloadData() }
                
            }
            
            print(collection_experience_role.count)
            
        }
    }
    
    /*********************** START TABLE ******************************/
    let reuseIdentifier = "RowInterest"
    let reuseIdentifierRole = "RowExperienceRole"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var x = 0
        if collectionView == self.myCollection {
            x = collection_focus_area.count
        }
        
        if collectionView == self.myCollectionRole {
            x = collection_experience_role.count
        }
        return x
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RowInterest
        
        if collectionView == self.myCollection {
        
                // Getting the right element
                let model = collection_focus_area[indexPath.row]
        
                // get a reference to our storyboard cell
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RowInterest
        
            cell.txt_title.text = model.focus_name
            print(model.focus_name)
        
            let arr = SysPara.ARRAY_FILTER_INDUSTRY
            print(arr)
        
            if arr.contains(model.focus_code!) {
                cell.avatar.image = cell.avatar.image!.withRenderingMode(.alwaysTemplate)
                cell.avatar.tintColor = hexStringToUIColor(hex: "#42B4D0")
            }else{
                cell.avatar.image = cell.avatar.image!.withRenderingMode(.alwaysTemplate)
                cell.avatar.tintColor = UIColor.gray
            }
        }
        
        if collectionView == self.myCollectionRole {
            
            // Getting the right element
            let model = collection_experience_role[indexPath.row]
            
            // get a reference to our storyboard cell
            cell = collectionView.dequeueReusableCell(withReuseIdentifier:reuseIdentifier, for: indexPath as IndexPath) as! RowInterest
            
            cell.txt_title.text = model.role_name
            print(model.role_name)
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.myCollection {
        
        // handle tap events
        let model = collection_focus_area[indexPath.row]
        let name = model.focus_name
        let fcode = model.focus_code
        
        let arr = SysPara.ARRAY_FILTER_INDUSTRY
        if(arr.isEmpty){
            print("ADDED!")
            SysPara.ARRAY_FILTER_INDUSTRY.append(fcode as String!)
        }else{
            for id in arr {
                if(model.focus_code == id){ // remove from filter
                    print("REMOVE!")
                    SysPara.ARRAY_FILTER_INDUSTRY = SysPara.ARRAY_FILTER_INDUSTRY.filter { $0 != id }
                }else{ // added filter
                    print("ADDED!")
                    SysPara.ARRAY_FILTER_INDUSTRY.append(fcode as String!)
                }
            }
        }
        
        //DispatchQueue.main.async { self.tableView.reloadData() }
        DispatchQueue.main.async {
            print("ARRAY_FILTER_FOCUS_AREA = \(SysPara.ARRAY_FILTER_INDUSTRY)")
            self.collection_focus_area.removeAll()
            self.onGenerateFocusAreaData()
        }
            
        }
        
        if collectionView == self.myCollectionRole {
            
            // handle tap events
            let model = collection_experience_role[indexPath.row]
            let name = model.role_name
            let rcode = model.role_code
            
            let arr = SysPara.ARRAY_FILTER_EXPERIENCE_ROLE
            if(arr.isEmpty){
                print("ADDED!")
                SysPara.ARRAY_FILTER_EXPERIENCE_ROLE.append(rcode as String!)
            }else{
                for id in arr {
                    if(model.role_code == id){ // remove from filter
                        print("REMOVE!")
                        SysPara.ARRAY_FILTER_EXPERIENCE_ROLE = SysPara.ARRAY_FILTER_EXPERIENCE_ROLE.filter { $0 != id }
                    }else{ // added filter
                        print("ADDED!")
                        SysPara.ARRAY_FILTER_EXPERIENCE_ROLE.append(rcode as String!)
                    }
                }
            }
            
            //DispatchQueue.main.async { self.tableView.reloadData() }
            DispatchQueue.main.async {
                print("ARRAY_FILTER_EXPERIENCE_ROLE = \(SysPara.ARRAY_FILTER_EXPERIENCE_ROLE)")
                self.collection_experience_role.removeAll()
                self.onGenerateExperienceRoleData()
            }
            
        }
        
    }
    
    /*********************** END TABLE ******************************/
    
    
    
    // :click btn-back
    @IBAction func toBack(sender: AnyObject){
        TabManagerViewController()
    }
    
    @IBAction func clickNewUsers(sender: AnyObject){
        self.img_new_users.image = self.img_new_users.image!.withRenderingMode(.alwaysTemplate)
        self.img_new_users.tintColor = hexStringToUIColor(hex: "#42B4D0")
        
        btn_reset.setTitle("Reset", for: UIControlState.normal)
        
        // :SETTINGS FILTER_USER
        KeychainWrapper.standardKeychainAccess().setString("new", forKey: "filter_user")
    }
    
    @IBAction func clickReset(sender: AnyObject){
        self.img_new_users.image = self.img_new_users.image!.withRenderingMode(.alwaysTemplate)
        self.img_new_users.tintColor = hexStringToUIColor(hex: "#000000")
        
        btn_reset.setTitle("All", for: UIControlState.normal)
        
        // :SETTINGS FILTER_USER
        KeychainWrapper.standardKeychainAccess().setString("all", forKey: "filter_user")
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

