
import Foundation
import Alamofire

enum Router {
    
    case userRegister(params:Parameters)
    case userLogin(params:Parameters)
    case placePopularGet
    case placePopularGetParams(params:Parameters)
    var baseURL:String {
        return "https://ios-class-2f9672c5c549.herokuapp.com"
    }
    
    var path:String {
        switch self {
        case .userRegister(params: let params):
            return "/v1/auth/register"
        case .userLogin:
            return "/v1/auth/login"
        case .placePopularGet,.placePopularGetParams:
            return "/v1/places/popular"
      
        }
    }
    
    
    var method:HTTPMethod {
        switch self {
        case .userLogin,.userRegister:
            return .post
        case .placePopularGet,.placePopularGetParams:
            return .get
//        case .userDelete:
//            return .delete
//        case .userUpdate:
//            return .put
        }
    }
    
    
    var headers:HTTPHeaders {
        switch self {
        case .userLogin, .placePopularGet,.userRegister,.placePopularGetParams:
            return [:]
        }
    }
    
    var parameters:Parameters? {
        switch self {
        case .userLogin(let params),.userRegister(let params),.placePopularGetParams(params: let params):
            return params
        case .placePopularGet:
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
