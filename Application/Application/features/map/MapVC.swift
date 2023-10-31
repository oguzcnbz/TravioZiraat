//
//  
//  MapVC.swift
//  Application
//
//  Created by Ada on 27.10.2023.
//
//
import UIKit
import TinyConstraints

class MapVC: UIViewController {
    
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
struct MapVC_Preview: PreviewProvider {
    static var previews: some View{
         
        MapVC().showPreview()
    }
}
#endif
