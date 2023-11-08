import UIKit
import SnapKit

class MapCell: UICollectionViewCell {

    weak var delegate:DataTransferDelegate?
    
    var closure:(()->Void)?
    
    private lazy var imgPlace:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
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
        lbl.textColor = UIColor(hex: "FFFFFF")
        lbl.font = FontStyle.poppinsSemiBold(size: 30).font
        return lbl
    }()
    
    private lazy var lblPlace:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hex: "FFFFFF")
        lbl.font = FontStyle.poppinsLight(size: 16).font
        return lbl
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    @objc func btnTapped(){
        closure?()
        delegate?.getData(data: "")
    }
    
    public func configure(object:Place){
        
        let url = URL(string: object.coverImageURL)
        imgPlace.kf.setImage(with: url)
       
        lblName.text = object.title
        lblPlace.text = object.place
        
    }
    
    private func setupViews(){
        self.contentView.addSubviews(imgPlace)
        imgPlace.addSubviews(lblName,vector,lblPlace)
        
        setupLayout()
    }
    
    private func setupLayout(){
        
        imgPlace.snp.makeConstraints({ img in
            img.leading.equalToSuperview()
            img.trailing.equalToSuperview()
            img.top.equalToSuperview()
            img.bottom.equalToSuperview()
            
        })
        
        lblName.snp.makeConstraints({lbl in
            lbl.leading.equalTo(imgPlace.snp.leading).offset(8)
            lbl.bottom.equalTo(vector.snp.top).offset(2)
          //  lbl.trailing.equalTo(imgPlace.snp.trailing).offset(-8)
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

