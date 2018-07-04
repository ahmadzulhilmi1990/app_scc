import UIKit

class MessagingViewController: TabVCTemplate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 2
        // do stuff here
        self.title = "Message"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "RNS Camelia", size: 15)!]
        
        if let tabItems = self.tabBarController?.tabBar.items as NSArray!
        {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[2] as! UITabBarItem
            tabItem.badgeValue = nil
        }
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MessagingViewController Loaded...")
    }
    
}



