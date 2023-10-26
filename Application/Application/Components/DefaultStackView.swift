import UIKit

class DefaultStackView: UIStackView {

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
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.shadowRadius = 20.0
        self.layer.shadowOpacity = 0.15
        self.spacing = 8
    }
}
