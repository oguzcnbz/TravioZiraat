
import UIKit
import TinyConstraints
import SnapKit

class SettingCell: UICollectionViewCell{
    
    var closure:(()->Void)?
    
    private lazy var sttngscell:UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 16
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.15
        v.layer.shadowRadius = 20
        return v
    }()
    
    private lazy var vector:UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private lazy var sttngsLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsLight(size: 16).font
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
        self.contentView.backgroundColor = UIColor(hex: "F8F8F8")
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

