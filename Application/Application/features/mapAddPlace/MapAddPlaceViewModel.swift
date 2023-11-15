//
//  MapAddPlaceViewModel.swift
//  Application
//
//  Created by Ada on 14.11.2023.
//

import Foundation


protocol MapAddPlaceDelegate{
    func mapAddPlaceGet(isLogin:Bool)
}
class MapAddPlaceViewModel {
    
    var delegate: MapAddPlaceDelegate?
    func setDelegate(output: MapAddPlaceDelegate) {
        delegate = output
    }
    func uploadImages() {
      //  uploadImage
    }
    
    
    
}
