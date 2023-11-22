import UIKit
import Alamofire

class MyVisitsViewModel{

    var visitPlaces:[MyVisits] = [] {
        didSet {
            self.transferData?()
        }
    }
    
    var transferData: (()->())?

    func visitsGet(){
       
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .visitsGet, callback: { (result:Result<MyVisitsModel,Error>) in
            switch result {
            case .success(let obj):
                let response = obj.data
                self.visitPlaces = response.visits
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }
}
