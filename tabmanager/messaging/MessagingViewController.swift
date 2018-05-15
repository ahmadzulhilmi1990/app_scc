import UIKit

class MessagingViewController: TabVCTemplate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 2
        // do stuff here
        self.title = "Message"
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    /*
     // :click btn-sign-up
     @IBAction func toFilterViewController(_ sender: Any) {
     FilterViewController()
     }
     
     func FilterViewController() {
     
     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     let FilterViewController = storyBoard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
     FilterViewController.modalTransitionStyle = .crossDissolve
     self.present(FilterViewController, animated: true, completion: { _ in })
     
     }*/
    
}



