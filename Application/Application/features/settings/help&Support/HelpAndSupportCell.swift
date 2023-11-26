import UIKit
import SnapKit
import TinyConstraints


class HelpAndSupportCell: UITableViewCell {
    
    private lazy var defaultStackView: UIStackView = {
        let v = UIStackView()
        v.backgroundColor = .white
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.15
        v.layer.shadowRadius = 20
        v.layer.cornerRadius = 16
        v.layer.masksToBounds = false
        v.translatesAutoresizingMaskIntoConstraints = false
        v.distribution = .fill
        v.alignment = .fill
        v.axis = .vertical
        v.spacing = 8
        v.isLayoutMarginsRelativeArrangement = true
        v.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 12, bottom: 15, trailing: 18)
        return v
    }()
    
    let mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 41
        return sv
    }()
    
    lazy var questionLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.sh3.font
        lbl.textColor = ColorStyle.blackRaven.color
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        return lbl
    }()
    
    private lazy var vector:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "arrowGreenDown")?.withRenderingMode(.alwaysTemplate)
        img.tintColor = ColorStyle.primary.color
      
        return img
    }()
    
    let expandableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true

        return view
    }()
    
    lazy var answerLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.lt4.font
        lbl.textColor = ColorStyle.blackRaven.color
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        return lbl
    }()
        
    public func configure(object:HelpAndSupportModel){
        questionLbl.text = object.questionLbl
        answerLbl.text = object.answerLbl
        expandableView.isHidden = !object.isExpanded
        vector.image = (object.isExpanded ? UIImage(named: "arrowGreenUp") : UIImage(named: "arrowGreenDown"))?.withRenderingMode(.alwaysTemplate)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupViews()
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubviews(defaultStackView)
        defaultStackView.addArrangedSubviews(mainStackView,expandableView)
        mainStackView.addArrangedSubviews(questionLbl,vector)
        expandableView.addSubview(answerLbl)
        setupLayout()
    }
    
        private func setupLayout(){
            
            defaultStackView.snp.makeConstraints { v in
                v.top.equalToSuperview().offset(16)
                v.bottom.equalToSuperview()
                v.leading.equalToSuperview().offset(24)
                v.trailing.equalToSuperview().offset(-24)
            }
        
            vector.snp.makeConstraints({img in
                img.width.equalTo(15)
                img.trailing.equalToSuperview().offset(-30)
               
            })
            
            answerLbl.snp.makeConstraints { lbl in
                lbl.leading.equalToSuperview()
                lbl.trailing.equalToSuperview()
                lbl.top.equalToSuperview()
                lbl.bottom.equalToSuperview()
            }
        }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HelpAndSupportVC_Preview: PreviewProvider {
    static var previews: some View{
         
        HelpAndSupportVC().showPreview()
    }
}
#endif
