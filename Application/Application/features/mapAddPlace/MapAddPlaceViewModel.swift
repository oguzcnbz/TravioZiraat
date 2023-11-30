import Foundation
import UIKit

class MapAddPlaceViewModel {
    private var isLoading = false
    var showAlertClosure: (((String,String)) -> Void)?
    
    func addPlace(imageArray: [UIImage?],model:PlacePostModel,hasUploded: @escaping () -> Void) {
        if isLoading == false {
            changeLoading()
        
            let filterImg = imageArray.compactMap(({ $0 }))
            
            if filterImg.count > 0 {

                NetworkingHelper.shared.uplodImageFromRemote(urlRequest: .uploadImage(images: filterImg)) { (result:Result<UploadImageResponse,Error>)in
                    switch result {
                    case .success(let success):
                        if let imageUrls = success.urls {
                            self.placeCreate(model: model, imgUrl: imageUrls.first!) { placeId in
                                imageUrls.forEach({
                                    imgUrl in
                                        self.galleryImageUrlAdd(placeId: placeId, imgUrl: imgUrl)
                                    
                                }
                                )
                                hasUploded()
                                
                                 }
                        }
                        self.showAlertClosure?((title:"Message",message:"Place saved successfully."))
                    case .failure(let error):
                        self.showAlertClosure?((title:"Error",message:error.localizedDescription))
                    }
                    
                }
            }
            changeLoading()
        }
        
    }
    
    func placeCreate(model:PlacePostModel,imgUrl:String, callback: @escaping (String) -> Void){
        
        let params = ["place": model.place,
                      "title": model.title,
                      "description": model.description,
                      "cover_image_url": imgUrl,
                      "latitude": model.latitude,
                      "longitude": model.longitude] as [String: Any]
        
        if isLoading == false {
            NetworkingHelper.shared.getDataFromRemote(urlRequest: .placePost(params: params)) {  (result:Result<ResponseMessageModel,Error>) in
               
                switch result {
                case .success(let success):
                    callback(success.message)
                case .failure(let error):
                    self.showAlertClosure?((title:"Error",message:error.localizedDescription))
                }
            }
        }
    }
    
    func galleryImageUrlAdd(placeId:String ,imgUrl:String ) {
        
        let params = ["place_id": placeId,
                      "image_url": imgUrl] as [String: String]
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .galerysImagesPost(params: params)) { (result:Result<ResponseMessageModel,Error>) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self.showAlertClosure?((title:"Error",message:error.localizedDescription))
            }
        }
    }   
    
    func changeLoading() {
        isLoading = !isLoading
    }
}
