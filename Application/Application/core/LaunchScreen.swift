import UIKit
import SnapKit
import TinyConstraints


class LauncScreen: UIViewController {
    
    private lazy var homeScene:UIView = {
        let scene = UIView()
        scene.backgroundColor = UIColor(hex: "38ada9")
        return scene
    }()
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"TravioDisc")
        return imageView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        self.view.addSubview(homeScene)
        homeScene.addSubview(imageView)
        
        
     layout()
    }
    
    private func layout(){
        
        homeScene.snp.makeConstraints({ view in
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
            view.top.equalToSuperview()
        })
        
        imageView.snp.makeConstraints({ view in
            view.centerX.equalToSuperview()
            view.top.equalToSuperview().offset(213)
        })
        
    }
    
}


