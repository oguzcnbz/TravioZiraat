
import UIKit
import Alamofire

class SecuritySettingsViewModel{

    func passwordChange(changedPassword:String){
       
        let params = ["new_password": changedPassword]
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .passwordChangePut(params: params), callback: { (result:Result<Response,Error>) in
            switch result {
            case .success(let obj):
                print(obj.message)
            case .failure(let err):
                print(err.localizedDescription)
        
            }
        })
        
    }
  
}
