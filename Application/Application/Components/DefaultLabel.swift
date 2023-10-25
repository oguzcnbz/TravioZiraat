import UIKit
import SnapKit
import TinyConstraints

enum FontStyle {
    case avengerBold(size: CGFloat)
    case avengerMedium(size: CGFloat)
    case helveticaMedium(size: CGFloat)
    case helveticaBold(size: CGFloat)
    case timesRomanRegular(size: CGFloat)
    case timesRomanItalic(size: CGFloat)
    case timesRomanBold(size: CGFloat)
    case timesRomanBoldItalic(size: CGFloat)
    case poppinsLight(size: CGFloat)
    case poppinsMedium(size: CGFloat)
    case poppinsSemiBold(size: CGFloat)
    
    var font: UIFont? {
        switch self {
        case .avengerBold(let size):
            return UIFont(name: "Avenir-Heavy", size: size)
        case .avengerMedium(let size):
            return UIFont(name: "Avenir-Medium", size: size)
        case .helveticaMedium(let size):
            return UIFont(name: "Helvetica", size: size)
        case .helveticaBold(let size):
            return UIFont(name: "Helvetica Bold", size: size)
        case .timesRomanRegular(let size):
            return UIFont(name: "Times New Roman", size: size)
        case .timesRomanItalic(let size):
            return UIFont(name: "Times New Roman Italic", size: size)
        case .timesRomanBold(let size):
            return UIFont(name: "Times New Roman Bold", size: size)
        case .timesRomanBoldItalic(let size):
            return UIFont(name: "Times New Roman Bold Italic", size: size)
        case .poppinsLight(let size):
            return UIFont(name: "Poppins-Light", size: size)
        case .poppinsMedium(let size):
            return UIFont(name: "Poppins-Medium", size: size)
        case .poppinsSemiBold(let size):
            return UIFont(name: "Poppins-SemiBold", size: size)
        }
    }
}

class DefaultLabel: UILabel {
    init(text: String, fontStyle: FontStyle = .poppinsMedium(size: 14)) {
        super.init(frame: .zero)
        self.text = text
        self.font = fontStyle.font
        self.textColor = UIColor(hex: "3D3D3D")
        self.numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

