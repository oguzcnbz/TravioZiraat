
import UIKit


class MainTabbar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = setupControllers()
        self.selectedIndex = 0
        self.tabBar.tintColor = UIColor(hex: "38ADA9")
        self.tabBar.unselectedItemTintColor = UIColor(hex: "999999")
        self.tabBar.backgroundColor = UIColor(white: 1, alpha: 0.9)
        self.tabBar.isTranslucent = false

        self.navigationItem.setHidesBackButton(true, animated: false)


    }
    
    
  

    
    
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
        
            /*  let addSegmentedVC1 = AddSegmentedVC()
        let addSegmentedNC1 = UINavigationController(rootViewController: addSegmentedVC1)
        let imageAddSegmented1 =  UIImage(systemName: "recordingtape.circle")
        let selectedImageAddSegmented1 = UIImage(systemName: "recordingtape.circle")
        addSegmentedVC.tabBarItem = UITabBarItem(title: "VoiceMail", image: imageAddSegmented1, selectedImage: selectedImageAddSegmented1)
        */
        
        return [homeNC, myVistNC, mapNC,settingsNC]
    }
    

}
