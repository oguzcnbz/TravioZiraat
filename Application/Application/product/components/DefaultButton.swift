import UIKit

class DefaultButton: UIButton {
    init(title: String = "", background: ColorStyle) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.textColor = .white
        self.backgroundColor = background.color
        self.titleLabel?.font = FontStyle.h5.font
        self.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
