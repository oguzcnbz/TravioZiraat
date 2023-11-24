import UIKit
import SnapKit
import TinyConstraints
import IQKeyboardManagerSwift

class SignUpVC: UIViewController,SignUpResponseDelegate {
    
    func signUpResponseGet(isSignUp: Bool, message: String) {
            
            if isSignUp == false {
                                    showAlert(title: "Registration Failed", message: message)
            }
            if isSignUp == true {
                
                let vc = MainTabbar()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

    
    func showAlert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnCancel = UIAlertAction(title: "Vazgeç", style: .destructive)
        alert.addAction(btnCancel)
        self.present(alert, animated: true)
    }
    
    //MARK: -- Views
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var usernameStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Username", textFieldPlaceholder: "bilge_adam")
        return sv
    }()
    
    private lazy var emailStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Email", textFieldPlaceholder: "developer@bilgeadam.com")
        return sv
    }()
    
    private lazy var passwordStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Password", textFieldPlaceholder: "")
        sv.defaultTextField.isSecureTextEntry = true
        return sv
    }()
    
    private lazy var passwordConfirmStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Password Confirm", textFieldPlaceholder: "")
        sv.defaultTextField.isSecureTextEntry = true
        return sv
    }()
    
    private lazy var passwordShowToggle: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName:"eye.slash"), for: .normal)
        btn.tintColor = ColorStyle.primary.color
        btn.addTarget(self, action: #selector(startShowingPassword), for: .touchDown)
        btn.addTarget(self, action: #selector(stopShowingPassword), for: .touchUpInside)
        btn.addTarget(self, action: #selector(stopShowingPassword), for: .touchUpOutside)
        return btn
    }()

    
    @objc private func startShowingPassword() {
        passwordShowToggle.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordStackView.defaultTextField.isSecureTextEntry = false
    }

    @objc private func stopShowingPassword() {
        passwordShowToggle.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordStackView.defaultTextField.isSecureTextEntry = true

    }
    
    private lazy var passwordConfirmShowToggle: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName:"eye.slash"), for: .normal)
        btn.tintColor = ColorStyle.primary.color
        btn.addTarget(self, action: #selector(startShowPassword), for: .touchDown)
        btn.addTarget(self, action: #selector(stopShowPassword), for: .touchUpInside)
        btn.addTarget(self, action: #selector(stopShowPassword), for: .touchUpOutside)
        return btn
    }()

    
    @objc private func startShowPassword() {
        passwordShowToggle.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordConfirmStackView.defaultTextField.isSecureTextEntry = false
    }

    @objc private func stopShowPassword() {
        passwordShowToggle.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordConfirmStackView.defaultTextField.isSecureTextEntry = true

    }
    
    lazy var SignUpViewModel: SignUpViewModel = {
        return Application.SignUpViewModel()
    }()
    
    //MARK: -- Labels
    
    private lazy var lblSignUp: UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorStyle.white.color
        lbl.text = "Sign Up"
        lbl.font = FontStyle.h1.font
        lbl.sizeToFit()
        return lbl
    }()
    
    //MARK: -- Buttons
    
    private lazy var buttonLogin: DefaultButton = {
        let btn = DefaultButton(title: "Sign Up", background: .greySpanish)
        btn.addTarget(self, action: #selector(btnSignTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func btnSignTapped() {
        SignUpViewModel.setDelegate(output: self)
        SignUpViewModel.signUpUser(fullName: usernameStackView.defaultTextField.text, email: emailStackView.defaultTextField.text, password: passwordStackView.defaultTextField.text)
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -- Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupSignUpButton()
    }
    
    //MARK: -- SetUpView
    
    private func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubview(mainStackView)
        mainStackView.addSubviews(usernameStackView,
                                  emailStackView,
                                  passwordStackView,
                                  passwordConfirmStackView,
                                  buttonLogin)
        
        passwordStackView.addSubview(passwordShowToggle)
        passwordConfirmStackView.addSubview(passwordConfirmShowToggle)
        
        let leftButtonImage = UIImage(named:"backWard")
        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = ColorStyle.white.color
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.titleView = lblSignUp
        layout()
    }
    
    //MARK: -- Layout
    
    private func layout() {
        
        mainStackView.snp.makeConstraints { v in
            v.centerX.equalToSuperview()
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
        
        usernameStackView.snp.makeConstraints { v in
            v.top.equalTo(mainStackView.snp.top).offset(72)
            v.trailing.equalToSuperview().offset(-24)
            v.leading.equalToSuperview().offset(24)
            v.height.equalTo(74)
        }
        
        
        emailStackView.snp.makeConstraints { sv in
            sv.top.equalTo(usernameStackView.snp.bottom).offset(24)
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
        
        passwordConfirmStackView.snp.makeConstraints { sv in
            sv.top.equalTo(passwordStackView.snp.bottom).offset(24)
            sv.trailing.equalToSuperview().offset(-24)
            sv.leading.equalToSuperview().offset(24)
            sv.height.equalTo(74)
        }
        
        passwordShowToggle.snp.makeConstraints({tgl in
            tgl.centerY.equalTo(passwordStackView.defaultTextField)
            tgl.trailing.equalToSuperview().offset(-16)
            tgl.height.equalTo(24)
            tgl.width.equalTo(24)
        })
        
        passwordConfirmShowToggle.snp.makeConstraints({tgl in
            tgl.centerY.equalTo(passwordConfirmStackView.defaultTextField)
            tgl.trailing.equalToSuperview().offset(-16)
            tgl.height.equalTo(24)
            tgl.width.equalTo(24)
        })
        
        
        buttonLogin.snp.makeConstraints { btn in
            btn.bottom.equalTo(mainStackView.snp.bottom).offset(-23)
            btn.trailing.equalToSuperview().offset(-24)
            btn.leading.equalToSuperview().offset(24)
            btn.height.equalTo(54)
        }
    }
}


//MARK: -- Extensions

extension SignUpVC {
    func setupSignUpButton() {
        
        let textFields = [usernameStackView.defaultTextField, emailStackView.defaultTextField, passwordStackView.defaultTextField, passwordConfirmStackView.defaultTextField]
        textFields.forEach {
            $0.addTarget(self, action: #selector(updateSignUpButtonState), for: .editingChanged)
        }
        updateSignUpButtonState()
    }
    
    @objc func updateSignUpButtonState() {
        let isPasswordValid = passwordStackView.defaultTextField.text?.count ?? 0 >= 6
        let isPasswordConfirmed = passwordStackView.defaultTextField.text == passwordConfirmStackView.defaultTextField.text
        let isAllFieldsFilled = usernameStackView.defaultTextField.hasText && emailStackView.defaultTextField.hasText && passwordStackView.defaultTextField.hasText && passwordConfirmStackView.defaultTextField.hasText
        
        if isAllFieldsFilled && isPasswordValid && isPasswordConfirmed == true{
            buttonLogin.isEnabled = true
            buttonLogin.backgroundColor = ColorStyle.primary.color
        }else {
            buttonLogin.backgroundColor = ColorStyle.greySpanish.color
        }
    }
}
