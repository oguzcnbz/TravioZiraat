
import UIKit
import SnapKit
import Kingfisher



class PlaceDetailCell: UICollectionViewCell {
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let startColor = UIColor(hex: "333333").withAlphaComponent(0)
        let endColor = UIColor(hex: "ffffff").withAlphaComponent(1)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        return gradientLayer
       }()
    
    private lazy var imgPlace:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public func configure(object:String){
       let url = URL(string: object)
        imgPlace.kf.setImage(with: url)
    }
    
    private func setupViews(){
        self.contentView.addSubviews(imgPlace)
        imgPlace.layer.addSublayer(gradientLayer)
        setupLayout()
    }
    
    private func setupLayout(){
        gradientLayer.frame = self.contentView.bounds

        imgPlace.snp.makeConstraints({ imgv in
            imgv.leading.equalToSuperview()
            imgv.top.equalToSuperview()
            imgv.trailing.equalToSuperview()
            imgv.bottom.equalToSuperview()
            
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
