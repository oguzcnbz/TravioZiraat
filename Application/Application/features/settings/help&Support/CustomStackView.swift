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
    
    private lazy var vector:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "downArrawGreen"), for: .normal)
        return btn
    }()
    
    private func setupAndLayout(mainlabelText: String, labelText: String) {
        addSubview(defaultStackView)
        defaultStackView.addSubviews(mainLabel,Label,vector)
        
        
        mainLabel.text = mainlabelText
        Label.text = labelText
        
           defaultStackView.snp.makeConstraints { sv in
               sv.top.equalToSuperview()
               sv.bottom.equalToSuperview()
               sv.leading.equalToSuperview()
               sv.trailing.equalToSuperview()
               
           }
           
        mainLabel.snp.makeConstraints { lbl in
            lbl.leading.equalTo(defaultStackView.snp.leading).offset(12)
            lbl .trailing.equalTo(defaultStackView.snp.trailing).offset(0)
            lbl.top.equalTo(defaultStackView.snp.top).offset(8)
            lbl.height.equalTo(21)
           }
           
           
        Label.snp.makeConstraints { lbl in
            lbl.leading.equalTo(defaultStackView.snp.leading).offset(12)
            lbl.trailing.equalTo(defaultStackView.snp.trailing).offset(0)
            lbl.top.equalTo(mainLabel.snp.bottom).offset(8)
            lbl.height.equalTo(18)
           }
        
        vector.snp.makeConstraints({img in
            img.centerY.equalTo(mainLabel)
            img.trailing.equalTo(defaultStackView.snp.trailing).offset(-18.37)
           
        })
        
       }
    
}
