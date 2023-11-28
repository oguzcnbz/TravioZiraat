import UIKit
import TinyConstraints
import SnapKit
import Kingfisher


class EditProfileVC: UIViewController{
    
    //MARK: -- Properties
    lazy var editProfilViewModel: EditProfileViewModel = {
        return EditProfileViewModel()
    }()
    
    var profilModel:ProfileModel?
    var isImageChanged = false
    weak var delegate: PreviousPageDelegate?
    
    //MARK: -- Views
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor =  ColorStyle.background.color
        sv.layer.cornerRadius = 80
        sv.layoutIfNeeded()
        sv.layer.maskedCorners = [.layerMinXMinYCorner]
        return sv
    }()
    
    private lazy var containerView:UIView = {
        let v = UIView()
        v.backgroundColor = ColorStyle.background.color
        v.clipsToBounds = true
        v.layer.cornerRadius = 80
        v.layer.maskedCorners = [.layerMinXMinYCorner]
        return v
    }()
    
    private lazy var usernameStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Fullname", textFieldPlaceholder: "bilge_adam")
        return sv
    }()
    
    private lazy var emailStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Email", textFieldPlaceholder: "developer@bilgeadam.com")
        return sv
    }()
    
    let profileImageViewWidth: CGFloat = 120
    private lazy var photoView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "DefaultProfileImage")!.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = profileImageViewWidth / 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.h3.font
        return lbl
    }()
    
    private lazy var editProfileBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Photo", for: .normal)
        btn.titleLabel?.font = FontStyle.lt3.font
        btn.setTitleColor(ColorStyle.blueRaspberry.color, for: .normal)
        btn.addTarget(self, action: #selector(changePhotofunc), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        return btn
    }()
    
    private lazy var dateStackView: UIStackView = CsStackView()
    
    private lazy var icEdit:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icEditDate")
        return img
    }()
    
    private lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.sh3.font
        return lbl
    }()
    
    private lazy var userTypeStackView: UIStackView = CsStackView()
    
    private lazy var icAdmin:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icAdmin")
        return img
    }()
    
    private lazy var userTypeLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.sh3.font
        return lbl
    }()
    
    private lazy var buttonSave: DefaultButton = {
        let btn = DefaultButton(title: "Save", background: .primary)
        btn.addTarget(self, action: #selector(btnProfilTapped), for: .touchUpInside)
        return btn
    }()
   

    
    //MARK: -- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfilData()
        setupViews()
       
    }
    
    //MARK: -- Component Actions
    @objc func rightbartapped(){
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func changePhotofunc(){
        showChooseSourceTypeAlertController()
       
        
    }
    @objc func btnProfilTapped() {
        
        var message:String?
        let defaultProfileImage = UIImage(named: "DefaultProfileImage")!.withRenderingMode(.alwaysOriginal)

        if photoView.image == defaultProfileImage{
            message = "Please upload photo"
        }else if !emailStackView.defaultTextField.hasText{
            message = "Please enter Email"
        }else if !usernameStackView.defaultTextField.hasText {
            message = "Please enter Fullname"
        }
        
        if  usernameStackView.defaultTextField.hasText,emailStackView.defaultTextField.hasText,photoView.image != defaultProfileImage {
            //showLoadingIndicator()
            if isImageChanged == true{
                
                editProfilViewModel.profileUploadImage(profileImg: self.photoView.image!,
                                                       full_name: usernameStackView.defaultTextField.text ?? "",
                                                       email: emailStackView.defaultTextField.text ?? "",
                                                       pp_url: "") { success in
                    if success {
                        self.dismiss(animated: true, completion: {
                            self.delegate?.didDismiss()
                        })
                    } else {
                        print("Profile upload failed")
                    }
                }
            }
            else {
                editProfilViewModel.changeProfile(full_name: usernameStackView.defaultTextField.text ?? "",
                                                  email: emailStackView.defaultTextField.text ?? "",
                                                  pp_url: self.profilModel?.ppURL ?? ""){ success in
                    
                    if success {
                        self.dismiss(animated: true, completion: {
                            self.delegate?.didDismiss()
                        })
                    } else {
                        print("Profile upload failed")
                    }
                }
            }
        }else{
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            }))
           
            present(alert, animated: true, completion: nil)
        }
        
        }
        
        
    //MARK: -- Private Methods
    
    private func getProfilData(){
        
        editProfilViewModel.getProfilData()
        editProfilViewModel.transferProfilData = {  [weak self] () in
            let obj = self?.editProfilViewModel.profilModel
            self?.profilModel = obj

            self?.nameLbl.text = self?.profilModel?.fullName ?? ""
            self?.usernameStackView.defaultTextField.text = self?.profilModel?.fullName
            self?.emailStackView.defaultTextField.text = self?.profilModel?.email
            if self?.profilModel?.ppURL?.count ?? 0 > 1{
                
                let url = URL(string: self?.profilModel?.ppURL ?? "")
                
                self?.photoView.kf.setImage(with: url)
                
            }
           
            self?.dateLbl.text = self?.profilModel?.createdAt ?? ""
            self?.userTypeLbl.text = self?.profilModel?.role ?? ""
        }
    }
    
    func showControlAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
            self.dismiss(animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: -- UI Methods
    func setupViews() {
       
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubviews(photoView,nameLbl,editProfileBtn,dateStackView,userTypeStackView, usernameStackView,emailStackView,buttonSave)
        dateStackView.addSubviews(icEdit,dateLbl)
        userTypeStackView.addSubviews(icAdmin,userTypeLbl)
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(rightbartapped))
        setNavigationItems(leftBarButton: false, rightBarButton: rightBarButton, title: "Edit Profile")
        setupLayout()
    }
    
    func setupLayout() {
        
        scrollView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
           }
        containerView.snp.makeConstraints { v in
            v.width.equalToSuperview()
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.top.equalToSuperview()
                  v.height.equalTo(700)
        }
        
        photoView.snp.makeConstraints({imgv in
            imgv.top.equalToSuperview().offset(24)
            imgv.centerX.equalToSuperview()
            imgv.width.equalTo(profileImageViewWidth)
            imgv.height.equalTo(profileImageViewWidth)
            
        })
        editProfileBtn.snp.makeConstraints({btn in
            btn.top.equalTo(photoView.snp.bottom).offset(8)
          
            btn.centerX.equalToSuperview()
        })
        
        nameLbl.snp.makeConstraints({lbl in
            lbl.top.equalTo(editProfileBtn.snp.bottom)
        
            lbl.centerX.equalToSuperview()
        })
        dateStackView.snp.makeConstraints { v in
            v.top.equalTo(nameLbl.snp.bottom).offset(30)
           
            v.leading.equalToSuperview().offset(24)
            v.width.equalTo(usernameStackView).multipliedBy(0.5).offset(-5)
            v.height.equalTo(52)
        }
        icEdit.snp.makeConstraints({imgv in
            imgv.leading.equalToSuperview().offset(16)
            imgv.top.equalToSuperview().offset(18)
            imgv.bottom.equalToSuperview().offset(-16)
            imgv.width.equalTo(20)
            
            
        })
        dateLbl.snp.makeConstraints({lbl in
            lbl.leading.equalTo(icEdit.snp.trailing).offset(8)
            lbl.top.equalToSuperview().offset(16)
            lbl.bottom.equalToSuperview().offset(-16)
            lbl.trailing.equalToSuperview().offset(5)
            
        })
        
        userTypeStackView.snp.makeConstraints { v in
            v.top.equalTo(nameLbl.snp.bottom).offset(30)
            v.leading.equalTo(dateStackView.snp.trailing).offset(10)
            v.width.equalTo(usernameStackView).multipliedBy(0.5).offset(-5)
            v.height.equalTo(52)
        }
        
        icAdmin.snp.makeConstraints({imgv in
            imgv.leading.equalToSuperview().offset(16)
            imgv.top.equalToSuperview().offset(16)
            imgv.bottom.equalToSuperview().offset(-16)
        })
        
        userTypeLbl.snp.makeConstraints({lbl in
            lbl.leading.equalTo(icAdmin.snp.trailing).offset(10)
            lbl.top.equalToSuperview().offset(16)
            lbl.bottom.equalToSuperview().offset(-16)
            lbl.trailing.equalToSuperview().offset(5)
        })
    
        usernameStackView.snp.makeConstraints { v in
            v.top.equalTo(dateStackView.snp.bottom).offset(20)
            v.trailing.equalToSuperview().offset(-24)
            v.leading.equalToSuperview().offset(24)
            v.height.equalTo(74)
        }
        
        emailStackView.snp.makeConstraints { v in
            v.top.equalTo(usernameStackView.snp.bottom).offset(15)
            v.trailing.equalToSuperview().offset(-24)
            v.leading.equalToSuperview().offset(24)
            v.height.equalTo(74)
        }
        
        buttonSave.snp.makeConstraints { v in
            v.trailing.equalToSuperview().offset(-24)
            v.leading.equalToSuperview().offset(24)
            v.height.equalTo(54)
            v.top.equalTo(emailStackView.snp.bottom).offset(100)
        }
    }
}

