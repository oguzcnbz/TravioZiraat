//
//  MainTabbar.swift
//  Application
//
//  Created by Ada on 27.10.2023.
//

import UIKit

import UIKit

class MainTabbar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = setupControllers()
        self.selectedIndex = 0
       

    }
    
    
    private func setupControllers()->[UIViewController]{
        
        
        let homeVC = HomeVC()
        let homeNC = UINavigationController(rootViewController: homeVC)
        let imageHome =  UIImage(systemName: "house.fill")
        let selectedImageHome = UIImage(systemName: "house.fill")
       
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: imageHome, selectedImage: selectedImageHome)
        
        
        let mapVC = MapVC()
        let mapNC = UINavigationController(rootViewController: mapVC)
        let imageMap =  UIImage(systemName: "clock.fill")
        let selectedImageMap = UIImage(systemName: "clock.fill")
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: imageMap, selectedImage: selectedImageMap)
        
        
        
        
        let settingsVC = SettingsVC()
        let settingsNC = UINavigationController(rootViewController: settingsVC)
        let imageSettings =  UIImage(systemName: "person.circle")
        let selectedImageSettings = UIImage(systemName: "person.circle")
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: imageSettings, selectedImage: selectedImageSettings)
        
        let myVistVC = MyVisitVC()
        let myVistNC = UINavigationController(rootViewController: myVistVC)
        let imageVisit =  UIImage(systemName: "circle.grid.3x3.fill")
        let selectedImageMyVisit = UIImage(systemName: "circle.grid.3x3.fill")
        myVistVC.tabBarItem = UITabBarItem(title: "My Visit", image: imageVisit, selectedImage: selectedImageMyVisit)
        
            /*  let addSegmentedVC1 = AddSegmentedVC()
        let addSegmentedNC1 = UINavigationController(rootViewController: addSegmentedVC1)
        let imageAddSegmented1 =  UIImage(systemName: "recordingtape.circle")
        let selectedImageAddSegmented1 = UIImage(systemName: "recordingtape.circle")
        addSegmentedVC.tabBarItem = UITabBarItem(title: "VoiceMail", image: imageAddSegmented1, selectedImage: selectedImageAddSegmented1)
        */
        
       //MARK:  return [alertNC, buttonNC, textFieldNC,V6KeyPaddNC]
    }
    

}
