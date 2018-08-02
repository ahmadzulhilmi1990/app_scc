import UIKit

class HomeViewController: TabVCTemplate,UITableViewDataSource, UITableViewDelegate {
    
    // :variable
    var collection_news: [News] = []
    var id: String?
    var news_id: String?
    var news_type: String?
    var news_title: String?
    var news_description: String?
    var news_image: String?
    var created_at: String?
    var updated_at: String?
    var current_page: String?
    var countdownTimer: Timer!
    var totalTime = 60
    
    // :widget
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 0
        // do stuff here
        
        self.title = "Home"
        //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "System", size: 15)!]
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        if let tabItems = self.tabBarController?.tabBar.items as NSArray!
        {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[0] as! UITabBarItem
            tabItem.badgeValue = nil
        }
        
        if Connection.isConnectedToNetwork() == true {
            
            DispatchQueue.main.async {
                SwiftLoader.show(title: "please wait...",animated: true)
                self.GET(token: SysPara.TOKEN)
                self.startTimer()
            }
            
        }else{
            showDialog(description: SysPara.ERROR_NETWORK,id: 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeViewController Loaded...")
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    func GET(token: String){
        
        let myUrl = URL(string: SysPara.API_NEWS+SysPara.TOKEN)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //let param = SysPara.TOKEN
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
                    
                    let dateData = created_at as! String!
                    let arrDate = dateData?.components(separatedBy: " ")
                    let full_date = arrDate![0]
                    let full_date_naming = formattedDateFromString(dateString: full_date, withFormat: "dd MMM yyyy")
                    
                    
                    let arr_news = News(id: String(describing: id) as! String , news_id: news_id! as! String, news_type: news_type! as! String, news_title: news_title! as! String, news_description: news_description! as! String,news_image: news_image as! String, created_at: full_date_naming! as! String, updated_at: updated_at! as! String, current_page: current_page as! String)
                    
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
        return 190.0;
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
        let cellIdentifier = "RowNews"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RowNews
        
        //cell.sizeToFit()
        self.tableView.rowHeight = 50.0
        
        //device name
        cell.txt_date?.text = model.created_at
        cell.txt_title?.text = model.news_title
        //cell.txt_title?.font = UIFont(name: "Grotesque MT", size: 16)!
        //cell.txt_desc?.font = UIFont(name: "RNS Camelia", size: 12)!
        //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Grotesque MT", size: 15)!]
        //print(indexPath.row)
        let current_row = indexPath.row + 1
        
        if(collection_news.count > 1){
            if(current_row >= collection_news.count){
                
                let pre_model = collection_news[indexPath.row - 1]
                let pre_date = pre_model.created_at
                
                if(pre_date == model.created_at)
                {
                    cell.txt_date.isHidden = true
                }
            }
        }
        
        cell.txt_desc?.text = model.news_description
        
        // Returning the cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let model = collection_news[row]
        print(" : \(String(describing: model.news_title))")
        
        SysPara.NEW_ROW_ID = model.id!
        SysPara.NEWS_ID = model.news_id!
        SysPara.NEWS_TYPE = model.news_type!
        SysPara.NEWS_TITLE = model.news_title!
        SysPara.NEWS_DESCRIPTION = model.news_description!
        SysPara.NEWS_IMAGE = model.news_image!
        SysPara.NEWS_CREATED_AT = model.created_at!
        SysPara.NEWS_UPDATED_AT = model.updated_at!
        SysPara.NEWS_CURRENT_PAGE = model.current_page!
        
        toNewDetailsViewController()
        SysPara.TO_TAB = "0"
    }
    
    /*********************** END TABLE ******************************/
    
    func toNewDetailsViewController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let NewDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "NewDetailsViewController") as! NewDetailsViewController
        NewDetailsViewController.modalTransitionStyle = .crossDissolve
        self.present(NewDetailsViewController, animated: true, completion: { _ in })
        
    }
    
    func showDialog(description: String!,id: Int){
        let refreshAlert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if(id == 1){
                //self.TabManagerViewController()
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    /************************* START TIMER ********************************/
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
        let currentTime = "\(timeFormatted(totalTime))"
        //print("Time : \(currentTime)")
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
        
        if(currentTime == "00:01" || currentTime == "00:30"){
            POST_GEOFENCE(token: SysPara.TOKEN, action: "IN",locationID: "1")
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func POST_GEOFENCE(token: String, action: String,locationID: String){
        
        let myUrl = URL(string: SysPara.API_GEOFENCE)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type: application/x-www-form-urlencoded")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let param = "token="+token+"&action="+action+"&locationID="+SysPara.LOC_ID+"&deviceType=apple"
        request.httpBody = param.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                //SwiftLoader.hide()
                self.showDialog(description: String(describing: error),id: 0)
                return
            }
            
            do {
                let jsonString = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                print("jsonString: \(String(describing: jsonString))")
                
            } catch {
                //SwiftLoader.hide()
                self.showDialog(description: String(describing: error),id: 0)
                print(error)
            }
        }
        task.resume()
        
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
}