extension EditProfileVC {
    private func CsTxtLabel(title:String) ->UILabel{
        let l = UILabel()
        l.numberOfLines = 0
        l.text = title
        l.height(24)
        return l
    }
    private func CsStackView() -> UIStackView{
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = ColorStyle.white.color
        stack.layer.cornerRadius = 16
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.shadowOpacity = 0.15
        stack.layer.shadowRadius = 20
        return stack
    }
    
}

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showChooseSourceTypeAlertController() {
        let vcSS = SecuritySettingsVC()
        
        let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
            if vcSS.libraryPermissionStatus == .authorized {
                self.showImagePickerController(sourceType: .photoLibrary)
                
            }else{
                self.showControlAlert(title: "Error", message: "You have not granted access to the library. You can change it from the settings.")
            }
        }
       
        let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
            if vcSS.cameraPermissionStatus == .authorized {
                self.showImagePickerController(sourceType: .camera)
                
            }else{
                self.showControlAlert(title: "Error", message: "You have not granted access to the camera. You can change it from the settings.")
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
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoView.image = editedImage.withRenderingMode(.alwaysOriginal)
         isImageChanged = true
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoView.image = originalImage.withRenderingMode(.alwaysOriginal)
        }
        dismiss(animated: true, completion: nil)
    }
}


