import UIKit

class DefaultMainStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.axis = .vertical
        self.backgroundColor = ColorStyle.background.color
        self.layer.cornerRadius = 80
        self.layoutIfNeeded()
        self.layer.maskedCorners = [.layerMinXMinYCorner]
        self.distribution = .fillProportionally
    }
}
