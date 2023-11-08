

import UIKit
import SnapKit

class HomeHeaderCell: UICollectionReusableView {
    static let reuseIdentifier = "title-supplementary-reuse-identifier"
  
    
    var closure:(()->Void)?
    
 
    
    private lazy var stkRowPlaces:UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
       
        return sv
    }()
    
    private lazy var lblName:UILabel = {
        let lbl = UILabel()
        lbl.text = "Places"
      //  lbl.textColor = UIColor(hex: "FFFFFF")
        lbl.font = UIFont(name: "Poppins", size: 20)
        return lbl
    }()
    
    private lazy var spacer:UIView  = {
         let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return spacer
    }()
    
    private lazy var btnPlaces:UIButton = {
      let  button =  UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.tintColor = ColorStyle.blueRaspberry.color
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        
        return button
    }()
    @objc func buttonTapped(){
        
        
        
        closure?()
     //  let vc = HomeDetailPlacesVC()
//        let homevc = HomeVC()
//       
//        homevc.navigationController?.pushViewController(vc, animated: true)
//        print("deneme")
       
       
       
    }
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public func configure(){
        
    }
    
    private func setupViews(){
       
        addSubview(stkRowPlaces)
        stkRowPlaces.addArrangedSubviews(lblName ,btnPlaces)
     
        
        
        setupLayout()
    }
    
    private func setupLayout(){

        
stkRowPlaces.snp.makeConstraints({ label in
                    label.top.equalToSuperview().offset(12)
                    label.leading.equalToSuperview()
                    label.trailing.equalToSuperview()
    label.bottom.equalToSuperview()
                })
        
        lblName.snp.makeConstraints({ label in
            label.top.equalToSuperview()
                    label.leading.equalToSuperview().offset(12)
            label.trailing.equalToSuperview().offset(-70)
                })
        
        btnPlaces.snp.makeConstraints({btn in
            btn.trailing.equalToSuperview().offset(-10)
        btn.leading.equalTo(lblName.snp.trailing).offset(30)
            //btn.top.equalTo(buttonLogin.snp.bottom).offset(141)
            btn.centerY.equalTo(lblName)
         
        })
        
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
