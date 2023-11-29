import UIKit


class MainTabbar: UITabBarController {
    
    //MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = setupControllers()
        self.selectedIndex = 0
        self.tabBar.tintColor = ColorStyle.primary.color
        self.tabBar.unselectedItemTintColor = ColorStyle.greySpanish.color
        self.tabBar.backgroundColor = UIColor(white: 1, alpha: 0.9)
        self.tabBar.isTranslucent = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = true
    }

    //MARK: -- Private Methods
    private func setupControllers()->[UIViewController]{
        
        let homeVC = HomeVC()
        let homeNC = UINavigationController(rootViewController: homeVC)
        let imageHome =  UIImage(named: "icHome")
        let selectedImageHome = UIImage(named: "icHome")
       
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: imageHome, selectedImage: selectedImageHome)
        
        
        let mapVC = MapVC()
        let mapNC = UINavigationController(rootViewController: mapVC)
        let imageMap =  UIImage(named: "icMap")
        let selectedImageMap = UIImage(named: "icMap")
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: imageMap, selectedImage: selectedImageMap)
        
    
        let settingsVC = SettingsVC()
        let settingsNC = UINavigationController(rootViewController: settingsVC)
        let imageSettings =  UIImage(named: "icMenu")
        let selectedImageSettings = UIImage(named: "icMenu")
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: imageSettings, selectedImage: selectedImageSettings)
        
        let myVistVC = MyVisitVC()
        let myVistNC = UINavigationController(rootViewController: myVistVC)
        let imageVisit = UIImage(named: "icVisitGray")
        let selectedImageMyVisit = UIImage(named: "icVisitGray")
        myVistVC.tabBarItem = UITabBarItem(title: "My Visit", image: imageVisit, selectedImage: selectedImageMyVisit)
        
        return [homeNC, myVistNC, mapNC,settingsNC]
    }
}
