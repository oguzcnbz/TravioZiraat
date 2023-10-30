//
//  LoginViewModel.swift
//  Application
//
//  Created by Ada on 26.10.2023.
//

import Foundation

protocol LoginResponseDelegate{
    func loginResponseGet(isLogin:Bool)
}

class LoginViewModel {
 
    var delegate: LoginResponseDelegate?
    func setDelegate(output: LoginResponseDelegate) {
        delegate = output
    }
    
    func loginUser(email:String?,password:String?){


        let params = ["email": "johndoe@example1.com", "password": "secretpassword", ]
        var isLogin:Bool = false
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .userLogin(params: params), callback:{ (result:Result<UserModel,Error>) in
            switch result {
            case .success(let success):
               // print(success)
               let accessToken = success.accessToken
                let refreshToken = success.refreshToken
                isLogin = true
            case .failure(let failure):
            //    print(failure)
                isLogin = false
                
                        }
            self.delegate?.loginResponseGet(isLogin: isLogin)
            
            
        })
    }
    
}
