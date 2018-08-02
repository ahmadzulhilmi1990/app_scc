//
//  CreateProfileViewController.swift
//  SupplyChainCity
//
//  Created by user on 22/07/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit


class CreateProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
   
    

    // :class
    let picker = UIImagePickerController()
    
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
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var txt_username: UITextField!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var txt_title: UITextField!
    @IBOutlet var txt_company: UITextField!
    @IBOutlet var txt_interest: UITextField!
    @IBOutlet var txt_about_me: UITextView!
    @IBOutlet var txt_country: UITextField!
    @IBOutlet var txt_email: UITextField!
    @IBOutlet var txt_contact_no: UITextField!
    @IBOutlet var txt_contact_no_code: UITextField!
    @IBOutlet var txt_social_media_fb: UITextField!
    @IBOutlet var txt_social_media_linked: UITextField!
    @IBOutlet var txt_social_media_insta: UITextField!
    @IBOutlet var box_industry: UIView!
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
        txt_interest.backgroundColor = .clear
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
        chk_male.layer.cornerRadius = 5
        
        chk_female.layer.masksToBounds = true
        chk_female.layer.cornerRadius = 5
        
        self.avatar.image = self.avatar.image!.withRenderingMode(.alwaysTemplate)
        self.avatar.tintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.picker_country.delegate = self
        self.picker_country.dataSource = self
        picker_country.isHidden = true
        onGenerateCountryData()
        
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
            interest = txt_interest.text
            country = txt_country.text
            email = txt_email.text
            contact_no = txt_contact_no_code.text! + "-" + txt_contact_no.text!
            social_media_fb = txt_social_media_fb.text
            social_media_linked = txt_social_media_linked.text
            social_media_insta = txt_social_media_insta.text
            
            if(fullname.isEmpty == false && company.isEmpty == false && title_.isEmpty == false && company.isEmpty == false && contact_no.isEmpty == false){
                
                DispatchQueue.main.async {
                    //SwiftLoader.show(title: "please wait...",animated: true)
                    //self.PUT(session: SysPara.TOKEN, role_code: self.role, focus_code: self.focus_area,country_code: self.country, about_me: self.about_me, gender: self.gender, phone_no: self.contact_no, fullname: self.title_, facebook: self.social_media, linkedIn: self.social_media, instagram: self.social_media)
                }
                
            }else{
                showDialog(description: "Please fill up form!",id: 0)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
    }
    

    // :click btn-back
    @IBAction func toBack(sender: AnyObject){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let SignInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        SignInViewController.modalTransitionStyle = .crossDissolve
        self.present(SignInViewController, animated: true, completion: { _ in })
    }
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
                
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
    
}
