//
//  FilterViewController.swift
//  
//
//  Created by user on 10/05/2018.
//  Copyright © 2018 Nemi. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    // :variable
    var collection_focus_area: [FocusArea] = []
    var focus_id: String?
    var focus_name: String?
    var focus_code: String?
    
    // :widget
    @IBOutlet var btn_new_user: UIButton!
    @IBOutlet var btn_all_user: UIButton!
    @IBOutlet var btn_reset_filter: UIButton!
    @IBOutlet var box_reset: UILabel!
    @IBOutlet var box_approval: UILabel!
    @IBOutlet var box_block: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var img_new_user: UIImageView!
    @IBOutlet var img_all_user: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // :button new-user
        /*btn_new_user.backgroundColor = .clear
        btn_new_user.layer.cornerRadius = 10
        btn_new_user.layer.borderWidth = 1
        btn_new_user.layer.borderColor = UIColor.black.cgColor
        
        // :button all-user
        btn_all_user.backgroundColor = .clear
        btn_all_user.layer.cornerRadius = 10
        btn_all_user.layer.borderWidth = 1
        btn_all_user.layer.borderColor = UIColor.black.cgColor*/
        
        // :box_reset
        box_reset.backgroundColor = .clear
        box_reset.layer.cornerRadius = 10
        box_reset.layer.borderWidth = 1
        box_reset.layer.borderColor = UIColor.gray.cgColor
        
        // :box_approval
        box_approval.backgroundColor = .clear
        box_approval.layer.cornerRadius = 10
        box_approval.layer.borderWidth = 1
        box_approval.layer.borderColor = UIColor.gray.cgColor
        
        // :box_block
        box_block.backgroundColor = .clear
        box_block.layer.cornerRadius = 10
        box_block.layer.borderWidth = 1
        box_block.layer.borderColor = UIColor.gray.cgColor
        
        DispatchQueue.main.async {
            
            let arr = SysPara.ARRAY_FILTER_FOCUS_AREA
            if arr.contains("New Users") {
                self.img_new_user.image = self.img_new_user.image!.withRenderingMode(.alwaysTemplate)
                self.img_new_user.tintColor = UIColor.green
             }else{
                self.img_new_user.image = self.img_new_user.image!.withRenderingMode(.alwaysTemplate)
                self.img_new_user.tintColor = UIColor.gray
            }
            
            if arr.contains("All Users") {
                self.img_all_user.image = self.img_all_user.image!.withRenderingMode(.alwaysTemplate)
                self.img_all_user.tintColor = UIColor.green
            }else{
                self.img_all_user.image = self.img_all_user.image!.withRenderingMode(.alwaysTemplate)
                self.img_all_user.tintColor = UIColor.gray
            }
            
            self.onGenerateFocusAreaData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*********************** START TABLE ******************************/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection_focus_area.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // grouped vertical sections of the tableview
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Getting the right element
        let model = collection_focus_area[indexPath.row]
        
        // RowDeviceCell Adapter
        let cellIdentifier = "RowFilter"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RowFilter
        
        //cell.sizeToFit()
        //self.tableView.rowHeight = 50.0
        
        //user name
        cell.txt_title?.text = model.focus_name
        //cell.txt_title?.font = UIFont(name: "RNS Camelia", size: 12)!
        
        let arr = SysPara.ARRAY_FILTER_FOCUS_AREA
        print(arr)
        
        if arr.contains(model.focus_code!) {
            cell.img_tick.image = cell.img_tick.image!.withRenderingMode(.alwaysTemplate)
            cell.img_tick.tintColor = UIColor.green
        }else{
            cell.img_tick.image = cell.img_tick.image!.withRenderingMode(.alwaysTemplate)
            cell.img_tick.tintColor = UIColor.gray
        }
        
        // Returning the cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let model = collection_focus_area[row]
        let fcode = model.focus_code
        
        let arr = SysPara.ARRAY_FILTER_FOCUS_AREA
        if(arr.isEmpty){
            print("ADDED!")
            SysPara.ARRAY_FILTER_FOCUS_AREA.append(fcode as String!)
        }else{
            for id in arr {
                if(model.focus_code == id){ // remove from filter
                    print("REMOVE!")
                    SysPara.ARRAY_FILTER_FOCUS_AREA = SysPara.ARRAY_FILTER_FOCUS_AREA.filter { $0 != id }
                }else{ // added filter
                    print("ADDED!")
                    SysPara.ARRAY_FILTER_FOCUS_AREA.append(fcode as String!)
                }
            }
        }
        //DispatchQueue.main.async { self.tableView.reloadData() }
        DispatchQueue.main.async {
            print("ARRAY_FILTER_FOCUS_AREA = \(SysPara.ARRAY_FILTER_FOCUS_AREA)")
            self.collection_focus_area.removeAll()
            self.onGenerateFocusAreaData()
        }
        
    }
    
    /*********************** END TABLE ******************************/
    
    func onGenerateFocusAreaData(){
        let data = SysPara.ARRAY_ALL_DATA
        if let arr = data {
            let focus_area = arr["focus_area"] as? [[String:Any]]
            //let country = arr["country"] as? [[String:Any]]
            //let experience_role = arr["experience_role"] as? [[String:Any]]
            
            print("focus_area : \(String(describing: focus_area))")
            //print("experience_role : \(String(describing: SysPara.ARRAY_EXPERIENCE_ROLE))")
            //print("country : \(String(describing: SysPara.ARRAY_COUNTRY))")
            
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
                DispatchQueue.main.async { self.tableView.reloadData() }
             
             }
            
        }
    }
    
    // :click button approval
    @IBAction func toPendingApproval(sender: AnyObject){
        
        SysPara.TO_TAB = "1"
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ApprovalViewController = storyBoard.instantiateViewController(withIdentifier: "ApprovalViewController") as! ApprovalViewController
        ApprovalViewController.modalTransitionStyle = .crossDissolve
        self.present(ApprovalViewController, animated: true, completion: { _ in })
    }
    
    // :click button block
    @IBAction func toBlock(sender: AnyObject){
        
        SysPara.TO_TAB = "1"
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let BlockViewController = storyBoard.instantiateViewController(withIdentifier: "BlockViewController") as! BlockViewController
        BlockViewController.modalTransitionStyle = .crossDissolve
        self.present(BlockViewController, animated: true, completion: { _ in })
    }
    
    // :click btn-new-user
    @IBAction func onFilterNewUser(sender: AnyObject){
     
        if(img_new_user.tintColor == UIColor.green){ // Remove from filter
            print("REMOVE!")
            SysPara.ARRAY_FILTER_FOCUS_AREA = SysPara.ARRAY_FILTER_FOCUS_AREA.filter { $0 != "New Users" }
            img_new_user.image = img_new_user.image!.withRenderingMode(.alwaysTemplate)
            img_new_user.tintColor = UIColor.gray
        }else{
            print("ADDED!")
            SysPara.ARRAY_FILTER_FOCUS_AREA.append("New Users")
            img_new_user.image = img_new_user.image!.withRenderingMode(.alwaysTemplate)
            img_new_user.tintColor = UIColor.green
        }
        
    }
    
    // :click btn-all-user
    @IBAction func onFilterAllUser(sender: AnyObject){
        
        if(img_all_user.tintColor == UIColor.green){ // Remove from filter
            print("REMOVE!")
            SysPara.ARRAY_FILTER_FOCUS_AREA = SysPara.ARRAY_FILTER_FOCUS_AREA.filter { $0 != "All Users" }
            img_all_user.image = img_all_user.image!.withRenderingMode(.alwaysTemplate)
            img_all_user.tintColor = UIColor.gray
        }else{
            print("ADDED!")
            SysPara.ARRAY_FILTER_FOCUS_AREA.append("All Users")
            img_all_user.image = img_all_user.image!.withRenderingMode(.alwaysTemplate)
            img_all_user.tintColor = UIColor.green
        }
        
    }

    // :click btn-reset
    @IBAction func onFilterReset(sender: AnyObject){
        
        SysPara.TO_TAB = "1"
        SysPara.ARRAY_FILTER_FOCUS_AREA.removeAll()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ContainerVC = storyBoard.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
        ContainerVC.modalTransitionStyle = .crossDissolve
        self.present(ContainerVC, animated: true, completion: { _ in })
        
    }
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

}

