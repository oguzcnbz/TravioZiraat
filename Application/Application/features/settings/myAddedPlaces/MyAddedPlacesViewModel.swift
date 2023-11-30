import UIKit
import Alamofire

class MyAddedPlacesViewModel{
    
    var showAlertClosure: (((String,String)) -> Void)?
    var myaddedplaces:[Place] = [] {
        didSet {
            self.transferData?()
        }
    }
    
    var transferData: (()->())?
    
    func myAddedPlacesGet(){
       
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placeAllUserGet, callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.myaddedplaces = response.places
                
            case .failure(let error):
                self.showAlertClosure?((title:"Error",message:error.localizedDescription))
            }
        })
    }
}
