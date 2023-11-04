import Foundation
import UIKit

struct PlacesModel {
    var image:UIImage?
    var name:String?
    var place:String?
}



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let placesModel = try? JSONDecoder().decode(PlacesModel.self, from: jsonData)

import Foundation

// MARK: - PlacesModel
struct PlacesModelDatas: Codable {
    let data: DataClass
    let status: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let count: Int
    let places: [Place]
}

// MARK: - Place
struct Place: Codable {
    let id, creator, place, title: String
    let description: String
    let coverImageURL: String
    let latitude, longitude: Double
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, creator, place, title, description
        case coverImageURL = "cover_image_url"
        case latitude, longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
 
 
}
struct User {
    var image:UIImage?
    var name:String?
}


struct Settings{
    var icon:UIImage?
    var settingName:String
    
}
