//
//  NetworkHelper.swift
//  Application
//
//  Created by Ada on 26.10.2023.
//


import Foundation
import Alamofire
import UIKit


class NetworkingHelper {
    
    static let shared = NetworkingHelper()
    
    typealias Callback<T:Codable> = (Result<T,Error>)->Void
    
    public func getDataFromRemote<T:Codable>(urlRequest:Router, callback:@escaping Callback<T>) {
        
        
        AF.request(urlRequest).validate().responseDecodable(of:T.self) { response in
            switch response.result {
            case .success(let success):
                callback(.success(success))
            case .failure(let failure):
                callback(.failure(failure))
                print(failure)
            }
        }
        
        
        
    }
    
    // Function to upload an image using Alamofire
    func uploadImage(image: UIImage,path:String) {
        var baseUrl = "https://ios-class-2f9672c5c549.herokuapp.com"
       var path = path
        
        let url = baseUrl+path

        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/*")
            }
            // Add other parameters if needed
            multipartFormData.append("YourOtherParameter".data(using: .utf8)!, withName: "otherParameter")
        }, to: url)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Upload success: \(value)")
                // Handle the success response
                
                if let json = value as? [String: Any],
                             let messageType = json["messageType"] as? String,
                             let message = json["message"] as? String,
                             let urls = json["urls"] as? [String] {
                              print("MessageType: \(messageType)")
                              print("Message: \(message)")
                    print("Uploaded URLs: \(urls.first)")
                          }
            case .failure(let error):
                print("Upload failed: \(error)")
                // Handle the error
            }
        }
    }
    
//    func uploadImage(imgType:String,imgData:Data,imageName:String){
//       // params to send additional data, for eg. AccessToken or userUserId
//       let params = ["userID":"userId","accessToken":"your accessToken"]
//       print(params)
//       AF.upload(multipartFormData: { multiPart in
//           for (key,keyValue) in params{
//               if let keyData = keyValue.data(using: .utf8){
//                   multiPart.append(keyData, withName: key)
//               }
//           }
//           
//           multiPart.append(imgData, withName: "key",fileName: imageName,mimeType: "image/*")
//       }, to: "Your URL",headers: []).responseJSON { apiResponse in
//           
//           switch apiResponse.result{
//           case .success(_):
//               let apiDictionary = apiResponse.value as? [String:Any]
//               print("apiResponse --- \(apiDictionary)")
//           case .failure(_):
//               print("got an error")
//           }
//       }
//   }

    
}

