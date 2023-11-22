import Foundation
import Alamofire


class HomeViewModel{
    
    var populerPlace:[Place] = [] {
        didSet {
            self.transferPopulerData?()
        }
    }
    var lastPlace:[Place] = [] {
        didSet {
            self.transferLastData?()
        }
    }
    var userPlace:[Place] = [] {
        didSet {
            self.transferUserData?()
        }
    }
    
    var transferPopulerData: (()->())?
    var transferLastData: (()->())?
    var transferUserData: (()->())?
    
    
//MARK: Populer place
    
    func getPopulerPlaceParam(){
        let params = ["limit": "5"]
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placePopularGetParams(params: params), callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.populerPlace = response.places
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }
    
    func getPopulerPlace(){
       
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placePopularGet, callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.populerPlace = response.places
            
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
        
    }
    
    //MARK: last place
    func getLastParam(){
        let params = ["limit": "5"]
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placeLastGetParams(params: params), callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.lastPlace = response.places
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
        
    }
    
    func getLastPlace(){
       
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placeLastGet, callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.lastPlace = response.places
            
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }
    
    //MARK: user place
    func getUserPlace(){
       
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .placeAllUserGet, callback: { (result:Result<PlacesModelDatas,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.userPlace = response.places
            
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
        
    }
    
    
}
