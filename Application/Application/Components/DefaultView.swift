import UIKit

class DefaultView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame) 
        self.backgroundColor = UIColor(hex: "38ada9")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

