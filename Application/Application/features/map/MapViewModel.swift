
import UIKit
import Alamofire

class MapViewModel{

    var populerPlace:[Place] = [] {
        didSet {
            self.transferData?()
        }
    }
    
    var transferData: (()->())?
    
    func getPopulerPlace(){
       
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placePopularGet, callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                let sortedPlaces = response.places.sorted { $0.title < $1.title }
                self.populerPlace = sortedPlaces
                print(self.populerPlace.first?.coverImageURL)
                
            case .failure(let err):
                print(err.localizedDescription)
                print("boyle kod olmaz")
            }
        })
        
    }
  
}
