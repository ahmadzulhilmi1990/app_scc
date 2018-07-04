import UIKit

class ContainerVC : UIViewController {
    
    // This value matches the left menu's width in the Storyboard
    let leftMenuWidth:CGFloat = 260
    
    // Need a handle to the scrollView to open and close the menu
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        // Initially close menu programmatically.  This needs to be done on the main thread initially in order to work.
        DispatchQueue.main.async() {
            self.closeMenu(animated: false)
        }
        
        // Tab bar controller's child pages have a top-left button toggles the menu
        NotificationCenter.default.addObserver(self, selector: #selector(ContainerVC.toggleMenu), name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ContainerVC.closeMenuViaNotification), name: NSNotification.Name(rawValue: "closeMenuViaNotification"), object: nil)
        
        // Close the menu when the device rotates
        NotificationCenter.default.addObserver(self, selector: #selector(ContainerVC.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        // LeftMenu sends openModalWindow
        NotificationCenter.default.addObserver(self, selector: #selector(ContainerVC.openModalWindow), name: NSNotification.Name(rawValue: "openModalWindow"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        _ = self.tabBarController?.selectedIndex = 2
    }
    
    // Cleanup notifications added in viewDidLoad
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func openModalWindow() {
        performSegue(withIdentifier: "openModalWindow", sender: nil)
    }
    
    @objc func toggleMenu() {
        scrollView.contentOffset.x == 0  ? closeMenu() : openMenu()
    }
    
    // This wrapper function is necessary because
    // closeMenu params do not match up with Notification
    @objc func closeMenuViaNotification(){
        closeMenu()
    }
    
    // Use scrollview content offset-x to slide the menu.
    func closeMenu(animated:Bool = true){
        scrollView.setContentOffset(CGPoint(x: leftMenuWidth, y: 0), animated: animated)
    }
    
    // Open is the natural state of the menu because of how the storyboard is setup.
    func openMenu(){
        print("opening menu")
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    // see http://stackoverflow.com/questions/25666269/ios8-swift-how-to-detect-orientation-change
    // close the menu when rotating to landscape.
    // Note: you have to put this on the main queue in order for it to work
    @objc func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            DispatchQueue.main.async() {
                print("closing menu on rotate")
                self.closeMenu()
            }
        }
    }
    
}

extension ContainerVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollView.contentOffset.x:: \(scrollView.contentOffset.x)")
    }
   
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = false
    }
}
