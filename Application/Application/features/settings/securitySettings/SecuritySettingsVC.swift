import UIKit
import TinyConstraints
import SnapKit
import AVFoundation
import Photos
import CoreLocation


class SecuritySettingsVC: UIViewController {
    
    //MARK: -- Properties
    
    var cameraPermissionStatus = AVCaptureDevice.authorizationStatus(for: .video)
    var libraryPermissionStatus = PHPhotoLibrary.authorizationStatus()
    var locationPermissionStatus: CLAuthorizationStatus = .notDetermined
    
    private lazy var locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.delegate = self
        return location
    }()
    
    lazy var securitySettingsViewModel: SecuritySettingsViewModel = SecuritySettingsViewModel()
    
    //MARK: -- Components
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor =  ColorStyle.background.color
        sv.layer.cornerRadius = 80
        sv.layoutIfNeeded()
        sv.layer.maskedCorners = [.layerMinXMinYCorner]
        return sv
    }()
    
    private lazy var mainStackView:DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var changePassLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.h5.font
        lbl.text = "Change Password"
        lbl.textColor = ColorStyle.primary.color
        return lbl
    }()
    
    private lazy var privacyLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.h5.font
        lbl.text = "Privacy"
        lbl.textColor = ColorStyle.primary.color
        return lbl
    }()
    
    private lazy var newPassTxtField:CustomPasswordTextField = {
        let tf = CustomPasswordTextField(labelText: "New Password", textFieldPlaceholder: "********")
        
        return tf
    }()
    
    private lazy var newPassConfTxtField:CustomPasswordTextField = {
        let tf = CustomPasswordTextField(labelText: "New Password Confirm", textFieldPlaceholder: "********")
        tf.defaultTextField.isSecureTextEntry = true
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
        let btn = DefaultButton(title: "Save", background: .primary)
        btn.addTarget(self, action: #selector(btnSaveTapped), for: .touchUpInside)
        return btn
    }()
    
    //MARK: -- Components Actions
    
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
        let isPasswordValid = newPassTxtField.defaultTextField.text?.count ?? 0 >= 6
        let isPasswordConfirmed = newPassTxtField.defaultTextField.text == newPassConfTxtField.defaultTextField.text
        if isPasswordValid && isPasswordConfirmed == true{
            showLoadingIndicator()
            guard let newPassword = newPassTxtField.defaultTextField.text else {return}
            securitySettingsViewModel.passwordChange(changedPassword: newPassword)
            showResult()
            
        }else if isPasswordValid == false{
            
            let alert = UIAlertController(title: "Error", message: "Password must be at least 6 characters", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
                self.dismiss(animated: true)
            }))
            present(alert, animated: true, completion: nil)
            
        }else if isPasswordConfirmed == false{
            
            let alert = UIAlertController(title: "Error", message: "Password and password confirmation password does not match", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
                self.dismiss(animated: true)
            }))
            present(alert, animated: true, completion: nil)
        }
        hideLoadingIndicator()
    }
    
    //MARK: -- Private Methods
    
    func showResult(){
        securitySettingsViewModel.showAlertClosure = {message in
            self.resultAlert(title: message.0, message: message.1)
        }
    }
    
    //MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkPermissionStatus()
    }
    
    //MARK: -- Setup
    
    func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubviews(changePassLbl,newPassTxtField,newPassConfTxtField,privacyLbl,cameraSV,librarySV,locationSV,saveButton)
        
        setupLayout()
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: "Security Settings")
    }
    
    //MARK: -- Layout
    
    func setupLayout() {
        
        scrollView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
        
        mainStackView.snp.makeConstraints { v in
            v.width.equalToSuperview()
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.top.equalToSuperview()
            v.height.equalTo(760)
            
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
            sv.top.equalTo(cameraSV.snp.bottom).offset(9)
            sv.leading.equalToSuperview().offset(24)
            sv.trailing.equalToSuperview().offset(-24)
            sv.height.equalTo(74)
        })
        
        locationSV.snp.makeConstraints({sv in
            sv.top.equalTo(librarySV.snp.bottom).offset(9)
            sv.leading.equalToSuperview().offset(24)
            sv.trailing.equalToSuperview().offset(-24)
            sv.height.equalTo(74)
        })
        
        saveButton.snp.makeConstraints({btn in
            btn.leading.equalToSuperview().offset(24)
            btn.trailing.equalToSuperview().offset(-24)
            btn.height.equalTo(54)
            btn.top.equalTo(locationSV.snp.bottom).offset(124)
        })
        
    }
}

//MARK: -- Extensions

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
                    self.cameraSV.toggleSwitch.isOn = true
                }else{
                    self.cameraSV.toggleSwitch.isOn = false
                }
            }
        @unknown default:
            break
        }
    }
    
    func requestLibraryPermission() {
        
        switch libraryPermissionStatus {
        case .authorized,.limited:
            self.librarySV.toggleSwitch.isOn = true
        case .denied, .restricted:
            showPermissionAlert(title: "Library Permission Required", message: "Please enable access to your photo library in settings to use this feature.", toggleSender: librarySV.toggleSwitch)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        self.librarySV.toggleSwitch.isOn = true
                    } else {
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

extension SecuritySettingsVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationPermissionStatus = status
    }
}
