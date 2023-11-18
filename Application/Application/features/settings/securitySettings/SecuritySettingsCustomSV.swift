import UIKit
import SnapKit

class SecuritySettingsCustomSV: UIView {
    
  

        init(labelText: String) {
            super.init(frame: CGRect.zero)
            setupAndLayout(labelText: labelText)
        }

        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupAndLayout(labelText: "")
        }
        
    
    private lazy var defaultStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
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
   
     lazy var toggleSwitch:UISwitch = {
        let s = UISwitch()
        return s
    }()
    
    
    
    private func setupAndLayout(labelText: String) {
        addSubview(defaultStackView)
        defaultStackView.addSubviews(defaultLabel,toggleSwitch)
        
        defaultLabel.text = labelText
      
           defaultStackView.snp.makeConstraints { cv in
               cv.top.equalToSuperview()
               cv.bottom.equalToSuperview()
               cv.leading.equalToSuperview()
               cv.trailing.equalToSuperview()
               
           }
           
           
           defaultLabel.snp.makeConstraints { lbl in
               lbl.leading.equalTo(defaultStackView.snp.leading).offset(16)
               lbl.centerY.equalToSuperview()
               
           }
        
           toggleSwitch.snp.makeConstraints({ts in
               ts.centerY.equalToSuperview()
               ts.trailing.equalToSuperview().offset(-16)
           })
       }
}
