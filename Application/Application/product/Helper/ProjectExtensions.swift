import UIKit
import Foundation
import SwiftUI
import UIKit
import SwiftUI


extension UIView {
   func roundCornerss(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}


extension UIViewController {
    
    @objc func leftbartapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationItems(leftBarButton: Bool, rightBarButton: UIBarButtonItem?, title: String?) {
        
        let spaceBetweenItems: CGFloat = 24.0
        
        if leftBarButton == true,let title = title {
            let leftBarButton = UIBarButtonItem(image: UIImage(named: "backWard"), style: .plain, target: self, action: #selector(leftbartapped))
            leftBarButton.tintColor = .white
            self.navigationItem.leftBarButtonItem = leftBarButton
            
            let titleLbl = UILabel()
            titleLbl.text = title
            titleLbl.textColor = .white
            titleLbl.font = FontStyle.h1.font
            titleLbl.adjustsFontSizeToFitWidth = true
            let lblItem = UIBarButtonItem(customView: titleLbl)
            self.navigationItem.leftBarButtonItem = lblItem

            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                flexibleSpace.width = spaceBetweenItems
            self.navigationItem.leftBarButtonItems = [leftBarButton, flexibleSpace, lblItem]
            
        } else {
            if let title = title {
                let titleLbl = UILabel()
                titleLbl.text = title
                titleLbl.textColor = .white
                titleLbl.font = FontStyle.h1.font
                let lblItem = UIBarButtonItem(customView: titleLbl)
                self.navigationItem.leftBarButtonItem = lblItem
            }
        }
        
        if let rightBarButton = rightBarButton {
            self.navigationItem.rightBarButtonItem = rightBarButton
            rightBarButton.tintColor = .white
        }
    }

    
    func showLoadingIndicator() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.color = ColorStyle.primary.color
        loadingView.startAnimating()
        
        view.addSubviews(visualEffectView, loadingView)
        
        visualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func hideLoadingIndicator() {
            for subview in view.subviews {
                if subview is UIActivityIndicatorView || subview is UIVisualEffectView {
                    subview.removeFromSuperview()
                }
            }
        }
    
    func resultAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .cancel))
        present(alert, animated: true, completion: nil)
    }

}
