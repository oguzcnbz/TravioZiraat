import UIKit
import SnapKit
import TinyConstraints


class HelpAndSupportCell: UICollectionViewCell {
    
    private lazy var defaultStackView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 16
        v.backgroundColor = ColorStyle.white.color
        v.clipsToBounds = true
        return v
    }()
    
    lazy var questionLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.sh3.font
        lbl.numberOfLines = 0
        lbl.textColor = ColorStyle.blackRaven.color
       
        return lbl
    }()
   
    lazy var answerLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.lt4.font
        lbl.numberOfLines = 5
        lbl.textColor = ColorStyle.blackRaven.color
      
        return lbl
    }()
    
    private lazy var vector:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "arrowGreenDown")
        return img
    }()
    
    func updateVector( imageName: String) {
        vector.image = UIImage(named: imageName)
    }
    
    public func configure(object:HelpAndSupportModel){
        questionLbl.text = object.questionLbl
        answerLbl.text = object.answerLbl
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.15
        self.contentView.layer.shadowRadius = 20
        self.contentView.addSubviews(defaultStackView)
        defaultStackView.addSubviews(questionLbl,answerLbl,vector)
        
        setupLayout()
    }
    
        private func setupLayout(){
            
            defaultStackView.snp.makeConstraints { v in
                v.top.equalToSuperview()
                v.bottom.equalToSuperview()
                v.leading.equalToSuperview()
                v.trailing.equalToSuperview()
            }
            
            questionLbl.snp.makeConstraints { lbl in
                lbl.leading.equalToSuperview().offset(12)
                lbl.top.equalToSuperview().offset(16)
                lbl.trailing.equalTo(vector.snp.leading).offset(12)
            }
            
            vector.snp.makeConstraints({img in
                img.centerY.equalTo(questionLbl)
                img.trailing.equalToSuperview().offset(-18.37)
                img.width.equalTo(15.63)
            })

            answerLbl.snp.makeConstraints { lbl in
                lbl.leading.equalToSuperview().offset(12)
                lbl.trailing.equalToSuperview().offset(-15)
                lbl.top.equalTo(questionLbl.snp.bottom).offset(22)
            }
        }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
