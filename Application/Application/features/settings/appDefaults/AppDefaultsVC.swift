import UIKit
import TinyConstraints
import SnapKit


class AppDefaultsVC: UIViewController {
    
    //MARK: -- Components

    private lazy var mainStackView:DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    //MARK: -- Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: -- Setup

    func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubviews(mainStackView)
        setupLayout()
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: "App Defaults")
    }
    
    //MARK: -- Layout
    func setupLayout() {
        mainStackView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
    }
}

