import UIKit
import SnapKit
import TinyConstraints


class LoginVC: UIViewController,LoginResponseDelegate {
    
    //MARK: -- Properties
    
    private lazy var securitySettings: SecuritySettingsVC = {
        return SecuritySettingsVC()
    }()
    
    //MARK: -- Components
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var emailStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Email", textFieldPlaceholder: "developer@bilgeadam.com")
        return sv
    }()
    
    private lazy var passwordStackView: CustomPasswordTextField = {
        let sv = CustomPasswordTextField(labelText: "Password", textFieldPlaceholder: "************")
        sv.defaultTextField.isSecureTextEntry = true
        return sv
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Travio")
        return imageView
    }()
    
    lazy var loginViewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    
    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome to Travio"
        lbl.font = FontStyle.h4.font
        lbl.textColor = ColorStyle.blackRaven.color
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var lblCheckSign: UILabel = {
        let lbl = UILabel()
        lbl.text = "Don’t have  any account?"
        lbl.font = FontStyle.h6.font
        lbl.textColor = ColorStyle.blackRaven.color
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var buttonLogin: DefaultButton = {
        let btn = DefaultButton(title: "Login", background: .primary)
        btn.addTarget(self, action: #selector(btnLoginTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = FontStyle.h6.font
        button.addTarget(self, action: #selector(btnSignTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: -- Components Actions
    
    @objc func btnLoginTapped() {
        guard let email = emailStackView.defaultTextField.text else {return}
        guard let password = passwordStackView.defaultTextField.text else {return}
        showLoadingIndicator()
        loginViewModel.setDelegate(output: self)
        loginViewModel.loginUser(email: email, password: password)
    }
    
    @objc func btnSignTapped() {
        let SignUpVC = SignUpVC()
        SignUpVC.onCompletion = { email, password in
            self.loginViewModel.setDelegate(output: self)
            self.loginViewModel.loginUser(email: email, password: password)
                }
        self.navigationController?.pushViewController(SignUpVC, animated: true)
    }
    
    //MARK: -- Private Methods
    
    func loginResponseGet(isLogin: Bool, message:String) {
        hideLoadingIndicator()
        if isLogin == false {
            showAlert(title: "Can't Login",message: message)
            
        }
        if isLogin == true{
            let vc = MainTabbar()
            self.navigationController?.pushViewController(vc, animated: true)
            securitySettings.requestCameraPermission()
            securitySettings.requestLibraryPermission()
            securitySettings.requestLocationPermission()
            hideLoadingIndicator()
        }
        
    }
    
    func showAlert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnCancel = UIAlertAction(title: "Ok", style: .default)
       
        
        alert.addAction(btnCancel)
        self.present(alert, animated: true)
    }
    
    //MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupViews()
        
    }
    
    //MARK: -- Setup
    
    private func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubviews(imageView,
                              mainStackView)
        
        mainStackView.addSubviews(lblTitle,
                                  emailStackView,
                                  passwordStackView,
                                  buttonLogin,
                                  bottomStackView)
        
        bottomStackView.addArrangedSubviews(lblCheckSign,
                                            signButton)
        layout()
    }
    
    //MARK: -- Layout
    
    private func layout() {
        
        imageView.snp.makeConstraints { imgv in
            imgv.centerX.equalToSuperview()
            imgv.bottom.equalTo(mainStackView.snp.top).offset(-24)
            imgv.height.equalToSuperview().multipliedBy(0.213)
            imgv.width.equalToSuperview().multipliedBy(0.384)
            
        }
        
        mainStackView.snp.makeConstraints { sv in
            sv.leading.equalToSuperview()
            sv.trailing.equalToSuperview()
            sv.bottom.equalToSuperview()
            sv.height.equalToSuperview().multipliedBy(0.7)
        }
        
        lblTitle.snp.makeConstraints { lbl in
            lbl.top.equalTo(mainStackView.snp.top).offset(64)
            lbl.centerX.equalToSuperview()
            lbl.height.equalTo(36)
        }
        
        emailStackView.snp.makeConstraints { sv in
            sv.top.equalTo(lblTitle.snp.bottom).offset(44)
            sv.trailing.equalToSuperview().offset(-24)
            sv.leading.equalToSuperview().offset(24)
            sv.height.equalTo(74)
        }
        passwordStackView.snp.makeConstraints { sv in
            sv.top.equalTo(emailStackView.snp.bottom).offset(24)
            sv.trailing.equalToSuperview().offset(-24)
            sv.leading.equalToSuperview().offset(24)
            sv.height.equalTo(74)
        }
        
        buttonLogin.snp.makeConstraints { btn in
            btn.top.equalTo(passwordStackView.snp.bottom).offset(48)
            btn.trailing.equalToSuperview().offset(-24)
            btn.leading.equalToSuperview().offset(24)
            btn.height.equalTo(54)
        }
        
        bottomStackView.snp.makeConstraints({sv in
            sv.centerX.equalToSuperview()
            sv.bottom.equalTo(mainStackView.snp.bottom).offset(-24)
            
        })
    }
}

