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
   
    func uploadImages(images: [UIImage], path: String, completion: @escaping ([String]?) -> Void) {
        let baseUrl = "https://ios-class-2f9672c5c549.herokuapp.com"
        let url = baseUrl + path

        AF.upload(multipartFormData: { multipartFormData in
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    let fileName = "image_\(index).jpg"
                    multipartFormData.append(imageData, withName: "file", fileName: fileName, mimeType: "image/jpeg")
                }
            }
            // Add other parameters if needed
      //      multipartFormData.append("YourOtherParameter".data(using: .utf8)!, withName: "otherParameter")
        }, to: url)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
               // print("Upload success: \(value)")
                
                if let json = value as? [String: Any],
                   let messageType = json["messageType"] as? String,
                   let message = json["message"] as? String,
                   let urls = json["urls"] as? [String] {
//                    print("MessageType: \(messageType)")
//                    print("Message: \(message)")
//                    print("Uploaded URLs: \(urls)")
                    completion(urls)
                } else {
                    completion(nil)
                }

            case .failure(let error):
                print("Upload failed: \(error)")
                completion(nil)
            }
        }
    }

}

