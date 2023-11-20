import UIKit

class DefaultButton: UIButton {
    init(title: String = "", background: ColorStyle) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.textColor = .white
        self.backgroundColor = background.color
        self.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        self.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
