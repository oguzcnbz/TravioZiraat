

import UIKit

struct MyVisitsModel:Codable {
    let data: MyVisitsData
    let status: String
}

struct MyVisitsData:Codable {
    let count: Int
    let visits: [MyVisits]
}

struct MyVisits: Codable {
    let id: String
    let placeID: String
    let visitedAt: String
    let createdAt: String
    let updatedAt: String
    let place: Place

    enum CodingKeys: String, CodingKey {
        case id
        case placeID = "place_id"
        case visitedAt = "visited_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case place
    }
}




