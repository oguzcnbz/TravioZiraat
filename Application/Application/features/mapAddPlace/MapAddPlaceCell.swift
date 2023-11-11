
import UIKit
import SnapKit

class MapAddPlaceCell: UICollectionViewCell {
    
    
    private lazy var imgPlace:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var addPhotolbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Add Photo"
        lbl.font = FontStyle.poppinsLight(size: 12).font
        lbl.textColor = UIColor.lightGray
        return lbl
    }()
    
    private lazy var vector:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "camera")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 16
        
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.15
        self.contentView.layer.shadowRadius = 20
        
        self.contentView.addSubviews(imgPlace)
        imgPlace.addSubviews(vector,addPhotolbl)
        
        setupLayout()
    }
    
    private func  setupLayout(){
        imgPlace.snp.makeConstraints({ img in
            img.leading.equalToSuperview()
            img.trailing.equalToSuperview()
            img.top.equalToSuperview()
            img.bottom.equalToSuperview()
            
        })
        
        vector.snp.makeConstraints({img in
            img.centerX.equalTo(imgPlace)
            img.top.equalTo(imgPlace.snp.top).offset(79)
        })
        
        addPhotolbl.snp.makeConstraints({lbl in
            lbl.centerX.equalTo(imgPlace)
            lbl.top.equalTo(vector.snp.bottom).offset(5)
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
