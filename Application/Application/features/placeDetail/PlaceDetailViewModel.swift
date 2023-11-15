
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
    func visitPost(placeId:String?,visitedAt:String?){
        
       let params = ["place_id": placeId, "visited_at": visitedAt]
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .visitPost(params: params), callback: { (result:Result<VisitResponse,Error>) in
            switch result {
            case .success(let obj):
                print("*********************** \(obj.message)")
            case .failure(let err):
                print(err.localizedDescription)
        
            }
        })
        
    }
    

    func visitDelete(placeId: String){
                
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .visitDelete(placeId: placeId), callback: { (result:Result<VisitResponse,Error>) in
            switch result {
            case .success(let obj):
                print((obj.message))
            case .failure(let err):
                print(err.localizedDescription)
        
            }
        })
        
    }
    
    var checkclosure: ((String)->Void)?
    
    func visitByPlaceIdCheck(placeId: String){
                
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .visitByPlaceIdCheck(placeId: placeId), callback: { (result:Result<VisitResponse,Error>) in
            switch result {
            case .success(let obj):
                print((obj.message))
                self.checkclosure?(obj.status)
            case .failure(let err):
                print(err.localizedDescription)
                self.checkclosure?("")
            }
        })
        
    }

}
