import UIKit
import SnapKit

class CustomTextView: UIView {
    
    init(labelText: String, textViewPlaceholder: String) {
        super.init(frame: CGRect.zero)
        setupAndLayout(labelText: labelText)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAndLayout(labelText: "")
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
        lbl.textColor = UIColor(hex: "3D3D3D")
        lbl.numberOfLines = 1
        return lbl
    }()
   
    lazy var defaultTextView: UITextView = {
        let textView = UITextView()
        textView.font = FontStyle.poppinsLight(size: 14).font
        textView.textColor = UIColor(hex: "A9A8A8")
        return textView
    }()
    
    private func setupAndLayout(labelText: String) {
        addSubview(defaultStackView)
        defaultStackView.addSubviews(defaultLabel, defaultTextView)
        
        defaultLabel.text = labelText
      
        
        defaultStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        defaultLabel.snp.makeConstraints { make in
            make.leading.equalTo(defaultStackView.snp.leading).offset(12)
            make.trailing.equalTo(defaultStackView.snp.trailing).offset(0)
            make.top.equalTo(defaultStackView.snp.top).offset(8)
            make.height.equalTo(21)
        }
        
        defaultTextView.snp.makeConstraints { make in
            make.leading.equalTo(defaultStackView.snp.leading).offset(12)
            make.trailing.equalTo(defaultStackView.snp.trailing).offset(0)
            make.top.equalTo(defaultLabel.snp.bottom).offset(8)
            make.height.equalTo(162)
        }
    }
}
