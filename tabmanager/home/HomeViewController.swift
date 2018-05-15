import UIKit

class HomeViewController: TabVCTemplate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 0
        // do stuff here
        
        self.title = "Home"
        //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "RNS Camelia", size: 15)!]
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Grotesque MT", size: 15)!]
        
        print("USER EMAIL : \(SysPara.USER_EMAIL)")
        
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
}


