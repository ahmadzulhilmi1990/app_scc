//
//  CreateProfileViewController.swift
//  SupplyChainCity
//
//  Created by user on 22/07/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit


class CreateProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDataSource,UICollectionViewDelegate {
   

    // :class
    let picker = UIImagePickerController()
    var collection_focus_area: [FocusArea] = []
    var collection_experience_role: [ExperienceRole] = []
    
    // :variable
    var fullname: String!
    var title_: String!
    var company: String!
    var about: String!
    var industry: String!
    var interest: String!
    var country: String!
    var gender: String!
    var email: String!
    var contact_no: String!
    var social_media_fb: String!
    var social_media_linked: String!
    var social_media_insta: String!
    var collection_country: [CollectionCountry] = []
    
    // :widget
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var myCollectionRole: UICollectionView!
    @IBOutlet var img_back: UIImageView!
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var txt_username: UITextField!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var txt_title: UITextField!
    @IBOutlet var txt_company: UITextField!
    @IBOutlet var txt_about_me: UITextView!
    @IBOutlet var txt_country: UITextField!
    @IBOutlet var txt_email: UITextField!
    @IBOutlet var txt_contact_no: UITextField!
    @IBOutlet var txt_contact_no_code: UITextField!
    @IBOutlet var txt_social_media_fb: UITextField!
    @IBOutlet var txt_social_media_linked: UITextField!
    @IBOutlet var txt_social_media_insta: UITextField!
    @IBOutlet var chk_male: UILabel!
    @IBOutlet var chk_female: UILabel!
    @IBOutlet var avatar: UIImageView!
    @IBOutlet weak var picker_country: UIPickerView!
    
    override func viewDidLoad() {
        picker.allowsEditing = true
        picker.delegate = self
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.scrollview.contentSize.height = 1550;
        btn_save.layer.cornerRadius = 8
        txt_username.backgroundColor = .clear
        txt_title.backgroundColor = .clear
        txt_company.backgroundColor = .clear
        txt_about_me.backgroundColor = .clear
        txt_country.backgroundColor = .clear
        txt_email.backgroundColor = .clear
        txt_contact_no.backgroundColor = .clear
        txt_contact_no_code.backgroundColor = .clear
        txt_social_media_fb.backgroundColor = .clear
        txt_social_media_linked.backgroundColor = .clear
        txt_social_media_insta.backgroundColor = .clear
        
        txt_country.isUserInteractionEnabled = false
        txt_contact_no_code.isUserInteractionEnabled = false
        
        chk_male.layer.masksToBounds = true
        chk_male.layer.cornerRadius = 8
        
        chk_female.layer.masksToBounds = true
        chk_female.layer.cornerRadius = 8
        
        self.avatar.image = self.avatar.image!.withRenderingMode(.alwaysTemplate)
        self.avatar.tintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.img_back.image = self.img_back.image!.withRenderingMode(.alwaysTemplate)
        self.img_back.tintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.picker_country.delegate = self
        self.picker_country.dataSource = self
        picker_country.isHidden = true
        onGenerateCountryData()
        
        settingData()
        
    }
    
