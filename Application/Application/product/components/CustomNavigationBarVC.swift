import UIKit

extension SettingsVC {
    
    @objc func leftbartapped(){
        self.navigationController?.popViewController(animated: true)
    }
    func setNavigationItems(leftBarButton: Bool, rightBarButton: UIBarButtonItem?, title: String?) {
        if leftBarButton == true {
            let leftBarButton = UIBarButtonItem(image: UIImage(named: "backWard"), style: .plain, target: self, action: #selector(leftbartapped))
            leftBarButton.tintColor = .white
            self.navigationItem.leftBarButtonItem = leftBarButton
            if let title = title {
                let titleLbl = UILabel()
                titleLbl.text = title
                titleLbl.textColor = .white
                titleLbl.font = FontStyle.poppinsSemiBold(size: 36).font
                self.navigationItem.titleView = titleLbl
            } else {
                self.navigationItem.titleView = nil
            }
        } else {
            if let title = title {
                let titleLbl = UILabel()
                titleLbl.text = title
                titleLbl.textColor = .white
                titleLbl.font = FontStyle.poppinsSemiBold(size: 36).font
                let customItem = UIBarButtonItem(customView: titleLbl)
                self.navigationItem.leftBarButtonItem = customItem
            }
        }
        
        if let rightBarButton = rightBarButton {
            self.navigationItem.rightBarButtonItem = rightBarButton
            rightBarButton.tintColor = .white
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }

}
