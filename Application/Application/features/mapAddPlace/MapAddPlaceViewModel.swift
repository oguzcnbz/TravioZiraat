//
//  MapAddPlaceViewModel.swift
//  Application
//
//  Created by Ada on 14.11.2023.
//

import Foundation
import UIKit

protocol MapAddPlaceDelegate{
    func mapAddPlaceGet(isLogin:Bool)
}
class MapAddPlaceViewModel {
    
    var delegate: MapAddPlaceDelegate?
    func setDelegate(output: MapAddPlaceDelegate) {
        delegate = output
    }
    
    func deneme(imageArray: [UIImage?]){
    
         
    }
    
    func uploadImages(imageArray: [UIImage?])-> [String] {
        var imgUrlArr:[String] = []
        
            
        
        
        let filterImg = imageArray.compactMap(({ $0 }))
        
        if filterImg.count > 0 {
            let networkHelper = NetworkingHelper()
           // networkHelper.uploadImage(image: filterImg.first, path: "String")
             
        
            var imgUrl:String = networkHelper.uploadImage(image: filterImg.first!, path: "/upload")
          
            if imgUrl != "" || imgUrl != nil {
                imgUrlArr.append(imgUrl)
            }
//            filterImg.forEach({imageL in
//                
//            })
            
         
            
        }
        return imgUrlArr
        
    }
    
    func placeCreate(model:PlaceCreateModel,imgUrl:String){
        
        
       // guard let title = model?.title else {return }
        let params = ["place": model.place, "title": model.title,"description":model.description,"cover_image_url":imgUrl,"latitude":model.latitude,"longitude":model.longitude] as [String : Any]
    }
 
    
    
    
}
