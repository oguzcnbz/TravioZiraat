//
//  PlaceDetailModel.swift
//  Application
//
//  Created by Ada on 12.11.2023.
//

import Foundation

// MARK: - PlaceDeatilImagesURLModel
struct PlaceDeatilImagesURLModel: Codable {
    let data: DataClassPlaceDetail
    let status: String
}

// MARK: - DataClass
struct DataClassPlaceDetail: Codable {
    let count: Int
    let images: [Image]
}

// MARK: - Image
struct Image: Codable {
    let id, placeID: String
    let imageURL: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case placeID = "place_id"
        case imageURL = "image_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

