//
//  ColorConstants.swift
//  bilge3-1
//
//  Created by Ada on 2.11.2023.
//

import Foundation
import UIKit



//public let kcPrimaryColor = UIColor(hex: "38ada9")
//public let kcBackgroundColor = UIColor(hex: "F8F8F8")
//public let kcBlackRavenColor = UIColor(hex: "3d3d3d")
//public let kcBlueRaspberryColor = UIColor(hex: "17C0EB")


enum ColorStyle {
   case primary
    case background
   case blackRaven
  case blueRaspberry
  case white
  case greySpanish
    
    var color: UIColor? {
        switch self {
        case .primary:
            return UIColor(hex: "38ada9")
        case .background:
            return UIColor(hex: "F8F8F8")
        case .blackRaven:
            return UIColor(hex: "3d3d3d")
        case .blueRaspberry:
            return UIColor(hex: "17C0EB")
        case .greySpanish:
            return UIColor(hex: "999999")
        case .white:
            return .white
 
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        let alpha = CGFloat(1.0)

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}






