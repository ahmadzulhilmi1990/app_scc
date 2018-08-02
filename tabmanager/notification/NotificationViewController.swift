
import UIKit

class NotificationViewController: TabVCTemplate,UITableViewDataSource, UITableViewDelegate {
    
    // :widget
    @IBOutlet var tableView: UITableView!
    @IBOutlet var txt_recent: UILabel!
    
    // :variable
    var collection_news: [News] = []
    var id: String?
    var news_id: String?
    var news_type: String?
    var news_title: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 3
        // do stuff here
        self.title = "Notification"
        //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "RNS Camelia", size: 15)!]
        
        txt_recent.font = UIFont(name: "RNS Camelia", size: 14)!
        
        if let tabItems = self.tabBarController?.tabBar.items as NSArray!
        {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[3] as! UITabBarItem
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
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("NotificationViewController Loaded...")
    }
    
    func GET(token: String){
        
        let myUrl = URL(string: SysPara.API_NEWS+SysPara.TOKEN)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
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
                //print("jsonString: \(String(describing: jsonString))")
                
                if let parseJSON = jsonString {
                    
                    let status = parseJSON["status"] as? String
                    let arr = parseJSON["data"] as? NSDictionary
                    //print("status: \(String(describing: status))")
                    //print("arr: \(String(describing: arr))")
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.onGenerateNews(data: arr)
                        
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
    
    func onGenerateNews(data: NSDictionary?){
        
        if let userArr = data {
            let message = userArr["message"]
            let parent_news = userArr["news"] as? NSDictionary
            //print("message : \(String(describing: message))")
            //print("parent_news : \(String(describing: parent_news))")
            
            if let arr = parent_news {
                
                let current_page = arr["current_page"]
                let child_data = arr["data"] as? [[String:Any]]
                print("child_data : \(String(describing: child_data))")
                print("current_page : \(String(describing: current_page))")
                
                for anItem in child_data! {
                    
                    let id = anItem["id"] as Any!
                    let news_id = anItem["news_id"] as Any!
                    let news_type = anItem["news_type"] as Any!
                    let news_title = anItem["news_title"] as Any!
                    let news_description = anItem["news_description"] as Any!
                    let created_at = anItem["created_at"] as Any!
                    let updated_at = anItem["updated_at"] as Any!
                    let news_image = ""
                    let current_page = ""
                    
                    print("id : \(String(describing: id))")
                    print("news_id : \(String(describing: news_id))")
                    print("news_type : \(String(describing: news_type))")
                    print("news_title : \(String(describing: news_title))")
                    print("news_description : \(String(describing: news_description))")
                    print("created_at : \(String(describing: created_at))")
                    print("updated_at : \(String(describing: updated_at))")
                    
                    let arr_news = News(id: String(describing: id) as! String , news_id: news_id! as! String, news_type: news_type! as! String, news_title: news_title! as! String, news_description: news_description! as! String,news_image: news_image as! String, created_at: created_at! as! String, updated_at: updated_at! as! String, current_page: current_page as! String)
                    
                    print(arr_news)
                    collection_news.append(arr_news)
                    DispatchQueue.main.async { self.tableView.reloadData() }
                    
                }
                
            }
            
        }
    }
    
    /*********************** START TABLE ******************************/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection_news.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // grouped vertical sections of the tableview
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Getting the right element
        let model = collection_news[indexPath.row]
        
        // RowDeviceCell Adapter
        let cellIdentifier = "RowConnects"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RowConnects
        
        //cell.sizeToFit()
        //self.tableView.rowHeight = 50.0
        
        //device name
        cell.txt_title?.text = model.news_title
        cell.txt_title?.font = UIFont(name: "RNS Camelia", size: 12)!
        cell.txt_position?.font = UIFont(name: "RNS Camelia", size: 10)!
        //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Grotesque MT", size: 15)!]
        
        //cell.txt_desc?.text = model.news_description
        //cell.txt_desc?.sizeToFit()
        //if let imgdata = model.news_image, imgdata.count > 0 {
        //  cell.img_view.downloadedFrom(link: model.news_image!)
        //}
        
        // Returning the cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let model = collection_news[row]
        print(" : \(String(describing: model.news_title))")
        SysPara.TO_TAB = "3"
        SysPara.USERDETAILS_ID = model.news_id!
        
        onTapCustomAlertButton()
    }
    
    /*********************** END TABLE ******************************/
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func onTapCustomAlertButton() {
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertDialogViewController") as! CustomAlertDialogViewController
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.delegate = self
        self.present(customAlert, animated: true, completion: nil)
    }
    
}

extension NotificationViewController: CustomAlertViewDelegate {
    func okButtonTapped(selectedOption: String) {
        
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }
}
