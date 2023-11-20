
import UIKit
import SnapKit

class MapAddPlaceCell: UICollectionViewCell {
    
    weak var delegate: Deneme?
   // var imageArr:[UIImage] = []
    var closure:((UIImage)->Void)?
    var hasImage:Bool = false
    var indexRow:Int?
    
    
    private lazy var imgPlace:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var addPhotolbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Add Photo"
        lbl.font = FontStyle.poppinsLight(size: 12).font
        lbl.textColor = UIColor.lightGray
        return lbl
    }()
    
    private lazy var vector:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "camera")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
                self.contentView.addGestureRecognizer(tapGesture)
                self.contentView.isUserInteractionEnabled = true
        
    }
   
    @objc private func cellTapped() {
            // Add your desired action when the cell is tapped
            print("Cell tapped! \(indexRow)")
        showChooseSourceTypeAlertController()
        }
    
    
    
    
    private func setupViews(){
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 16
        
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.15
        self.contentView.layer.shadowRadius = 20
        
        self.contentView.addSubviews(imgPlace)
        
        imgPlace.addSubviews(vector,addPhotolbl)
        
        setupLayout()
    }
    
    private func  setupLayout(){
        imgPlace.snp.makeConstraints({ img in
            img.leading.equalToSuperview()
            img.trailing.equalToSuperview()
            img.top.equalToSuperview()
            img.bottom.equalToSuperview()
            
        })
        
        vector.snp.makeConstraints({img in
            img.centerX.equalTo(imgPlace)
            img.top.equalTo(imgPlace.snp.top).offset(79)
        })
        
        addPhotolbl.snp.makeConstraints({lbl in
            lbl.centerX.equalTo(imgPlace)
            lbl.top.equalTo(vector.snp.bottom).offset(5)
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension MapAddPlaceCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showChooseSourceTypeAlertController() {
        
        let vcSS = SecuritySettingsVC()
        
       
        let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
            if vcSS.libraryPermissionStatus == .authorized {
                self.showImagePickerController(sourceType: .photoLibrary)
                
            }else{
                self.delegate?.deneme(title: "Error", message: "You have not granted access to the library. You can change it from the settings.")
            }
        }
       
        let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
            if vcSS.cameraPermissionStatus == .authorized {
                self.showImagePickerController(sourceType: .camera)
                
            }else{
                self.delegate?.deneme(title: "Error", message: "You have not granted access to the camera. You can change it from the settings.")
            }
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: nil, message: nil, actions:[photoLibraryAction,cameraAction,cancelAction] , completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        UIViewController.topViewController()?.present(imagePickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imgPlace.image = editedImage.withRenderingMode(.alwaysOriginal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgPlace.image = originalImage.withRenderingMode(.alwaysOriginal)
            
        }
        self.addPhotolbl.text = ""
        self.vector.image = nil
        
        closure!(imgPlace.image!)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

extension UIViewController {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
