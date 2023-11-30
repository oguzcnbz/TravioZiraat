import UIKit

protocol PlaceDetailResponseDelegate{
    func placeDetailResponseGet(imageArr:[String])
}

class PlaceDetailViewModel {
    private var isLoading = false
    var showAlertClosure: (((String,String)) -> Void)?
    var delegate: PlaceDetailResponseDelegate?
    func setDelegat(output: PlaceDetailResponseDelegate){
        delegate = output
    }
    
    func getAllImages(placeId:String){
        var imagesUrl:[String] = []
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placeDetailGetGalleryImages(placeId: placeId)) {(result: Result<PlaceDetailImagesURLModel, Error>) in
            switch result {
            case .success(let obj):
                let  imagesArr = obj.data.images
                imagesArr.forEach({item in
                    imagesUrl.append(item.imageURL)
                })
                self.delegate?.placeDetailResponseGet(imageArr: imagesUrl)
            case .failure(let error):
                self.showAlertClosure?((title:"Error",message:error.localizedDescription))
            }
        }
    }
    func visitPost(placeId:String?,visitedAt:String?){
        
        let params = ["place_id": placeId, "visited_at": visitedAt]
        
        let parameters: [String: Any] = params.compactMapValues { $0 }
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .visitPost(params: parameters), callback: { (result:Result<Response,Error>) in
            switch result {
            case .success(_):
                self.showAlertClosure?((title:"Message",message:"Saved successfully."))
            case .failure(let error):
                self.showAlertClosure?((title:"Error",message:error.localizedDescription))
            }
        })
    }
    
    func visitDelete(placeId: String){
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .visitDelete(placeId: placeId), callback: { (result:Result<Response,Error>) in
            switch result {
            case .success(let obj):
                self.showAlertClosure?((title:"Message",message:"Successfully removed from the list."))
            case .failure(let error):
                self.showAlertClosure?((title:"Error",message:error.localizedDescription))            }
        })
        
    }
    
    var checkclosure: ((String)->Void)?
    
    func visitByPlaceIdCheck(placeId: String){
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .visitByPlaceIdCheck(placeId: placeId), callback: { (result:Result<Response,Error>) in
            switch result {
            case .success(let obj):
                self.checkclosure?(obj.status)
            case .failure(let err):
                self.checkclosure?("")
            }
        })
        
    }
    
}
