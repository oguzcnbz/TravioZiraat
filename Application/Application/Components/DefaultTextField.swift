import UIKit
import SnapKit
import TinyConstraints


class DefaultTextField: UITextField {
    init(text: String = "", fontStyle: FontStyle = .avengerMedium(size: 14)) {
        super.init(frame: .zero)
        self.text = text
        self.font = fontStyle.font
        self.textColor = UIColor(hex: "A9A8A8")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
