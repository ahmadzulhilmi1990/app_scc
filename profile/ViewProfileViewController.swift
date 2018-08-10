//
//  UpdateProfileViewController.swift
//  supply_chain_city
//
//  Created by user on 08/05/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewProfileViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    // :variable
    var collection_focus_area: [FocusArea] = []
    var collection_experience_role: [ExperienceRole] = []
    
    // :widget
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var myCollectionRole: UICollectionView!
    @IBOutlet var btn_edit_profile: UIButton!
    @IBOutlet var btn_logout: UIButton!
    @IBOutlet var txt_username: UILabel!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var txt_title: UILabel!
    @IBOutlet var txt_company: UILabel!
    @IBOutlet var txt_about_me: UILabel!
    @IBOutlet var txt_country: UILabel!
    @IBOutlet var txt_gender: UILabel!
    @IBOutlet var txt_email: UILabel!
    @IBOutlet var txt_contact_no: UILabel!
    @IBOutlet var txt_social_media_fb: UILabel!
    @IBOutlet var txt_social_media_linked: UILabel!
    @IBOutlet var txt_social_media_insta: UILabel!
    @IBOutlet var img_back: UIImageView!
    @IBOutlet var avatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.img_back.image = self.img_back.image!.withRenderingMode(.alwaysTemplate)
        self.img_back.tintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        // :button edit-profile
        btn_edit_profile.backgroundColor = .clear
        btn_edit_profile.layer.borderWidth = 1
        btn_edit_profile.layer.cornerRadius = 5
        btn_edit_profile.layer.borderColor = UIColor.gray.cgColor
        
        // :button logout
        btn_logout.backgroundColor = .clear
        btn_logout.layer.borderWidth = 1
        btn_logout.layer.cornerRadius = 5
        btn_logout.layer.borderColor = UIColor.gray.cgColor
        
        //self.scrollview.frame = self.view.bounds;
        self.scrollview.contentSize.height = 1050;
        
        txt_about_me.sizeToFit()
        
        // :setting label-data
        txt_username.text = SysPara.USERNAME
        txt_title.text = SysPara.FULLNAME
        txt_company.text = ""
        txt_about_me.text = SysPara.ABOUT_ME
        txt_email.text = SysPara.USER_EMAIL
        txt_contact_no.text = SysPara.PHONE_NO
        txt_social_media_fb.text = SysPara.FACEBOOK
        txt_social_media_linked.text = SysPara.LINKEDIN
        txt_social_media_insta.text = SysPara.INSTAGRAM
        
        onGenerateFocusAreaData()
        onGenerateExperienceRoleData()
        
        print("ARRAY_FILTER_INDUSTRY = \(SysPara.ARRAY_FILTER_INDUSTRY)")
        print("ARRAY_FILTER_EXPERIENCE_ROLE = \(SysPara.ARRAY_FILTER_EXPERIENCE_ROLE)")
        
        onGenerateCountryData(text: SysPara.COUNTRY_CODE)
        
        if(SysPara.GENDER.isEmpty){
            txt_gender.text = ""
        }else{
            if(SysPara.GENDER == "M"){
                txt_gender.text = "Male"
            }else{
                txt_gender.text = "Female"
            }
        }
        
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.gray.cgColor
        avatar.layer.cornerRadius = 25
        avatar.clipsToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // :click btn-back
    @IBAction func toBack(sender: AnyObject){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
    }
    
    // :click Log Out
    @IBAction func toLogout(sender: AnyObject){
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                SwiftLoader.show(title: "please wait...",animated: true)
                self.POST(token: SysPara.TOKEN)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
    }
    
    // :button Edit Profile
    @IBAction func toUpdate(sender: AnyObject){
        
        UpdateProfileViewController()
        
    }
    
    func POST(token: String){
        
        let myUrl = URL(string: SysPara.API_LOGOUT)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let param = "token="+token
        request.httpBody = param.data(using: String.Encoding.utf8)
        
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
                    
                    // Now we can access value of First Name by its key
                    let status = parseJSON["status"] as? String
                    let arr = parseJSON["data"] as? NSDictionary
                    print("status: \(String(describing: status))")
                    print("arr: \(String(describing: arr))")
                    
                    if(status == "success"){
                        var message = ""
                        if let userArr = arr {
                            message = (userArr["message"] as! NSString) as String
                        }
                        
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            self.showDialog(description: String(describing: message),id: 1)
                        }
                        
                    }else{
                        
                        var message = ""
                        if let userArr = arr {
                            message = (userArr["message"] as! NSString) as String
                        }
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            self.showDialog(description: String(describing: message),id: 0)
                        }
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
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
                self.SignInViewController()
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func SignInViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let SignInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        SignInViewController.modalTransitionStyle = .crossDissolve
        self.present(SignInViewController, animated: true, completion: { _ in })
        
    }
    
    func UpdateProfileViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let CreateProfileViewController = storyBoard.instantiateViewController(withIdentifier: "CreateProfileViewController") as! CreateProfileViewController
        CreateProfileViewController.modalTransitionStyle = .crossDissolve
        self.present(CreateProfileViewController, animated: true, completion: { _ in })
        
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
    
    func onGenerateCountryData(text : String){
        let data = SysPara.ARRAY_ALL_DATA
        if let arr = data {
            let country = arr["country"] as? [[String:Any]]
            
            print("country : \(String(describing: country))")
            
            for anItem in country! {
                
                let country_id = anItem["id"] as AnyObject
                let country_name = anItem["country_name"] as AnyObject
                let country_code = anItem["country_code"] as AnyObject
                let country_phone_code = anItem["country_phone_code"] as AnyObject
                
                if(text == country_code as! String){
                    txt_country.text = country_name as! String
                }
                
            }
            
        }
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
        
        
    }
    
    /*********************** END TABLE ******************************/
    
}

