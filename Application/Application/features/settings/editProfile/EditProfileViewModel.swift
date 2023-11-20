import Foundation
import UIKit


class EditProfileViewModel {
    
    var profilModel: ProfileModel = ProfileModel(fullName: nil, email: nil, role: nil, ppURL: nil, createdAt: nil) {
        didSet {
            self.transferProfilData?()
        }
    }
    
    var transferProfilData: (() -> ())?
        
    func getProfilData(){ 
        
        NetworkingHelper.shared.getDataFromRemote(urlRequest: .profileGet, callback: { (result:Result<ProfileModel,Error>) in
            switch result {
            case .success(let success):
                var obj = success
                var strDate = ""
                var dateHelper:DateHelper = DateHelper()
                if let date = dateHelper.convertStringToDate(obj.createdAt ?? "") {
                    
                    strDate = dateHelper.convertDateToString(date)
                }
            
                obj.createdAt = strDate
                self.profilModel = obj
                                
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    func profileUploadImage (profileImg: UIImage,full_name:String,email:String,pp_url:String,isDone: @escaping (Bool) -> Void) {
        var imglArr:[UIImage] = [profileImg]
            let networkHelper = NetworkingHelper()
            networkHelper.uploadImages(images: imglArr, path: "/upload") { result in
                
                if let imageUrls = result {
                    print("Images uploaded successfully. URLs: \(imageUrls)")
                    self.changeProfile(full_name: full_name, email: email, pp_url:imageUrls.first ?? "", isDone: isDone)

                }else {
                    print("Image upload failed.")
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
            case .success(let obj):
                print(obj)
                isDone(true)
            case .failure(let failure):
                print(failure)
                
            }
        })
    }
}
