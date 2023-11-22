import UIKit
import TinyConstraints
import SnapKit


class SettingCell: UICollectionViewCell{
    
    var closure:(()->Void)?
    
    private lazy var sttngscell:UIView = {
        let v = UIView()
        v.backgroundColor = ColorStyle.white.color
        v.layer.cornerRadius = 16
        return v
    }()
    
    private lazy var vector:UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private lazy var sttngsLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.lt1.font
        return lbl
    }()
    
    private lazy var vector2:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "arrowGreenForward")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public func configure(object:Settings){
        vector.image = object.icon
        sttngsLbl.text = object.settingName
    }
    
    private func setupViews(){
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.15
        self.contentView.layer.shadowRadius = 20
        self.contentView.layer.cornerRadius = 16
       
        self.contentView.backgroundColor = ColorStyle.background.color
        self.contentView.addSubviews(sttngscell)
        sttngscell.addSubviews(vector,sttngsLbl,vector2)
        
        setupLayout()
    }
    
    private func setupLayout(){
        
        sttngscell.snp.makeConstraints { v in
            v.top.equalToSuperview()
            v.bottom.equalToSuperview()
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
        }
        
        vector.snp.makeConstraints { imgv in
            imgv.top.equalToSuperview().offset(17)
            imgv.bottom.equalToSuperview().offset(-17)
            imgv.leading.equalToSuperview().offset(16.51)
        }
        
        sttngsLbl.snp.makeConstraints { lbl in
            lbl.leading.equalTo(vector.snp.trailing).offset(7.86)
            lbl.centerY.equalTo(vector)
        }
        
        vector2.snp.makeConstraints { imgv in
            imgv.trailing.equalToSuperview().offset(-16.42)
            imgv.centerY.equalTo(sttngsLbl)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

