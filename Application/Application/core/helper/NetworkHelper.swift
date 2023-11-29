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
            }
        }
        
        
        
    }
    public func uplodImageFromRemote<T:Codable>(urlRequest:Router, callback:@escaping Callback<T>) {
        
        
        AF.upload(multipartFormData: urlRequest.multipartFormData, with: urlRequest).validate().responseDecodable(of:T.self) { response in
            switch response.result {
            case .success(let success):
                callback(.success(success))
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
}

