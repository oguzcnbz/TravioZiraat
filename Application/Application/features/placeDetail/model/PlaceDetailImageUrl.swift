import Foundation

struct PlaceDetailImagesURLModel: Codable {
    let data: PelaceDetailDataClass
    let status: String
}

struct PelaceDetailDataClass: Codable {
    let count: Int
    let images: [PlaceDetailImage]
}

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
