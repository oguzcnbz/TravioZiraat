
import Foundation
import UIKit

protocol LoginResponseDelegate{
    func loginResponseGet(isLogin:Bool)
}

class LoginViewModel {
 
    var delegate: LoginResponseDelegate?
    func setDelegate(output: LoginResponseDelegate) {
        delegate = output
    }
    
    func loginUser(email:String?,password:String?){
       
        guard let email = email else {return}
        guard let password = password else {return}

        let params = ["email": email, "password": password]
        var isLogin:Bool = false
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .userLogin(params: params), callback:{ (result:Result<UserModel,Error>) in
            
            switch result {
            case .success(let success):
              
                let accessToken = success.accessToken
                let refreshToken = success.refreshToken
                isLogin = true
                
            case .failure(let failure):
                    
                isLogin = false
                
            }
            self.delegate?.loginResponseGet(isLogin: isLogin)
        })
    }
    
    
}
