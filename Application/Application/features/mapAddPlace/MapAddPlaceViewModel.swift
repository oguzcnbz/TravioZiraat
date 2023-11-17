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
    
   
    
    func addPlace(imageArray: [UIImage?],model:PlacePostModel) {
        var imgUrlArr:[String] = []
        
            
        
    
        let filterImg = imageArray.compactMap(({ $0 }))
        
        if filterImg.count > 0 {
            let networkHelper = NetworkingHelper()
            networkHelper.uploadImages(images: filterImg, path: "/upload") { result in
                if let imageUrls = result {
                    print("Images uploaded successfully. URLs: \(imageUrls)")
                 //   var modeltmp = model
                   // modeltmp.coverImageURL = imageUrls.first
                    self.placeCreate(model: model, imgUrl: imageUrls.first!) { placeId in
                        imageUrls.forEach(
                            {
                            imgUrl in
                                self.galleryImageUrlAdd(placeId: placeId, imgUrl: imgUrl)
                            
                        }
                        )
                        
                         }
                } else {
                    print("Image upload failed.")
                }
            }

            
         
            
        }
       
        
    }
    
    func placeCreate(model:PlacePostModel,imgUrl:String, callback: @escaping (String) -> Void){
        
        
     
        let params = [
            "place": model.place ?? "",
            "title": model.title ?? "",
            "description": model.description ?? "",
            "cover_image_url": imgUrl,
            "latitude": model.latitude,
            "longitude": model.longitude
        ] as [String: Any]
        
        print(params)
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placePost(params: params)) {  (result:Result<PlacePostResponseModel,Error>) in
           
            switch result {
            case .success(let success):
                print(success.message)
                callback(success.message)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
        
        
        
    }
    
    func galleryImageUrlAdd(placeId:String ,imgUrl:String ) {
        
        let params = [
            "place_id": placeId,
            "image_url": imgUrl,
            
        ] as [String: String]
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .galerysImagesPost(params: params)) { (result:Result<PlacePostResponseModel,Error>) in
            switch result {
            case .success(let success):
                print(success.message)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
 
    
    
    
}
