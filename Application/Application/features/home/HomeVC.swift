//
//  
//  HomeVCVC.swift
//  Application
//
//  Created by Ada on 26.10.2023.
//
//
import UIKit
import TinyConstraints

class HomeVC: UIViewController {
    
    //MARK: -- Properties
    
    
    //MARK: -- Views
    
    private lazy var containerView:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(named: "background")
        v.clipsToBounds = true
        v.layer.cornerRadius = 65
        v.layer.maskedCorners = [.layerMinXMinYCorner] // Top right corner, Top left corner respectively Top right corner, Top left corner respectively
        return v
    }()
    private lazy var logoImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "homeLogo")
        return iv
        
        
    }()
    

    
    
    //MARK: -- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupViews()
       
    }
    
    //MARK: -- Component Actions
    
    
    //MARK: -- Private Methods
    
    
    //MARK: -- UI Methods
    func setupViews() {
        // Add here the setup for the UI
        self.view.backgroundColor = UIColor(named: "primary")
        self.view.addSubview(logoImageView)
        self.view.addSubview(containerView)
        
        self.view.addSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        // Add here the setup for layout
        logoImageView.topToSuperview(offset: 30)
        //logoImageView.horizontalToSuperview(.left(20))
        //logoImageView.centerXToSuperview()
       // logoImageView.topToSuperview(offset: 5,usingSafeArea: true)
        
       // logoImageView.height(50)
        
        
        containerView.edgesToSuperview(excluding: .top)
        containerView.heightToSuperview(multiplier: 0.85)
      
       
    }
  
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeVCVC_Preview: PreviewProvider {
    static var previews: some View{
         
        HomeVC().showPreview()
    }
}
#endif
