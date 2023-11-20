import UIKit
import SnapKit

enum FontStyle {
    case poppinsLight(size: CGFloat)
    case poppinsMedium(size: CGFloat)
    case poppinsSemiBold(size: CGFloat)
    
    var font: UIFont? {
        switch self {
        case .poppinsLight(let size):
            return UIFont(name: "Poppins-Light", size: size)
        case .poppinsMedium(let size):
            return UIFont(name: "Poppins-Medium", size: size)
        case .poppinsSemiBold(let size):
            return UIFont(name: "Poppins-SemiBold", size: size)
        }
    }
}


class CustomTextField: UIView {
    
     init(labelText: String, textFieldPlaceholder: String) {
            super.init(frame: CGRect.zero)
            setupAndLayout(labelText: labelText, textFieldPlaceholder: textFieldPlaceholder)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupAndLayout(labelText: "", textFieldPlaceholder: "")
        }
        
    
    private lazy var defaultStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 16
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.shadowOpacity = 0.15
        stack.layer.shadowRadius = 20
    
        return stack
    }()
    
    lazy var defaultLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsMedium(size: 14).font
        lbl.textColor = ColorStyle.blackRaven.color
        lbl.numberOfLines = 1
        return lbl
    }()
   
     lazy var defaultTextField: UITextField = {
        let txt = UITextField()
        txt.font = FontStyle.poppinsLight(size: 14).font
        txt.textColor = ColorStyle.darkgray.color
        return txt
    }()
    
    private func setupAndLayout(labelText: String, textFieldPlaceholder: String) {
        addSubview(defaultStackView)
        defaultStackView.addSubviews(defaultLabel,defaultTextField)
        
        
        defaultLabel.text = labelText
        defaultTextField.placeholder = textFieldPlaceholder
        
           defaultStackView.snp.makeConstraints { sv in
               sv.top.equalToSuperview()
               sv.bottom.equalToSuperview()
               sv.leading.equalToSuperview()
               sv.trailing.equalToSuperview()
           }
           
           defaultLabel.snp.makeConstraints { lbl in
               lbl.leading.equalTo(defaultStackView.snp.leading).offset(12)
               lbl .trailing.equalTo(defaultStackView.snp.trailing).offset(0)
               lbl.top.equalTo(defaultStackView.snp.top).offset(8)
               lbl.height.equalTo(21)
           }
           
           defaultTextField.snp.makeConstraints { tf in
               tf.leading.equalTo(defaultStackView.snp.leading).offset(12)
               tf.trailing.equalTo(defaultStackView.snp.trailing).offset(0)
               tf.top.equalTo(defaultLabel.snp.bottom).offset(8)
               tf.height.equalTo(18)
           }
       }
}
