//
//  PlaceDetailImageUrl.swift
//  Application
//
//  Created by Ada on 12.11.2023.
//

import Foundation


struct PlaceDetailImagesURLModel: Codable {
    let data: PelaceDetailDataClass
    let status: String
}

// MARK: - DataClass
struct PelaceDetailDataClass: Codable {
    let count: Int
    let images: [PlaceDetailImage]
}

// MARK: - Image
struct PlaceDetailImage: Codable {
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
