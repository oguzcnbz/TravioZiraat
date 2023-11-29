import UIKit
import Alamofire


class MapViewModel{

    var allPlace:[Place] = [] {
        didSet {
            self.transferData?()
        }
    }
    
    var transferData: (()->())?
    
    func getAllPlace(){
       
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placeAllGet, callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.allPlace =  response.places
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }
}
