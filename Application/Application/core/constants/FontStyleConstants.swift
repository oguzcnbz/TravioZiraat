import Foundation
import UIKit

enum FontStyle {
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case sh1
    case sh2
    case sh3
    case sh4
    case t1
    case t2
    case t3
    case lt1
    case lt2
    case lt3
    case lt4
   
    var font: UIFont? {
        switch self {
        case .h1:
            return UIFont(name: "Poppins-SemiBold", size: 36)
        case .h2:
            return UIFont(name: "Poppins-SemiBold", size: 32)
        case .h3:
            return UIFont(name: "Poppins-SemiBold", size: 30)
        case .h4:
            return UIFont(name: "Poppins-SemiBold", size: 24)
        case .h5:
            return UIFont(name: "Poppins-SemiBold", size: 16)
        case .h6:
            return UIFont(name: "Poppins-SemiBold", size: 14)
        case .sh1:
            return UIFont(name: "Poppins-Medium", size: 24)
        case .sh2:
            return UIFont(name: "Poppins-Medium", size: 20)
        case .sh3:
            return UIFont(name: "Poppins-Medium", size: 14)
        case .sh4:
            return UIFont(name: "Poppins-Medium", size: 12)
        case .t1:
            return UIFont(name: "Poppins-Regular", size: 14)
        case .t2:
            return UIFont(name: "Poppins-Regular", size: 12)
        case .t3:
            return UIFont(name: "Poppins-Regular", size: 10)
        case .lt1:
            return UIFont(name: "Poppins-Light", size: 16)
        case .lt2:
            return UIFont(name: "Poppins-Light", size: 14)
        case .lt3:
            return UIFont(name: "Poppins-Light", size: 12)
        case .lt4:
            return UIFont(name: "Poppins-Light", size: 10)
        }
    }
}
