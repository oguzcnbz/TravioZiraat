import Foundation
import UIKit


protocol LoginResponseDelegate{
    func loginResponseGet(isLogin:Bool)
    
}

class LoginViewModel {
    private var isLoading = false
 
    var delegate: LoginResponseDelegate?
    func setDelegate(output: LoginResponseDelegate) {
        delegate = output
    }
    
    func loginUser(email:String?,password:String?){
        if isLoading == false
        {
            changeLoading()
            guard let email = email else {return}
            guard let password = password else {return}

               
            let params = ["email": email, "password": password]
            var isLogin:Bool = false
            
            
            NetworkingHelper.shared.getDataFromRemote(urlRequest: .userLogin(params: params), callback:{ (result:Result<UserModel,Error>) in
                
                switch result {
                case .success(let success):
                  
                   let accessTokenOp = success.accessToken
                    let refreshTokenOp = success.refreshToken
                   
                    if let accessToken = accessTokenOp {
                          let data = Data(accessToken.utf8)
                          KeychainHelper.shared.save(data, service: "user-key", account: "accessToken")
                    }
                    if let refreshToken = refreshTokenOp {
                          let data = Data(refreshToken.utf8)
                          KeychainHelper.shared.save(data, service: "user-key", account: "refreshToken")
                    }
                 
                    isLogin = true
                   
                case .failure( _):
                        
                    isLogin = false
                    
                }
                self.changeLoading()
                self.delegate?.loginResponseGet(isLogin: isLogin)
            })
        }
       
    }    
    
    func changeLoading() {
        isLoading = !isLoading
        if isLoading == true {
          
        }
    }
}

