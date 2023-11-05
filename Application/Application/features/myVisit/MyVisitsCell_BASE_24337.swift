

import UIKit
import SnapKit

class MyVisitsCell: UICollectionViewCell {

    weak var delegate:DataTransferDelegate?
    
    var closure:(()->Void)?
    
    private lazy var imgPlace:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var imgStackview:UIStackView = {
        let stack = UIStackView()
        stack.layer.cornerRadius = 16
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.shadowOpacity = 0.15
        stack.layer.shadowRadius = 20
        return stack
    }()
    
    private lazy var vector:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icVisit-White")
        return img
    }()
    
    private lazy var lblName:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hex: "FFFFFF")
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 30)
        return lbl
    }()
    
    private lazy var lblPlace:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hex: "FFFFFF")
        lbl.font = UIFont(name: "Poppins-Light", size: 16)
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
        self.contentView.addSubviews(imgPlace)
        imgPlace.addSubview(imgStackview)
        imgStackview.addSubviews(lblName,vector,lblPlace)
        setupLayout()
    }
    
    private func setupLayout(){
        
        imgPlace.snp.makeConstraints({ image in
            image.leading.equalToSuperview()
            image.top.equalToSuperview()
            image.bottom.equalToSuperview()
        })
        
        imgStackview.snp.makeConstraints({image in
            image.leading.equalTo(imgPlace.snp.leading)
            image.trailing.equalTo(imgPlace.snp.trailing)
            image.bottom.equalTo(imgPlace.snp.bottom)
            image.top.equalTo(imgPlace.snp.top).offset(110)
        })
        
        lblName.snp.makeConstraints({lbl in
            lbl.leading.equalTo(imgStackview.snp.leading).offset(8)
            lbl.bottom.equalTo(vector.snp.top).offset(2)
        })
        
        vector.snp.makeConstraints({img in
            img.leading.equalTo(imgStackview.snp.leading).offset(8)
            img.bottom.equalTo(imgStackview.snp.bottom).offset(-20)
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
