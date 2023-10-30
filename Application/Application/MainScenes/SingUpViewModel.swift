//
//  LoginViewModel.swift
//  Application
//
//  Created by Ada on 26.10.2023.
//

import Foundation

protocol SignupResponseDelegate{
    func SignupResponseGet(isLogin:Bool, message:String)
}

class SignupViewModel {
 
    var delegate: SignupResponseDelegate?
    func setDelegate(output: SignupResponseDelegate) {
        delegate = output
    }
    
    func SignUser(email:String?,password:String?){


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
            failure.localizedDescription
                
                        }
            self.delegate?.SignupResponseGet(isLogin: isLogin, message: "")
            
            
        })
    }
    
}

