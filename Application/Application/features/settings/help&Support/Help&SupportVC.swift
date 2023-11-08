
import UIKit
import SnapKit

class Help_SupportVC: UIViewController {
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()

    private lazy var faqLbl:UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsSemiBold(size: 24).font
        lbl.textColor = UIColor(hex: "38ada9")
        lbl.text = "FAQ"
        return lbl
    }()
    
    private lazy var first:CustomStackView = {
        let sv = CustomStackView(labelText: "How can I create a new account on Travio?", labelTexts: "")
        return sv
    }()
    
    private lazy var second:CustomStackView = {
        let sv = CustomStackView(labelText: "How can I save a visit?", labelTexts: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
        return sv
    }()
    
    private lazy var third:CustomStackView = {
        let sv = CustomStackView(labelText: "How does Travio work?", labelTexts: "")
        return sv
    }()
    
    private lazy var fourth:CustomStackView = {
        let sv = CustomStackView(labelText: "How does Travio work?", labelTexts: "")
        return sv
    }()
    
    private lazy var fifth:CustomStackView = {
        let sv = CustomStackView(labelText: "How does Travio work?", labelTexts: "")
        return sv
    }()
    
    private lazy var sixtht:CustomStackView = {
        let sv = CustomStackView(labelText: "How does Travio work?", labelTexts: "")
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews(){
        self.view.backgroundColor = UIColor(hex: "38ADA9")
        self.view.addSubview(mainStackView)
        mainStackView.addSubviews(faqLbl,first)
        setupLayout()
    }
    
    private func  setupLayout(){
        mainStackView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
        
        faqLbl.snp.makeConstraints({lbl in
            lbl.top.equalToSuperview().offset(44)
            lbl.leading.equalToSuperview().offset(24)
            lbl.trailing.equalToSuperview().offset(-24)
        })
        
        first.snp.makeConstraints({sv in
            sv.leading.equalTo(mainStackView.snp.leading).offset(24)
            sv.top.equalTo(faqLbl.snp.bottom).offset(20.51)
            sv.trailing.equalTo(mainStackView.snp.trailing).offset(-24)
            
        })
        
//        second.snp.makeConstraints({sv in
//            sv.leading.equalToSuperview().offset(24)
//            sv.top.equalTo(first.snp.bottom).offset(12)
//            sv.leading.equalToSuperview().offset(-24)
//        })
//
//        third.snp.makeConstraints({sv in
//            sv.leading.equalToSuperview().offset(24)
//            sv.top.equalTo(second.snp.bottom).offset(12)
//            sv.leading.equalToSuperview().offset(-24)
//        })
//
//        fourth.snp.makeConstraints({sv in
//            sv.leading.equalToSuperview().offset(24)
//            sv.top.equalTo(third.snp.bottom).offset(12)
//            sv.leading.equalToSuperview().offset(-24)
//        })
//
//        fifth.snp.makeConstraints({sv in
//            sv.leading.equalToSuperview().offset(24)
//            sv.top.equalTo(fourth.snp.bottom).offset(12)
//            sv.leading.equalToSuperview().offset(-24)
//        })
//
//        sixtht.snp.makeConstraints({sv in
//            sv.leading.equalToSuperview().offset(24)
//            sv.top.equalTo(fifth.snp.bottom).offset(12)
//            sv.leading.equalToSuperview().offset(-24)
//        })
//
    }
}
