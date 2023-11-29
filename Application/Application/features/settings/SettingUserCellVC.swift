import UIKit
import TinyConstraints
import SnapKit


class SettingUserCell: UICollectionViewCell{
    
    var closure:(()->Void)?
    
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.h5.font
        return lbl
    }()
    
    private lazy var editProfileBtn: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.baseBackgroundColor = .clear
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)
        let btn = UIButton(configuration: config)
        btn.setTitle("Edit Profile", for: .normal)
        btn.titleLabel?.font = FontStyle.lt3.font
        btn.setTitleColor(ColorStyle.blueRaspberry.color, for: .normal)
        btn.addTarget(self, action: #selector(editProfilefunc), for: .touchUpInside)
        return btn
    }()
    
    let profileImageViewWidth: CGFloat = 120
    private lazy var photoView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "DefaultProfileImage").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = profileImageViewWidth / 2
        iv.layer.masksToBounds = true
        return iv
    }()
   
    
    @objc func editProfilefunc(){
        closure?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    public func configure(object:SettingUser){
        nameLbl.text = object.name
        
        if object.imageUrl?.count ?? 0 > 1{
            
            let url = URL(string: object.imageUrl ?? "")
            self.photoView.kf.setImage(with: url)
        }
    }
    
    private func setupViews(){
        self.contentView.backgroundColor = ColorStyle.background.color
        self.contentView.addSubviews(photoView,nameLbl,editProfileBtn)
        
        setupLayout()
    }
    
    
    private func setupLayout(){
        
        photoView.snp.makeConstraints({imgv in
            imgv.top.equalToSuperview().offset(24)
            imgv.centerX.equalToSuperview()
            imgv.width.equalTo(profileImageViewWidth)
            imgv.height.equalTo(profileImageViewWidth)
        })
        
        nameLbl.snp.makeConstraints({ lbl in
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
