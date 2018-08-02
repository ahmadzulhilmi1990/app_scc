import UIKit

class ConnectPeopleViewController: TabVCTemplate,UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // :widget
    @IBOutlet weak var textBox: UILabel!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    // :variable
    var list = ["please select"]
    var collection_users: [Users] = []
    
    // :variable-search
    var array_data: NSDictionary = [:]
    var searchActive : Bool = false
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 1
        // do stuff here
        
        print("hi connect view...")
        self.title = "Connect"
        //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "RNS Camelia", size: 15)!]
        
        textBox.font = UIFont(name: "RNS Camelia", size: 14)!
        dropDown.isHidden = true
        searchBar.delegate = self
        
        if let tabItems = self.tabBarController?.tabBar.items as NSArray!
        {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[1] as! UITabBarItem
            tabItem.badgeValue = nil
        }
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                SwiftLoader.show(title: "please wait...",animated: true)
                self.GET(token: SysPara.TOKEN)
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
        textBox.isHidden = true
        /*let tap = UITapGestureRecognizer(target: self, action: #selector(ConnectPeopleViewController.tapFunction))
        textBox.isUserInteractionEnabled = true
        textBox.addGestureRecognizer(tap)
        
        textBox.layer.cornerRadius = 8
        textBox.layer.borderWidth = 0.5
        textBox.layer.borderColor = UIColor.gray.cgColor*/
        
        onGenerateData()
        
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ConnectPeopleViewController Loaded...")
    }
    
    func GET(token: String){
        
        let myUrl = URL(string: SysPara.API_CONNECTS+SysPara.TOKEN)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //let param = "token="+SysPara.TOKEN+"&connectUserID=ivcWVQl4"
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
                    print("data: \(String(describing: arr))")
                    self.array_data = (parseJSON["data"] as? NSDictionary)!
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.userLists(data: arr, search: "")
                        
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
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    /****************** START PICKER FOCUS AREA *********************/
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let data = self.list[row]
        self.textBox.text = data
        self.dropDown.isHidden = true
        refreshData(text: data)
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        self.dropDown.isHidden = true
    }
    
    func onGenerateData(){
        let data = SysPara.ARRAY_ALL_DATA
        if let arr = data {
            //let focus_area = arr["focus_area"] as? [[String:Any]]
            //let country = arr["country"] as? [[String:Any]]
            let experience_role = arr["experience_role"] as? [[String:Any]]
            
            print("experience_role : \(String(describing: experience_role))")
            //print("experience_role : \(String(describing: SysPara.ARRAY_EXPERIENCE_ROLE))")
            //print("country : \(String(describing: SysPara.ARRAY_COUNTRY))")
            
            for anItem in experience_role! {
                
                let role_id = anItem["id"] as AnyObject
                let role_code = anItem["role_code"] as AnyObject
                let role_name = anItem["role_name"] as AnyObject
                print("role_id : \(String(describing: role_id))")
                print("role_code : \(String(describing: role_code))")
                print("role_name : \(String(describing: role_name))")
                let data = (role_name as! String) + " | " + (role_code as! String)
                list.append(role_name as! String)
                
            }
            
        }
    }
    
    /****************** END PICKER FOCUS AREA *********************/
    
    /*********************** START TABLE ******************************/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection_users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // grouped vertical sections of the tableview
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Getting the right element
        let model = collection_users[indexPath.row]
        
        // RowDeviceCell Adapter
        let cellIdentifier = "RowConnects"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RowConnects
        
        //cell.sizeToFit()
        //self.tableView.rowHeight = 50.0
        
        //user name
        cell.txt_title?.text = model.user_fullname
        //cell.txt_title?.font = UIFont(name: "RNS Camelia", size: 12)!
        //cell.txt_position?.font = UIFont(name: "RNS Camelia", size: 10)!
        
        cell.img_view.image = cell.img_view.image!.withRenderingMode(.alwaysTemplate)
        cell.img_view.tintColor = hexStringToUIColor(hex: "#b4b4b4")
        
        let imgdata = model.photo_url
        if((imgdata?.characters.count)! > 0){
            if Connection.isConnectedToNetwork() == true {
                DispatchQueue.main.async {
                    cell.img_view.downloadedFrom(link: model.photo_url!)
                }
            }
        }

        
        // Returning the cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let model = collection_users[row]
        let userID = model.user_id
        let arr1 = userID?.replacingOccurrences(of: "Optional(", with: "")
        let uid = arr1?.replacingOccurrences(of: ")", with: "")
        print("userID : \(String(describing: uid))")
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                SysPara.TO_TAB = "1"
                SysPara.USERDETAILS_ID = uid!
                self.UserDetailsViewController()
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
    }
    
    /*********************** END TABLE ******************************/
    
    /*********************** START SEARCH BAR ***********************/
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchActive = true;
        self.searchBar.showsCancelButton = false
        
        if(searchText.characters.count > 3){
            
            if Connection.isConnectedToNetwork() == true {
                
                DispatchQueue.main.async {
                    SwiftLoader.show(title: "please wait...",animated: true)
                    self.collection_users.removeAll()
                    self.POST_SEARCH(token: SysPara.TOKEN, name: searchText, fcode: "", rcode: "")
                }
                
            }else{
                showDialog(description: SysPara.ERROR_NETWORK,id: 0)
            }
            
        }
    }
    
    /*********************** END SEARCH BAR ***********************/
    
    func refreshData(text: String){
        
        print("text: \(String(describing: text))")
        print("array_data: \(String(describing: array_data))")
        
        if Connection.isConnectedToNetwork() == true {
            SwiftLoader.show(title: "please wait...",animated: true)
            DispatchQueue.main.async {
                self.collection_users.removeAll()
                SwiftLoader.hide()
                self.userLists(data: self.array_data, search: text)
                
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
        
    }
    
    func POST_SEARCH(token: String, name: String, fcode: String, rcode: String){
        
        let myUrl = URL(string: SysPara.API_SEARCH)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let param = "token="+SysPara.TOKEN+"&name="+name+"&fcode="+fcode+"&rcode="+rcode
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
                    
                    let status = parseJSON["status"] as? String
                    let arr = parseJSON["data"] as? NSDictionary
                    print("status: \(String(describing: status))")
                    print("arr: \(String(describing: arr))")
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.onSearchUser(data: arr, search: "")
                        
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
    
    func onSearchUser(data: NSDictionary?, search: String){
        
        if let userArr = data {
            let user_list = userArr["user_list"] as? [[String:Any]]
            print("onSearchUser : \(String(describing: user_list))")
            
                for anItem in user_list! {
                    
                    let user_id = anItem["user_id"] as Any!
                    let fullname = anItem["fullname"] as Any!
                    let email = anItem["email"] as Any!
                    let gender = anItem["gender"] as Any!
                    let role_code = anItem["role_code"] as Any!
                    let focus_code = anItem["focus_code"] as Any!
                    let photo_url = anItem["photo_url"] as Any!
                    
                    print("user_id : \(String(describing: user_id))")
                    print("fullname : \(String(describing: fullname))")
                    print("email : \(String(describing: email))")
                    print("gender : \(String(describing: gender))")
                    print("role_code : \(String(describing: role_code))")
                    print("focus_code : \(String(describing: focus_code))")
                    
                    let arr_users = Users(user_id: String(describing:user_id), user_email: email as! String, user_fullname: fullname as! String, user_gender: gender as! String, user_role_code: role_code as! String,user_focus_code: focus_code as! String,photo_url: photo_url as! String)
                    
                    print(arr_users)
                    collection_users.append(arr_users)
                    DispatchQueue.main.async { self.tableView.reloadData() }
                    
                }
        }
    }
    
    func userLists(data: NSDictionary?, search : String){
        
        if let userArr = data {
            let user_list = userArr["list"] as? [[String:Any]]
            print("user_list : \(String(describing: user_list))")
            
            for anItem in user_list! {
                
                let user_id = anItem["user_id"] as Any!
                let fullname = anItem["fullname"] as Any!
                let email = ""
                let gender = anItem["gender"] as Any!
                let role_code = anItem["role_code"] as Any!
                let focus_code = anItem["focus_code"] as Any!
                let photo_url = anItem["photo_url"] as Any!
                
                print("user_id : \(String(describing: user_id))")
                print("fullname : \(String(describing: fullname))")
                print("email : \(String(describing: email))")
                print("gender : \(String(describing: gender))")
                print("role_code : \(String(describing: role_code))")
                print("focus_code : \(String(describing: focus_code))")
                
                if(search.characters.count > 0 && search != "please select"){
                    collection_users.removeAll()
                    let fcode = String(describing: focus_code)
                    if(fcode == search) {
                    
                        let arr_users = Users(user_id: String(describing:user_id), user_email: email , user_fullname: fullname as! String, user_gender: gender as! String, user_role_code: role_code as! String,user_focus_code: focus_code as! String, photo_url: photo_url as! String)
                        
                        print(arr_users)
                        collection_users.append(arr_users)
                        
                    }
                    DispatchQueue.main.async { self.tableView.reloadData() }
                
                }else{
                    
                    let arr_users = Users(user_id: String(describing:user_id), user_email: email , user_fullname: fullname as! String, user_gender: gender as! String, user_role_code: role_code as! String,user_focus_code: focus_code as! String, photo_url: photo_url as! String)
                    
                    print(arr_users)
                    collection_users.append(arr_users)
                    DispatchQueue.main.async { self.tableView.reloadData() }
                    
                }
                
            }
        }
    }
    
    @IBAction func toFilterDataViewController(sender: AnyObject){
        FilterDataViewController()
    }
    
    func FilterDataViewController() {
        SysPara.TO_TAB = "1"
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let FilterDataViewController = storyBoard.instantiateViewController(withIdentifier: "FilterDataViewController") as! FilterDataViewController
        FilterDataViewController.modalTransitionStyle = .crossDissolve
        self.present(FilterDataViewController, animated: true, completion: { _ in })
        
    }
    
    func UserDetailsViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let UserDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        UserDetailsViewController.modalTransitionStyle = .crossDissolve
        self.present(UserDetailsViewController, animated: true, completion: { _ in })
        
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
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


