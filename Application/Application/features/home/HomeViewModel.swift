


import Foundation
import Alamofire

class HomeViewModel{
    
    var populerPlace:[Place] = [] {
        didSet {
            self.transferData?()
        }
    }
    
    var transferData: (()->())?
    
    
    //    func postData(name:String?,email:String?,phoneNumber:String?,note:String?){
    //
    //
    //        let params = ["name": name, "phoneNumber": phoneNumber, "note": note, "email": email]
    //
    //        NetworkingHelper.shared.getDataFromRemote(urlRequest: .register(params: params), callback:{ (result:Result<User,Error>) in
    //            print(result)
    //        })
    //    }
    
    func getPopulerPlaceParam(){
        let params = ["limit": "5"]
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placePopularGetParams(params: params), callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.populerPlace = response.places
                print(self.populerPlace.first?.coverImageURL)
                
            case .failure(let err):
                print(err.localizedDescription)
                print("boyle kod olmaz")
            }
        })
        
    }
    func getPopulerPlace(){
       
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placePopularGet, callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.populerPlace = response.places
                print(self.populerPlace.first?.coverImageURL)
                
            case .failure(let err):
                print(err.localizedDescription)
                print("boyle kod olmaz")
            }
        })
        
    }
    
}
