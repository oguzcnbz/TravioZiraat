import UIKit

enum ButtonBackground {
    case lightGray
    case green
    
    var backgroundColor: UIColor {
        switch self {
        case .lightGray:
            return UIColor(hex: "999999")
        case .green:
            return UIColor(hex: "38ADA9")
        }
    }
}

class DefaultButton: UIButton {
    init(title: String = "", background: ButtonBackground) {
        super.init(frame: .zero)
        
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.textColor = .white
        self.backgroundColor = background.backgroundColor
        self.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        self.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
