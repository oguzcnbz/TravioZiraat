
import UIKit
import TinyConstraints
import SnapKit

class AppDefaultsVC: UIViewController {
    
    private lazy var mainStackView:DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupViews()
       
    }
  
    func setupViews() {
        self.view.backgroundColor = UIColor(hex: "38ada9")
        self.view.addSubviews(mainStackView)
        setupLayout()
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: "App Defaults")
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

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AppDefaultsVC_Preview: PreviewProvider {
    static var previews: some View{
         
        AppDefaultsVC().showPreview()
    }
}
#endif
