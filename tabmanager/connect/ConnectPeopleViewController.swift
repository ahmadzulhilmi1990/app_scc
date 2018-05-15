import UIKit

class ConnectPeopleViewController: TabVCTemplate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 1
        // do stuff here
        
        print("update...")
        self.title = "Connect"
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
}


