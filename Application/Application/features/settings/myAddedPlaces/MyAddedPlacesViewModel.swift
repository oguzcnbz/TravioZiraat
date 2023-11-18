
import UIKit
import Alamofire

class MyAddedPlacesViewModel{

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
                
            case .failure(let err):
                print(err.localizedDescription)
                print("boyle kod olmaz")
            }
        })
        
    }
  
}
