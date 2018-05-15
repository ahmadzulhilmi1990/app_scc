
import UIKit

class NotificationViewController: TabVCTemplate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 3
        // do stuff here
        self.title = "Notification"
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
}
