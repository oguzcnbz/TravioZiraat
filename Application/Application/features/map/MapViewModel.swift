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
                let sortedPlaces = response.places.sorted { $0.title < $1.title }
                self.allPlace = sortedPlaces
                print(self.allPlace.first?.coverImageURL)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }
}
