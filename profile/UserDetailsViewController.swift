//
//  UserDetailsViewController.swift
//  SupplyChainCity
//
//  Created by user on 25/06/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {

    // :variable
    var collection_focus_area: [FocusArea] = []
    var collection_experience_role: [ExperienceRole] = []
    
    // :widget
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var myCollectionRole: UICollectionView!
    @IBOutlet var img_back: UIImageView!
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var btn_message: UIButton!
    @IBOutlet var btn_call: UIButton!
    @IBOutlet var btn_email: UIButton!
    @IBOutlet var txt_username: UILabel!
    @IBOutlet var txt_works: UILabel!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var txt_country: UILabel!
    @IBOutlet var txt_gender: UILabel!
    @IBOutlet var txt_email: UILabel!
    @IBOutlet var txt_contact_no: UILabel!
    @IBOutlet var txt_social_media_fb: UILabel!
    @IBOutlet var txt_social_media_linked: UILabel!
    @IBOutlet var txt_social_media_insta: UILabel!
    @IBOutlet var txt_description: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        
        self.scrollview.contentSize.height = 850;
        
        self.img_back.image = self.img_back.image!.withRenderingMode(.alwaysTemplate)
        self.img_back.tintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        //txt_title_header?.font = UIFont(name: "RNS Camelia", size: 14)!
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                SwiftLoader.show(title: "please wait...",animated: true)
                self.GET(token: SysPara.TOKEN)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
        onGenerateFocusAreaData()
        onGenerateExperienceRoleData()
        
        print("ARRAY_FILTER_INDUSTRY = \(SysPara.ARRAY_FILTER_INDUSTRY)")
        print("ARRAY_FILTER_EXPERIENCE_ROLE = \(SysPara.ARRAY_FILTER_EXPERIENCE_ROLE)")
        
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
    
    @IBAction func toBack(sender: AnyObject){
        TabManagerViewController()
    }
    
    @IBAction func clickCall(sender: AnyObject){
        var num = txt_contact_no.text
        if((num?.characters.count)! > 0){
            //UIApplication.sharedApplication().openURL(NSURL(string: "tel://9809088798")!)
            if let url = URL(string: "tel//:\(num)") {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }else{
            showDialog(description: "Invalid Phone Number.",id: 0)
        }
        
    }
    
    @IBAction func clickEmail(sender: AnyObject){
        var email = txt_email.text
        guard let url = URL(string: "mailto:\(email)") else { return }
        
        if((email?.characters.count)! > 0){
            UIApplication.shared.openURL(url)
        }else{
            showDialog(description: "Invalid Email Address.",id: 0)
        }
    }
    
    @IBAction func clickMessage(sender: AnyObject){
    
    }
    
    func TabManagerViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
        
    }
    
    func GET(token: String){
        
        let userID = SysPara.USERDETAILS_ID
        let myUrl = URL(string: SysPara.API_USERDETAILS+userID+"/"+SysPara.TOKEN)
        print("myurl : \(myUrl)")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //let param = "token="+SysPara.TOKEN+"&userID="+userID
        //request.httpBody = param.data(using: String.Encoding.utf8)
        
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
                    
                    let status = parseJSON["status"] as? String
                    let arr = parseJSON["data"] as? NSDictionary
                    print("status: \(String(describing: status))")
                    print("arr: \(String(describing: arr))")
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.onGenerateUsers(data: arr)
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
    
    func onGenerateUsers(data: NSDictionary?){
        
        if let userArr = data {
            let user_list = userArr["info"] as? NSDictionary
            print("user_list : \(String(describing: user_list))")
            
            if let arr = user_list {
                
                let user_id = (arr["user_id"] as! NSString) as String
                let fullname = (arr["fullname"] as! NSString) as String
                let email = (arr["email"] as! NSString) as String
                let gender = (arr["gender"] as! NSString) as String
                let role_code = (arr["role_code"] as! NSString) as String
                let focus_code = (arr["focus_code"] as! NSString) as String
                let about_me = (arr["about_me"] as! NSString) as String
                let country_code = (arr["country_code"] as! NSString) as String
                let facebook = (arr["facebook"] as! NSString) as String
                let instagram = (arr["instagram"] as! NSString) as String
                let linkedIn = (arr["linkedIn"] as! NSString) as String
                let phone_no = (arr["phone_no"] as! NSString) as String
                
                print("user_id : \(String(describing: user_id))")
                print("fullname : \(String(describing: fullname))")
                print("email : \(String(describing: email))")
                print("gender : \(String(describing: gender))")
                print("role_code : \(String(describing: role_code))")
                print("focus_code : \(String(describing: focus_code))")
                print("about_me : \(String(describing: about_me))")
                print("country_code : \(String(describing: country_code))")
                print("facebook : \(String(describing: facebook))")
                print("instagram : \(String(describing: instagram))")
                print("linkedIn : \(String(describing: linkedIn))")
                print("phone_no : \(String(describing: phone_no))")
                
                // :settting value to text or label
                txt_username.text = fullname
                txt_email.text = email
                txt_contact_no.text = phone_no
                txt_social_media_fb.text = facebook
                txt_social_media_linked.text = linkedIn
                txt_social_media_insta.text = instagram
                txt_description.text = about_me
                
                if(gender == "M"){
                    txt_gender.text = "Male"
                }else{
                    txt_gender.text = "Female"
                }
                
                onGenerateCountryData(text: country_code)
            }
            
        }
    }
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
            }else{
                self.TabManagerViewController()
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
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
