import Foundation
import UIKit


class EditProfileViewModel {
    
    var profilModel: ProfileModel = ProfileModel(fullName: nil, email: nil, role: nil, ppURL: nil, createdAt: nil) {
        didSet {
            self.transferProfilData?()
        }
    }
    var showAlertClosure: (((String,String)) -> Void)?
    var transferProfilData: (() -> ())?
        
    func getProfilData(){ 
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .profileGet, callback: { (result:Result<ProfileModel,Error>) in
            switch result {
            case .success(let success):
                var obj = success
                var strDate = ""
                let dateHelper:DateHelper = DateHelper()
                if let date = dateHelper.convertStringToDate(obj.createdAt ?? "") {
                    
                    strDate = dateHelper.convertDateToString(date)
                }
            
                obj.createdAt = strDate
                self.profilModel = obj

            case .failure(let error):
                self.showAlertClosure?((title:"Error",message:error.localizedDescription))
            }
        })
    }
    

    func profileUploadImage (profileImg: UIImage,full_name:String,email:String,pp_url:String,isDone: @escaping (Bool) -> Void) {
        let imglArr:[UIImage] = [profileImg]

        NetworkingHelper.shared.uplodImageFromRemote(urlRequest: .uploadImage(images: imglArr)) { (result:Result<UploadImageResponse,Error>)in
            switch result {
            case .success(let success):
                if let imageUrls = success.urls {
                    self.changeProfile(full_name: full_name, email: email, pp_url:imageUrls.first ?? "", isDone: isDone)
                }

            
            case .failure(let error):
                self.showAlertClosure?((title:"Error",message:error.localizedDescription))
            }
            
        }
        
        
        
    }
    
    func changeProfile(full_name:String,email:String,pp_url:String,isDone: @escaping (Bool) -> Void){
        
        
        let params: [String: Any] = ["full_name": full_name,
                                     "email": email,
                                     "pp_url": pp_url]
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .profileUpdate(params: params), callback: {
            (result:Result<ResponseMessageModel,Error>) in
            switch result {
            case .success(_):
                self.showAlertClosure?((title:"Message",message:"Your changes have been saved successfully."))
                isDone(true)
                
            case .failure(let error):
                self.showAlertClosure?((title:"Error",message:error.localizedDescription))

            }
        })
    }
}
