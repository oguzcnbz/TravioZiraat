import Foundation
import UIKit


protocol SignUpResponseDelegate{
    func signUpResponseGet(isSignUp:Bool,message:String)
}

class SignUpViewModel {
    private var isLoading = false
    var delegate: SignUpResponseDelegate?
    func setDelegate(output: SignUpResponseDelegate) {
        delegate = output
    }
    
    
    
    func signUpUser(fullName: String?, email: String?, password: String?) {
        if isLoading == false { 
            changeLoading()
            
            
            guard let fullName = fullName, let email = email, let password = password else {
                delegate?.signUpResponseGet(isSignUp: false, message: "Invalid input data")
                return
            }
            
            let params = ["full_name": fullName, "email": email, "password": password]
            
            NetworkingHelper.shared.getDataFromRemote(urlRequest: .userRegister(params: params)) { (result: Result<ResponseMessageModel, Error>) in
                self.changeLoading()
                switch result {
                    
                case .success(let success):
                    let status = success.status
                    let isSuccess = (status == "success")
                    
                    lazy var loginViewModel: LoginViewModel = LoginViewModel()
                    self.delegate?.signUpResponseGet(isSignUp: isSuccess, message: success.message)
                    loginViewModel.loginUser(email: email, password: password)
                    
                    
                case .failure(let error):
                    
                    var errMessage = error.localizedDescription
                    switch error.localizedDescription{
                    case "Response status code was unacceptable: 500.":
                        errMessage = "User with that email already exists"
                    case "Response status code was unacceptable: 400.":
                        errMessage = error.localizedDescription
                    default:
                        errMessage = ""
                        
                        self.delegate?.signUpResponseGet(isSignUp: false, message: errMessage)
                    }
                }
                
                
            }
        }
    }
    func changeLoading() {
        isLoading = !isLoading
    }
    
}
