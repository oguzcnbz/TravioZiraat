
import UIKit
import TinyConstraints
import SnapKit

class SettingUserCell: UICollectionViewCell{
    
    
    
    var closure:(()->Void)?
    
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var photoView:UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 260
        return v
    }()
    
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsSemiBold(size: 16).font
        return lbl
    }()
    
    private lazy var editProfileBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit Profile", for: .normal)
        btn.titleLabel?.font = FontStyle.poppinsLight(size: 12).font
        btn.setTitleColor(UIColor(hex: "17C0EB"), for: .normal)
        btn.addTarget(self, action: #selector(editProfilefunc), for: .touchUpInside)
        return btn
    }()
    
    @objc func editProfilefunc(){
        closure?()
//        let homevc = HomeVC()
//        let vc = HomeDetailPlacesVC()
//        homevc.navigationController?.pushViewController(vc, animated: true)
//        print("deneme")
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
  
    
    public func configure(object:SettingUser){
        photoView.image = object.image
        nameLbl.text = object.name
    }
    
    private func setupViews(){
        self.contentView.backgroundColor = UIColor(hex: "F8F8F8")
        self.contentView.addSubviews(stackView)
        stackView.addSubviews(photoView,nameLbl,editProfileBtn)
        
        
        setupLayout()
    }
    
    
    private func setupLayout(){
        
        stackView.snp.makeConstraints({sv in
            sv.top.equalToSuperview()
            sv.bottom.equalToSuperview()
            sv.trailing.equalToSuperview()
            sv.leading.equalToSuperview()
        })
        
        photoView.snp.makeConstraints({imgv in
            imgv.top.equalToSuperview().offset(24)
            imgv.centerX.equalToSuperview()
            imgv.width.equalTo(120)
        })
        
        nameLbl.snp.makeConstraints({lbl in
            lbl.top.equalTo(photoView.snp.bottom).offset(8)
            lbl.centerX.equalToSuperview()
        })
        
        editProfileBtn.snp.makeConstraints({btn in
            btn.top.equalTo(nameLbl.snp.bottom)
            btn.centerX.equalToSuperview()
        })
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