    func settingData(){
        txt_username.text = SysPara.FULLNAME
        txt_title.text = SysPara.POSITION
        txt_company.text = SysPara.COMPANY
        txt_about_me.text = SysPara.ABOUT_ME
        txt_country.text = SysPara.COUNTRY_CODE
        txt_email.text = SysPara.USER_EMAIL
        txt_contact_no.text = SysPara.PHONE_NO
        txt_social_media_fb.text = SysPara.FACEBOOK
        txt_social_media_linked.text = SysPara.LINKEDIN
        txt_social_media_insta.text = SysPara.INSTAGRAM
        
        onGenerateFocusAreaData()
        onGenerateExperienceRoleData()
        
        print("ARRAY_FILTER_INDUSTRY = \(SysPara.ARRAY_FILTER_INDUSTRY)")
        print("ARRAY_FILTER_EXPERIENCE_ROLE = \(SysPara.ARRAY_FILTER_EXPERIENCE_ROLE)")
        
        
        if(SysPara.GENDER == "M"){
            gender = "M"
            chk_male.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
            chk_female.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
        }
        
        if KeychainWrapper.standardKeychainAccess().setString("ARRAY_FILTER_INDUSTRY", forKey: SysPara.AVATAR_BASE64) {
            print("Successfully added avatar_base64!")
        }
        
        if let ARRAY_FILTER_INDUSTRY = KeychainWrapper.standardKeychainAccess().string(forKey: "ARRAY_FILTER_INDUSTRY") {
            if (ARRAY_FILTER_INDUSTRY.isEmpty == false) {
                print("ARRAY_FILTER_INDUSTRY => \(ARRAY_FILTER_INDUSTRY)")
                
                for id in ARRAY_FILTER_INDUSTRY {
                    //SysPara.ARRAY_FILTER_INDUSTRY.append(String(describing: id))
                }
            }
        }
        
        if let ARRAY_FILTER_EXPERIENCE_ROLE = KeychainWrapper.standardKeychainAccess().string(forKey: "ARRAY_FILTER_EXPERIENCE_ROLE") {
            if (ARRAY_FILTER_EXPERIENCE_ROLE.isEmpty == false) {
                print("ARRAY_FILTER_EXPERIENCE_ROLE => \(ARRAY_FILTER_EXPERIENCE_ROLE)")
                for id in ARRAY_FILTER_EXPERIENCE_ROLE {
                    //SysPara.ARRAY_FILTER_EXPERIENCE_ROLE.append(String(describing: id))
                }
            }
        }
    }
    
    func onGenerateCountryData(){
        let data = SysPara.ARRAY_ALL_DATA
        if let arr = data {
            let country = arr["country"] as? [[String:Any]]
            
            print("country : \(String(describing: country))")
            
            for anItem in country! {
                
                let rowid = anItem["id"] as AnyObject
                let country_name = anItem["country_name"] as AnyObject
                let country_code = anItem["country_code"] as AnyObject
                let country_phone_code = anItem["country_phone_code"] as AnyObject
                print("country_name : \(String(describing: country_name))")
                
                let arr_country = CollectionCountry(id: String(describing: rowid),country_name: String(describing: country_name),country_code: String(describing: country_code),country_phone_code: String(describing: country_phone_code))
                
                print(arr_country)
                collection_country.append(arr_country)
                DispatchQueue.main.async {
                    self.picker_country.reloadAllComponents()
                }
                
            }
            
        }
    }
    
    @IBAction func chkMale(sender: AnyObject){
        gender = "M"
        chk_male.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
        chk_female.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
    }
    
