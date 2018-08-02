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
    
    // :widget
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet var img_back: UIImageView!
    @IBOutlet weak var btn_save: UIButton!
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
    
    /*********************** START TABLE ******************************/
    let reuseIdentifier = "RowInterest"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection_focus_area.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
   /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfItems = CGFloat(collectionView.numberOfItems(inSection: section))
        let combinedItemWidth = (numberOfItems * flowLayout.itemSize.width) + ((numberOfItems - 1)  * flowLayout.minimumInteritemSpacing)
        let padding = (collectionView.frame.width - combinedItemWidth) / 2
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }*/
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Getting the right element
        let model = collection_focus_area[indexPath.row]
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RowInterest
        
        cell.txt_title.text = model.focus_name
        print(model.focus_name)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        let model = collection_focus_area[indexPath.row]
        
    }
    
    /*********************** END TABLE ******************************/
    
    // :click btn-back
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

