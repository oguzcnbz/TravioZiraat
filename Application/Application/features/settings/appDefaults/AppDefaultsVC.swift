//
//  
//  AppDefaultsVC.swift
//  Application
//
//  Created by Oğuz Canbaz on 9.11.2023.
//
//
import UIKit
import TinyConstraints

class AppDefaultsVC: UIViewController {
    
    //MARK: -- Properties
    
    
    //MARK: -- Views
    
    
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
        self.view.addSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        // Add here the setup for layout
       
    }
  
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AppDefaultsVC_Preview: PreviewProvider {
    static var previews: some View{
         
        AppDefaultsVC().showPreview()
    }
}
#endif
