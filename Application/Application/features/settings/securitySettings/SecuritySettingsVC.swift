
import UIKit
import TinyConstraints
import SnapKit
import AVFoundation
import Photos
import CoreLocation

class SecuritySettingsVC: UIViewController {
    
    private lazy var mainStackView:DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var changePassLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsSemiBold(size: 16).font
        lbl.text = "Change Password"
        lbl.textColor = UIColor(hex: "38ada9")
        return lbl
    }()
    
    private lazy var privacyLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsSemiBold(size: 16).font
        lbl.text = "Privacy"
        lbl.textColor = UIColor(hex: "38ada9")
        return lbl
    }()
    
    private lazy var newPassTxtField:CustomTextField = {
        let tf = CustomTextField(labelText: "New Password", textFieldPlaceholder: "")
        return tf
    }()
    
    private lazy var newPassConfTxtField:CustomTextField = {
        let tf = CustomTextField(labelText: "New Password Confirm", textFieldPlaceholder: "")
        return tf
    }()
    
    private lazy var cameraSV:SecuritySettingsCustomSV = {
        let sv = SecuritySettingsCustomSV(labelText: "Camera", toggleSwitchChangedOnHandler: nil , toggleSwitchChangedOffHandler:nil )
        return sv
    }()
    
    private lazy var librarySV:SecuritySettingsCustomSV = {
        let sv = SecuritySettingsCustomSV(labelText: "Library"
                                          , toggleSwitchChangedOnHandler:nil , toggleSwitchChangedOffHandler: nil)
        return sv
    }()
    private lazy var locationSV:SecuritySettingsCustomSV = {
        let sv = SecuritySettingsCustomSV(labelText: "Location", toggleSwitchChangedOnHandler:nil , toggleSwitchChangedOffHandler:nil )
        return sv
    }()
    
    private lazy var saveButton:DefaultButton = {
        let btn = DefaultButton(title: "Save", background: .customgreen)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupViews()
       
    }

    
    func setupViews() {
        self.view.backgroundColor = UIColor(hex: "38ada9")
        self.view.addSubview(mainStackView)
        mainStackView.addSubviews(changePassLbl,newPassTxtField,newPassConfTxtField,privacyLbl,cameraSV,librarySV,locationSV,saveButton)
        setupLayout()
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: "Security Settings")
    }
    
    func setupLayout() {
        
        mainStackView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
        
        changePassLbl.snp.makeConstraints({lbl in
            lbl.top.equalToSuperview().offset(44)
            lbl.leading.equalToSuperview().offset(24)
            lbl.trailing.equalToSuperview().offset(-24)
            lbl.height.equalTo(21)
        })
        
        newPassTxtField.snp.makeConstraints({tf in
            tf.top.equalTo(changePassLbl.snp.bottom).offset(8)
            tf.leading.equalToSuperview().offset(24)
            tf.trailing.equalToSuperview().offset(-24)
            tf.height.equalTo(74)
        })
        
        newPassConfTxtField.snp.makeConstraints({tf in
            tf.top.equalTo(newPassTxtField.snp.bottom).offset(8)
            tf.leading.equalToSuperview().offset(24)
            tf.trailing.equalToSuperview().offset(-24)
            tf.height.equalTo(74)
        })
        
        privacyLbl.snp.makeConstraints({lbl in
            lbl.top.equalTo(newPassConfTxtField.snp.bottom).offset(24)
            lbl.leading.equalToSuperview().offset(24)
            lbl.trailing.equalToSuperview().offset(-24)
            lbl.height.equalTo(21)
        })
        
        cameraSV.snp.makeConstraints({sv in
            sv.top.equalTo(privacyLbl.snp.bottom).offset(8)
            sv.leading.equalToSuperview().offset(24)
            sv.trailing.equalToSuperview().offset(-24)
            sv.height.equalTo(74)
        })
        
        librarySV.snp.makeConstraints({sv in
            sv.top.equalTo(cameraSV.snp.bottom).offset(8.51)
            sv.leading.equalToSuperview().offset(24)
            sv.trailing.equalToSuperview().offset(-24)
            sv.height.equalTo(74)
        })
        
        locationSV.snp.makeConstraints({sv in
            sv.top.equalTo(librarySV.snp.bottom).offset(8.51)
            sv.leading.equalToSuperview().offset(24)
            sv.trailing.equalToSuperview().offset(-24)
            sv.height.equalTo(74)
        })
        
        saveButton.snp.makeConstraints({btn in
            btn.bottom.equalToSuperview().offset(-18)
            btn.leading.equalToSuperview().offset(24)
            btn.trailing.equalToSuperview().offset(-24)
            btn.height.equalTo(54)
        })
       
    }
  
}

//extension SecuritySettingsVC {
//
//
//
//        // Function to request camera access
//        func requestCameraAccess() {
//            AVCaptureDevice.requestAccess(for: .video) { granted in
//                if granted {
//                    // Camera access granted, you can update UI or perform any other action
//                    print("Camera access granted")
//                } else {
//                    // Camera access denied, navigate to settings
//                    self.navigateToSettings()
//                }
//            }
//        }
//
//        // Function to revoke camera access
//        func revokeCameraAccess() {
//            let status = AVCaptureDevice.authorizationStatus(for: .video)
//            if status == .authorized {
//                // Camera access was previously granted, so we can revoke it now
//                AVCaptureDevice.requestAccess(for: .video) { granted in
//                    if !granted {
//                        // Camera access revoked, navigate to settings
//                        self.navigateToSettings()
//                    }
//                }
//            }
//        }
//
//        // Function to navigate to the app settings
//        func navigateToSettings() {
//            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
//                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
//            }
//        }
//
//}