    @IBAction func chkFeMale(sender: AnyObject){
        gender = "F"
        chk_female.backgroundColor = hexStringToUIColor(hex: "#42B4D0")
        chk_male.backgroundColor = hexStringToUIColor(hex: "#D6D6D6")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // :click btn-save
    @IBAction func toSave(sender: AnyObject){
        
        if Connection.isConnectedToNetwork() == true {
            
            fullname = txt_username.text
            title_ = txt_title.text
            company = txt_company.text
            about = txt_about_me.text
            industry = ""
            country = txt_country.text
            email = txt_email.text
            contact_no = txt_contact_no_code.text! + "-" + txt_contact_no.text!
            social_media_fb = txt_social_media_fb.text
            social_media_linked = txt_social_media_linked.text
            social_media_insta = txt_social_media_insta.text
            
            if(fullname.isEmpty == false && company.isEmpty == false && title_.isEmpty == false && company.isEmpty == false && contact_no.isEmpty == false){
                
                DispatchQueue.main.async {
                    SwiftLoader.show(title: "please wait...",animated: true)
                    self.POST_UPDATE(session: SysPara.TOKEN, role_code: "1,2", focus_code: "1,2",country_code: self.country, about_me: "", gender: self.gender, phone_no: self.contact_no, fullname: self.title_, facebook: self.social_media_fb, linkedIn: self.social_media_fb, instagram: self.social_media_insta)
                }
                
            }else{
                showDialog(description: "Please fill up form!",id: 0)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
    }
    
    func POST_UPDATE(session: String, role_code: String, focus_code: String,country_code: String, about_me: String, gender: String, phone_no: String, fullname: String, facebook: String, linkedIn: String, instagram: String){
        
        let myUrl = URL(string: SysPara.API_UPDATE_PROFILE)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let param = "session="+session+"&role_code="+role_code+"&focus_code="+focus_code+"&country_code="+country_code+"&about_me="+about_me+"&gender="+gender+"&phone_no="+phone_no+"&fullname="+fullname+"&facebook="+facebook+"&linkedIn="+linkedIn+"&instagram="+instagram
        
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
                        
                        myFunction().onGenerateUser(data: arr)
                        
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

    // :click btn-back
    @IBAction func toBack(sender: AnyObject){
        
        self.TabManagerViewController()
    }
    
    func TabManagerViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
        
    }
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
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

    // :function image avatar
    @IBAction func clickImage() {
        present(picker, animated: true)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        avatar.layer.borderWidth = 3
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.cornerRadius = 25
        avatar.clipsToBounds = true
        
        picker.dismiss(animated: true, completion: nil)
        let img = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        self.avatar.image = img
        
        //var image : UIImage = img
        //var imageData = UIImagePNGRepresentation(image)
        //let base64String = imageData?.base64EncodedString()
        //print(base64String)
        
        /*if KeychainWrapper.standardKeychainAccess().setString(base64String!, forKey: SysPara.AVATAR_BASE64) {
            print("Successfully added avatar_base64!")
        } else {
            print("Failed added text-email!")
        }*/
        
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }

    // :picker country
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.collection_country.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return collection_country[row].country_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row >= self.collection_country.count {
            return
        }
        
        self.txt_country.text = self.collection_country[row].country_name
        self.txt_contact_no_code.text = self.collection_country[row].country_phone_code
        self.picker_country.isHidden = true
        self.picker_country.resignFirstResponder()
    }
    
    @IBAction func toVisiblePicker(sender: AnyObject){
        self.picker_country.isHidden = false
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
            cell.txt_title.layer.borderWidth = 1.0
            let arr = SysPara.ARRAY_FILTER_EXPERIENCE_ROLE
            print(arr)
            
            let mygreen = hexStringToUIColor(hex: "#42B4D0")
            let mygray = hexStringToUIColor(hex: "#D6D6D6")
            
            if arr.contains(model.role_code!) {
                cell.txt_title.layer.borderColor = mygreen.cgColor
            }else{
                cell.txt_title.layer.borderColor = mygray.cgColor
            }
            
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
                    if(id == model.focus_code){ // remove from filter
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
                print("ARRAY_FILTER_INDUSTRY = \(SysPara.ARRAY_FILTER_INDUSTRY)")
                self.collection_focus_area.removeAll()
                self.onGenerateFocusAreaData()
                let data = SysPara.ARRAY_FILTER_INDUSTRY
                KeychainWrapper.standardKeychainAccess().setString(String(describing: data), forKey: "ARRAY_FILTER_INDUSTRY")
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
                    if(id == model.role_code){ // remove from filter
                        print("REMOVE!")
                        SysPara.ARRAY_FILTER_EXPERIENCE_ROLE = SysPara.ARRAY_FILTER_EXPERIENCE_ROLE.filter { $0 != id }
                    }else{ // added filter
                        print("ADDED!")
                        SysPara.ARRAY_FILTER_EXPERIENCE_ROLE.append(rcode as String!)
                    }
                }
            }
            
            DispatchQueue.main.async {
                print("ARRAY_FILTER_EXPERIENCE_ROLE = \(SysPara.ARRAY_FILTER_EXPERIENCE_ROLE)")
                self.collection_experience_role.removeAll()
                self.onGenerateExperienceRoleData()
                let data = SysPara.ARRAY_FILTER_EXPERIENCE_ROLE
                KeychainWrapper.standardKeychainAccess().setString(String(describing: data), forKey: "ARRAY_FILTER_EXPERIENCE_ROLE")
            }
            
        }
        
    }
    
    /*********************** END TABLE ******************************/
    
}
