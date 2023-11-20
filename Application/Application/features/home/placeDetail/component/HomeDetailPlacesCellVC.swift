import UIKit
import SnapKit

class HomeDetailPlacesCell: UICollectionViewCell {
       
    var closure:(()->Void)?
    
    private lazy var imgPlace:UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    private lazy var ViewCell:UIView = {
        let v = UIView()
        v.backgroundColor = ColorStyle.white.color
        v.layer.cornerRadius = 16
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var vector:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icVisitBlack")
        return img
    }()
    
    private lazy var lblName:UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorStyle.blackRaven.color
        lbl.font = FontStyle.poppinsSemiBold(size: 24).font
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private lazy var lblPlace:UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorStyle.blackRaven.color
        lbl.font = FontStyle.poppinsLight(size: 16).font
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @objc func btnTapped(){
        closure?()
    }
    
    public func configure(object:Place){
        let url = URL(string: object.coverImageURL)
        imgPlace.kf.setImage(with: url)
       
        lblName.text = object.title
        lblPlace.text = object.place
        
    }
    
    private func setupViews(){
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.15
        self.contentView.layer.shadowRadius = 20
        self.contentView.addSubviews(ViewCell)
        ViewCell.addSubviews(imgPlace,lblName,vector,lblPlace)
        
        setupLayout()
    }
    
    private func setupLayout(){
        
        ViewCell.snp.makeConstraints({v in
            v.leading.equalToSuperview()
            v.top.equalToSuperview()
            v.bottom.equalToSuperview()
            v.trailing.equalToSuperview()
        })
        
        imgPlace.snp.makeConstraints({ imgv in
            imgv.leading.equalToSuperview()
            imgv.top.equalToSuperview()
            imgv.bottom.equalToSuperview()
            imgv.width.equalTo(90)
        })
        
        lblName.snp.makeConstraints({lbl in
            lbl.leading.equalTo(imgPlace.snp.trailing).offset(8)
            lbl.trailing.equalToSuperview().offset(-8)
            lbl.top.equalTo(ViewCell.snp.top).offset(16)
        })
        
        vector.snp.makeConstraints({imgv in
            imgv.leading.equalTo(imgPlace.snp.trailing).offset(8)
            imgv.top.equalTo(lblName.snp.bottom).offset(3)
        })
        
        lblPlace.snp.makeConstraints({lbl in
            lbl.leading.equalTo(vector.snp.trailing).offset(6)
            lbl.centerY.equalTo(vector)
        })
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


