import UIKit
import SnapKit


class CustomStackView: UIView {
    
     init(labelText: String, labelTexts: String) {
            super.init(frame: CGRect.zero)
            setupAndLayout(mainlabelText: labelText, labelText: labelTexts)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupAndLayout(mainlabelText: "", labelText: "")
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
    
    lazy var mainLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsMedium(size: 14).font
        lbl.textColor = UIColor(hex: "3D3D3D")
        lbl.numberOfLines = 1
        return lbl
    }()
   
    lazy var Label: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsMedium(size: 14).font
        lbl.textColor = UIColor(hex: "3D3D3D")
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private func setupAndLayout(mainlabelText: String, labelText: String) {
        addSubview(defaultStackView)
        defaultStackView.addSubviews(mainLabel,Label)
        
        
        mainLabel.text = mainlabelText
        Label.text = labelText
        
           defaultStackView.snp.makeConstraints { make in
               make.top.equalToSuperview()
               make.bottom.equalToSuperview()
               make.leading.equalToSuperview()
               make.trailing.equalToSuperview()
               
           }
           
           
        mainLabel.snp.makeConstraints { make in
               make.leading.equalTo(defaultStackView.snp.leading).offset(12)
               make .trailing.equalTo(defaultStackView.snp.trailing).offset(0)
               make.top.equalTo(defaultStackView.snp.top).offset(8)
               make.height.equalTo(21)
           }
           
           
        Label.snp.makeConstraints { make in
               make.leading.equalTo(defaultStackView.snp.leading).offset(12)
               make.trailing.equalTo(defaultStackView.snp.trailing).offset(0)
               make.top.equalTo(mainLabel.snp.bottom).offset(8)
               make.height.equalTo(18)
           }
       }
    
}
