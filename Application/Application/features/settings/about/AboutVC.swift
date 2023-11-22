
import UIKit
import TinyConstraints
import SnapKit

class AboutVC: UIViewController {
    
    private lazy var mainStackView:DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
  
    func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubviews(mainStackView)
        setupLayout()
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: "About Us")
    }
    
    func setupLayout() {
        mainStackView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
    }
}

