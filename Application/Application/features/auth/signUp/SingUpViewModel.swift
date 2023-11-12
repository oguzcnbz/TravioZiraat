
import Foundation
import UIKit

protocol SignUpResponseDelegate{
    func signUpResponseGet(isSignUp:Bool,message:String)
}


class SignUpViewModel {

    var delegate: SignUpResponseDelegate?
    func setDelegate(output: SignUpResponseDelegate) {
        delegate = output
    }
    
   
    

    func signUpUser(fullName: String?, email: String?, password: String?) {
        guard let fullName = fullName, let email = email, let password = password else {
            delegate?.signUpResponseGet(isSignUp: false, message: "Invalid input data")
            return
        }

        let params = ["full_name": fullName, "email": email, "password": password]

        NetworkingHelper.shared.getDataFromRemote(urlRequest: .userRegister(params: params)) { (result: Result<UserModel, Error>) in
            switch result {
            case .success(let success):
                guard let message = success.message else {return}
                let status = success.status
                let isSuccess = (status == "success")
                
             
                lazy var loginViewModel: LoginViewModel = LoginViewModel()
               
                
                
                self.delegate?.signUpResponseGet(isSignUp: isSuccess, message: message)
                loginViewModel.loginUser(email: email, password: password)

            case .failure(let error):
                print(error.localizedDescription)
                print(error)

                var errMessage = ""
                switch error.localizedDescription{
                case "Response status code was unacceptable: 500.":
                    errMessage = "User with that email already exists"
                case "Response status code was unacceptable: 400.":
                    errMessage = "Password must be more than 6 characters"
                default:
                    errMessage
                }
                
                self.delegate?.signUpResponseGet(isSignUp: false, message: errMessage)
            }
        }
    }


}
