
import UIKit
import SnapKit
import TinyConstraints

class PopularPlacesVC: UIViewController {
    

    private lazy var mainStackView: DefaultMainStackView = {
        let stack = DefaultMainStackView()
        return stack
    }()
    
    //MARK: -- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupViews()
       
    }
    
    
    
    
    
    //MARK: -- UI Methods
    func setupViews() {
        self.view.backgroundColor = UIColor(hex: "38ada9")
        self.view.addSubviews(mainStackView)
        setupLayout()
    }
    
    func setupLayout() {
        mainStackView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.85)
        }
       
    }
  
}


