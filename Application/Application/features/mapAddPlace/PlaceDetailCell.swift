
import UIKit
import SnapKit

class PlaceDetailCell: UICollectionViewCell {
    
    private lazy var imgPlace:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public func configure(object:PlaceDetailModel){
        imgPlace.image = object.image
    }
    
    private func setupViews(){
        self.contentView.addSubviews(imgPlace)
        setupLayout()
    }
    
    private func setupLayout(){
        

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
