
import Foundation
import Alamofire

enum Router {
    
    case userRegister(params:Parameters)
    case userLogin(params:Parameters)
    case placeAllGet
    case placePopularGet
    case placePopularGetParams(params:Parameters)
    case placeLastGet
    case placeLastGetParams(params:Parameters)
    case placeDetailGetGalleryImages(placeId:String)
    case placeAllUserGet
    case placePost(params:Parameters)
    case visitsGet
    case visitPost(params:Parameters)
    case visitDelete(placeId:String)
    case visitByPlaceIdCheck(placeId:String)
    case myAddedPlacesGet
   // case uploadImage(image: UIImage)
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
        case .placeAllGet,.placePost:
            return "/v1/places"
        case .visitsGet,.visitPost:
            return "/v1/visits"
        case .visitDelete(let placeId):
            return "/v1/visits/\(placeId)"
        case.visitByPlaceIdCheck(let placeId):
            return "/v1/visits/user/\(placeId)"
        case .myAddedPlacesGet:
            return "/v1/places/user"
        }
    }
    
    
    var method:HTTPMethod {
        switch self {
        case .userLogin,.userRegister,.placePost,.visitPost:
            return .post
        case .placeAllGet,.placePopularGet,.placePopularGetParams,.placeLastGet,.placeLastGetParams,.placeDetailGetGalleryImages,.placeAllUserGet,.visitsGet,.visitByPlaceIdCheck,.myAddedPlacesGet:
            return .get
        case .visitDelete:
            return .delete
            //        case .userUpdate:
            //            return .put
        }
    }
    
    
    var headers:HTTPHeaders {
        switch self {
        case .userLogin,.placeAllGet ,.placePopularGet,.userRegister,.placePopularGetParams,.placeDetailGetGalleryImages,.placeLastGet,.placeLastGetParams,.myAddedPlacesGet:
            return [:]
        case .placeAllUserGet,.placePost,.visitPost,.visitsGet,.visitDelete,.visitByPlaceIdCheck:
            guard let accessToken = KeychainHelper.shared.read(service: "user-key", account: "accessToken") else {return [:] }
            var accesTmp = String(data: accessToken, encoding: .utf8)
            guard let accesStr = accesTmp else {return [:]}
            return ["Authorization": "Bearer \(accesStr)"]
        }
    }
    
        var parameters:Parameters? {
            switch self {
            case .userLogin(let params),.userRegister(let params),.placePopularGetParams(params: let params),.placeLastGetParams(params: let params),.visitPost(params: let params),.placePost(params: let params):
                return params
            case .placeAllGet,.placePopularGet,.placeLastGet,.placeDetailGetGalleryImages,.placeAllUserGet,.visitsGet,.visitDelete,.visitByPlaceIdCheck,.myAddedPlacesGet:
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
                case .post,.put,.delete:
                    return JSONEncoding.default
                default:
                    return URLEncoding.default
                }
            }()
            
            return try encoding.encode(urlRequest, with: parameters)
        }
        
        
        
    }

