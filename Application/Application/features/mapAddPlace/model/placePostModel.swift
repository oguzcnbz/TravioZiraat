//
//  placePostModel.swift
//  Application
//
//  Created by Ada on 14.11.2023.
//
import Foundation

// MARK: - PlacePostModel
struct PlacePostModel: Codable {
    var place, title, description: String
    var coverImageURL: String
    var latitude, longitude: Double
    
    
    
    enum CodingKeys: String, CodingKey {
        case place, title, description
        case coverImageURL = "cover_image_url"
        case latitude, longitude
    }
}


