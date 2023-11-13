//
//  PlaceDetailViewModel.swift
//  Application
//
//  Created by Oğuz Canbaz on 7.11.2023.
//

import UIKit

protocol PlaceDetailResponseDelegate{
    func placeDetailResponseGet(imageArr:[String])
  //  func changeLoading()
}

class PlaceDetailViewModel {
    private var isLoading = false
    
    var delegate: PlaceDetailResponseDelegate?
    func setDelegat(output: PlaceDetailResponseDelegate){
        delegate = output
    }
    
    func getAllImages(placeId:String){
      //  changeLoading()
        var imagesUrl:[String] = []
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placeDetailGetGalleryImages(placeId: placeId)) {(result: Result<PlaceDetailImagesURLModel, Error>) in
            switch result {
            case .success(let obj):
                var  imagesArr = obj.data.images
                imagesArr.forEach({item in
                    imagesUrl.append(item.imageURL)
                    
                })
                print("images \(imagesUrl)")
           //     imagesArr.
                self.delegate?.placeDetailResponseGet(imageArr: imagesUrl)
            case .failure(let error):
                print(error.localizedDescription)
                
                
            }
        }
    }
    
    

    

}
