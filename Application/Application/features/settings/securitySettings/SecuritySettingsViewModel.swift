import UIKit
import Alamofire

class SecuritySettingsViewModel{

    var showAlertClosure: (((String,String)) -> Void)?
    
    func passwordChange(changedPassword:String){
       
        let params = ["new_password": changedPassword]
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .passwordChangePut(params: params), callback: { (result:Result<Response,Error>) in
            switch result {
            case .success(_):
                self.showAlertClosure?((title:"Error",message:"Your password has been changed successfully."))
            case .failure(let error):
                self.showAlertClosure?((title:"Error",message:error.localizedDescription))

            }
        })
    }
}
