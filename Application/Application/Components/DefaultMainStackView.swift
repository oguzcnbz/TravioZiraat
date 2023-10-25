import UIKit

class DefaultMainStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame) 
        self.axis = .vertical
        self.backgroundColor = UIColor(hex: "F8F8F8")
        self.layer.cornerRadius = 80
        self.layer.maskedCorners = [.layerMinXMinYCorner]
        self.distribution = .fillProportionally
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
