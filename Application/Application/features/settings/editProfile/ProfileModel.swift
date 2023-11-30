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
