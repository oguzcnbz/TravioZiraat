import UIKit
import SnapKit


class CustomPasswordTextField: UIView {
    
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
        lbl.font = FontStyle.sh3.font
        lbl.textColor = ColorStyle.blackRaven.color
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var defaultTextField: UITextField = {
        let txt = UITextField()
        txt.font = FontStyle.sh3.font
        txt.textColor = ColorStyle.darkgray.color
        txt.isSecureTextEntry = true
        return txt
    }()
    
    private lazy var passwordShowToggle: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName:"eye.slash"), for: .normal)
        btn.tintColor = ColorStyle.primary.color
        btn.addTarget(self, action: #selector(startShowingPassword), for: .touchDown)
        btn.addTarget(self, action: #selector(stopShowingPassword), for: .touchUpInside)
        btn.addTarget(self, action: #selector(stopShowingPassword), for: .touchUpOutside)
        return btn
    }()
    
    @objc private func startShowingPassword(textfield:CustomTextField) {
        passwordShowToggle.setImage(UIImage(systemName: "eye"), for: .normal)
        defaultTextField.isSecureTextEntry = false
    }
    
    @objc private func stopShowingPassword(textfield:CustomTextField) {
        passwordShowToggle.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        defaultTextField.isSecureTextEntry = true
        
    }
    
    private func setupAndLayout(labelText: String, textFieldPlaceholder: String) {
        addSubview(defaultStackView)
        defaultStackView.addSubviews(defaultLabel,defaultTextField)
        defaultStackView.addSubview(passwordShowToggle)
        
        
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
            tf.trailing.equalTo(defaultStackView.snp.trailing).offset(-50)
            tf.top.equalTo(defaultLabel.snp.bottom).offset(8)
            tf.height.equalTo(18)
        }
        
        passwordShowToggle.snp.makeConstraints({tgl in
            tgl.centerY.equalTo(defaultTextField)
            tgl.trailing.equalToSuperview().offset(-16)
            tgl.height.equalTo(24)
            tgl.width.equalTo(24)
        })
    }
}
