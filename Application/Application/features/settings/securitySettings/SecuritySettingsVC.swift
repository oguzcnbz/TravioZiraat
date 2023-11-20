
import UIKit
import TinyConstraints
import SnapKit
import AVFoundation
import Photos
import CoreLocation

class SecuritySettingsVC: UIViewController {
    
    var cameraPermissionStatus = AVCaptureDevice.authorizationStatus(for: .video)
    var libraryPermissionStatus = PHPhotoLibrary.authorizationStatus()
    var locationPermissionStatus = CLLocationManager.authorizationStatus()

    private lazy var locationManager:CLLocationManager = {
        let location = CLLocationManager()
        return location
    }()
    
    lazy var securitySettingsViewModel: SecuritySettingsViewModel = SecuritySettingsViewModel()
    
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
        let sv = SecuritySettingsCustomSV(labelText: "Camera")
        sv.toggleSwitch.addTarget(self, action: #selector(cameraChanged), for: .valueChanged)
        return sv
    }()
    
    private lazy var librarySV:SecuritySettingsCustomSV = {
        let sv = SecuritySettingsCustomSV(labelText: "Library")
        sv.toggleSwitch.addTarget(self, action: #selector(libraryChanged), for: .valueChanged)
        return sv
    }()
    private lazy var locationSV:SecuritySettingsCustomSV = {
        let sv = SecuritySettingsCustomSV(labelText: "Location")
        sv.toggleSwitch.addTarget(self, action: #selector(locationChanged), for: .valueChanged)
        return sv
    }()
    
    private lazy var saveButton:DefaultButton = {
        let btn = DefaultButton(title: "Save", background: .customgreen)
        btn.addTarget(self, action: #selector(btnSaveTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func cameraChanged(_ sender: UISwitch){
        if sender.isOn {
            requestCameraPermission()
        }else{
            showPermissionAlert(title: "Camera Access Denied", message: "Please enable access to your camera in Settings",toggleSender: cameraSV.toggleSwitch)
        }
    }
    
    @objc func libraryChanged(sender: UISwitch){
        if sender .isOn {
            requestLibraryPermission()
        }else{
            showPermissionAlert(title: "Photo Library Access Denied", message: "Please enable access to your photo library in Settings.",toggleSender: librarySV.toggleSwitch)
        }
    }
    
    @objc func locationChanged(sender: UISwitch){
        if sender .isOn {
            requestLocationPermission()
        }else{
            showPermissionAlert(title: "Location Access Denied", message: "Please enable access to your location in Settings.",toggleSender: locationSV.toggleSwitch)
        }
    }
    
    @objc func btnSaveTapped() {
        guard let newPassword = newPassTxtField.defaultTextField.text else {return}
        securitySettingsViewModel.passwordChange(changedPassword: newPassword)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkPermissionStatus()
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

extension SecuritySettingsVC {
    
     func requestCameraPermission() {
       
        switch cameraPermissionStatus {
        case .authorized:
            self.cameraSV.toggleSwitch.isOn = true
        case .denied, .restricted:
            showPermissionAlert(title: "Camera Permission Required", message: "Please enable camera access in settings to use this feature.", toggleSender: cameraSV.toggleSwitch)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted{
                    print("Kamera izni verildi.")
                    self.cameraSV.toggleSwitch.isOn = true
                }else{
                    print("Kamera izni reddedildi.")
                    self.cameraSV.toggleSwitch.isOn = false
                }
            }
        @unknown default:
            break
        }
    }
    
    
     func requestLibraryPermission() {
       
        switch libraryPermissionStatus {
        case .authorized:
            self.librarySV.toggleSwitch.isOn = true
        case .denied, .restricted:
            showPermissionAlert(title: "Library Permission Required", message: "Please enable access to your photo library in settings to use this feature.", toggleSender: librarySV.toggleSwitch)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        print("Library izni verildi.")
                        self.librarySV.toggleSwitch.isOn = true
                    } else {
                        print("Library izni reddedildi.")
                        self.librarySV.toggleSwitch.isOn = false
                    }
                }
            }
        @unknown default:
            break
        }
    }
   
   
    
     func requestLocationPermission() {
           
            switch locationPermissionStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationSV.toggleSwitch.isOn = true
            case .denied, .restricted:
                showPermissionAlert(title: "Location Permission Required", message: "Please enable access to your location in settings to use this feature.", toggleSender: locationSV.toggleSwitch)
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            @unknown default:
                break
            }
        }
    
     func showPermissionAlert(title: String, message: String, toggleSender: UISwitch) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            if toggleSender.isOn == false {
                toggleSender.isOn = true
            }else{
                toggleSender.isOn = false
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }


  
         func checkPermissionStatus() {
            checkCameraPermissionStatus()
            checkLibraryPermissionStatus()
            checkLocationPermissionStatus()
        }

         func checkCameraPermissionStatus() {
            if cameraPermissionStatus == .authorized {
                cameraSV.toggleSwitch.isOn = true
            }else if cameraPermissionStatus  == .denied || cameraPermissionStatus  == .restricted {
                cameraSV.toggleSwitch.isOn = false
            }
        }

         func checkLibraryPermissionStatus() {
            if libraryPermissionStatus == .authorized {
                librarySV.toggleSwitch.isOn = true
            }else if libraryPermissionStatus  == .denied || libraryPermissionStatus  == .restricted {
                librarySV.toggleSwitch.isOn = false
            }
        }

         func checkLocationPermissionStatus() {
            if locationPermissionStatus == .authorizedAlways || locationPermissionStatus == .authorizedWhenInUse {
                locationSV.toggleSwitch.isOn = true
            }else if locationPermissionStatus  == .denied || locationPermissionStatus  == .restricted {
                librarySV.toggleSwitch.isOn = false
            }
        }

}
