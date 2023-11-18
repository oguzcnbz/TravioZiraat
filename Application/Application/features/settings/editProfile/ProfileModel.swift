// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileModel = try? JSONDecoder().decode(ProfileModel.self, from: jsonData)

import Foundation

// MARK: - ProfileModel
struct ProfileModel: Codable {
    var fullName, email, role, ppURL: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email, role
        case ppURL = "pp_url"
        case createdAt = "created_at"
    }
}
