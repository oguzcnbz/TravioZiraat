import UIKit
import SnapKit

class MyVisitsCell: UICollectionViewCell {

    weak var delegate:DataTransferDelegate?
    
    var closure:(()->Void)?
    
    private lazy var imgPlace: UIImageView = {
            let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
            return iv
        }()
    
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let startColor = UIColor(hex: "333333").withAlphaComponent(0)
        let endColor = UIColor(hex: "3D3D3D").withAlphaComponent(1)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        return gradientLayer
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
    
    
    public func configure(object:PlacesModel){
        imgPlace.image = object.image
        lblName.text = object.name
        lblPlace.text = object.place
        
    }
    
    private func setupViews(){
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.15
        self.contentView.layer.shadowRadius = 20
        
        
        self.contentView.addSubviews(imgPlace)
        imgPlace.addSubviews(lblName,vector,lblPlace)
        imgPlace.layer.addSublayer(gradientLayer)
        
        imgPlace.bringSubviewToFront(lblName)
        imgPlace.bringSubviewToFront(vector)
        imgPlace.bringSubviewToFront(lblPlace)
        setupLayout()
    }
    
    private func setupLayout(){
        
        gradientLayer.frame = self.contentView.bounds
        
        imgPlace.snp.makeConstraints({ img in
            img.leading.equalToSuperview()
            img.trailing.equalToSuperview()
            img.top.equalToSuperview()
            img.bottom.equalToSuperview()
        
        })
        
        lblName.snp.makeConstraints({lbl in
            lbl.leading.equalTo(imgPlace.snp.leading).offset(8)
            lbl.bottom.equalTo(vector.snp.top).offset(2)
          
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


