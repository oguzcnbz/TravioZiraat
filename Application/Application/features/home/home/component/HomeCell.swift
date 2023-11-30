import UIKit
import SnapKit
import Kingfisher


class HomeCell: UICollectionViewCell {
    
    var closure:(()->Void)?
    
    private lazy var imgPlace:UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    
    private lazy var vector:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icVisitWhite")
        return img
    }()
    
    private lazy var lblName:UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorStyle.white.color
        lbl.font = FontStyle.h4.font
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private lazy var lblPlace:UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorStyle.white.color
        lbl.font = FontStyle.lt2.font
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
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
        
        self.contentView.addSubviews(imgPlace)
        imgPlace.addSubviews(lblName,vector,lblPlace)
        
        setupLayout()
    }
    
    private func setupLayout(){
        
        imgPlace.snp.makeConstraints({ image in
            image.leading.equalToSuperview()
            image.trailing.equalToSuperview()
            image.top.equalToSuperview()
            image.bottom.equalToSuperview()
            
        })
        
        lblName.snp.makeConstraints({lbl in
            lbl.leading.equalTo(imgPlace.snp.leading).offset(8)
            lbl.bottom.equalTo(vector.snp.top).offset(2)
            lbl.trailing.equalTo(imgPlace.snp.trailing).offset(0)
        })
        
        vector.snp.makeConstraints({img in
            img.leading.equalTo(imgPlace.snp.leading).offset(8)
            img.bottom.equalTo(imgPlace.snp.bottom).offset(-20)
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
