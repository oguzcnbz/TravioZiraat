import UIKit
import SnapKit


class HomeHeaderCell: UICollectionReusableView {
    static let reuseIdentifier = "title-supplementary-reuse-identifier"
    
    var closure:(()->Void)?
    
    private lazy var stkRowPlaces:UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private lazy var lblName:UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.sh2.font
        return lbl
    }()
    
    private lazy var spacer:UIView  = {
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return spacer
    }()
    
    private lazy var btnPlaces:UIButton = {
        let  button =  UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.tintColor = ColorStyle.blueRaspberry.color
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped(){
        closure?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public func configure(title:String){
        lblName.text = title
    }
    
    private func setupViews(){
        addSubview(stkRowPlaces)
        stkRowPlaces.addArrangedSubviews(lblName ,btnPlaces)
        setupLayout()
    }
    
    private func setupLayout(){
        
        
        stkRowPlaces.snp.makeConstraints({ lbl in
            lbl.top.equalToSuperview().offset(12)
            lbl.leading.equalToSuperview()
            lbl.trailing.equalToSuperview()
            lbl.bottom.equalToSuperview()
        })
        
        lblName.snp.makeConstraints({ lbl in
            lbl.top.equalToSuperview()
            lbl.leading.equalToSuperview().offset(12)
            lbl.trailing.equalToSuperview().offset(-70)
        })
        
        btnPlaces.snp.makeConstraints({btn in
            btn.trailing.equalToSuperview().offset(-10)
            btn.leading.equalTo(lblName.snp.trailing).offset(30)
            btn.centerY.equalTo(lblName)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
