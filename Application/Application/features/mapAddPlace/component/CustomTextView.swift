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
        stack.backgroundColor = ColorStyle.white.color
        stack.layer.cornerRadius = 16
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.shadowOpacity = 0.15
        stack.layer.shadowRadius = 20
        return stack
    }()
    
    lazy var defaultLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.sh3.font
        lbl.textColor = ColorStyle.blackRaven.color
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var defaultTextView: UITextView = {
        let textView = UITextView()
        textView.font = FontStyle.lt2.font
        textView.textColor = ColorStyle.darkgray.color
        return textView
    }()
    
    private func setupAndLayout(labelText: String) {
        addSubview(defaultStackView)
        defaultStackView.addSubviews(defaultLabel, defaultTextView)
        
        defaultLabel.text = labelText
        
        
        defaultStackView.snp.makeConstraints { sv in
            sv.top.equalToSuperview()
            sv.bottom.equalToSuperview()
            sv.leading.equalToSuperview()
            sv.trailing.equalToSuperview()
        }
        
        defaultLabel.snp.makeConstraints { lbl in
            lbl.leading.equalTo(defaultStackView.snp.leading).offset(12)
            lbl.trailing.equalTo(defaultStackView.snp.trailing).offset(0)
            lbl.top.equalTo(defaultStackView.snp.top).offset(8)
            lbl.height.equalTo(21)
        }
        
        defaultTextView.snp.makeConstraints { tv in
            tv.leading.equalTo(defaultStackView.snp.leading).offset(12)
            tv.trailing.equalTo(defaultStackView.snp.trailing).offset(0)
            tv.top.equalTo(defaultLabel.snp.bottom).offset(8)
            tv.height.equalTo(162)
        }
    }
}
