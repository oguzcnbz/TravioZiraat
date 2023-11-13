
import Foundation
import Alamofire

enum Router {
    
    case userRegister(params:Parameters)
    case userLogin(params:Parameters)
    case placePopularGet
    case placePopularGetParams(params:Parameters)
    case placeLastGet
    case placeLastGetParams(params:Parameters)
    case placeDetailGetGalleryImages(placeId:String)
    case placeAllUserGet
    case placePost
    //case placeUser(
    
    
    
    
    var baseURL:String {
        return "https://ios-class-2f9672c5c549.herokuapp.com"
    }
    
    var path:String {
        switch self {
        case .userRegister(params: _):
            return "/v1/auth/register"
        case .userLogin:
            return "/v1/auth/login"
        case .placeLastGet,.placeLastGetParams:
            return "/v1/places/last"
        case .placePopularGet,.placePopularGetParams:
            return "/v1/places/popular"
        case .placeDetailGetGalleryImages(let placeId):
            return "/v1/galleries/\(placeId)"
        case .placeAllUserGet:
            return "/v1/places/user"
        case .placePost:
            return "/v1/places"
            
        }
    }
    
    
    var method:HTTPMethod {
        switch self {
        case .userLogin,.userRegister,.placePost:
            return .post
        case .placePopularGet,.placePopularGetParams,.placeLastGet,.placeLastGetParams,.placeDetailGetGalleryImages,.placeAllUserGet:
            return .get
            //        case .userDelete:
            //            return .delete
            //        case .userUpdate:
            //            return .put
        }
    }
    
    
    var headers:HTTPHeaders {
        switch self {
        case .userLogin, .placePopularGet,.userRegister,.placePopularGetParams,.placeDetailGetGalleryImages,.placeLastGet,.placeLastGetParams:
            return [:]
        case .placeAllUserGet,.placePost:
            guard let accessToken = KeychainHelper.shared.read(service: "user-key", account: "accessToken") else {return [:] }
            var accesTmp = String(data: accessToken, encoding: .utf8)
            guard let accesStr = accesTmp else {return [:]}
            return ["Authorization": "Bearer \(accesStr)"]

            
            
        }
    }
        var parameters:Parameters? {
            switch self {
            case .userLogin(let params),.userRegister(let params),.placePopularGetParams(params: let params),.placeLastGetParams(params: let params):
                return params
            case .placePopularGet,.placeLastGet,.placeDetailGetGalleryImages,.placeAllUserGet,.placePost:
                return nil
                //        case .userUpdate(userId: _, params: let params):
                //            return params
            }
            
            
            
        }
        
        
    }
    
    extension Router:URLRequestConvertible {
        
        func asURLRequest() throws -> URLRequest {
            let url = try baseURL.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            urlRequest.headers = headers
            
            let encoding:ParameterEncoding = {
                switch method {
                case .post,.put:
                    return JSONEncoding.default
                default:
                    return URLEncoding.default
                }
            }()
            
            return try encoding.encode(urlRequest, with: parameters)
        }
        
        
        
    }

