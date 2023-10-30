//
//  UserModel.swift
//  Application
//
//  Created by Ada on 26.10.2023.
//

import UIKit

struct UserModel:Codable {
    var full_name:String?
    var email:String?
    var password:String?
    var accessToken:String?
    var refreshToken:String?
    var errMessage:String?
}


