
import UIKit
import SnapKit
import TinyConstraints
import IQKeyboardManagerSwift

class SignUpVC: UIViewController,SignUpResponseDelegate {
    
    func signUpResponseGet(isSignUp: Bool, message: String) {
            
            if isSignUp == false {
                
                    print("hatali giris")
                    showAlert(title: "Registration Failed", message: message)
                
               
               
            }
            if isSignUp == true {
                
                
                let vc = HomeVC()
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
    
    private lazy var loginView: DefaultView = {
        let scene = DefaultView()
        return scene
    }()
    
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
        return sv
    }()
    
    private lazy var passwordConfirmStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Password Confirm", textFieldPlaceholder: "")
        return sv
    }()
    
    lazy var SignUpViewModel: SignUpViewModel = {
        return Application.SignUpViewModel()
    }()
    
    
    //MARK: -- Labels
    
    private lazy var lblSignUp: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hex: "FFFFFF")
        lbl.text = "Sign Up"
        lbl.font = FontStyle.poppinsSemiBold(size: 36).font
        lbl.sizeToFit()
        return lbl
    }()
    
    //MARK: -- Buttons
    
    private lazy var buttonLogin: DefaultButton = {
        let btn = DefaultButton(title: "Sign Up", background: .lightGray)
        btn.addTarget(self, action: #selector(btnSignTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    @objc func btnSignTapped() {
          guard let userName = usernameStackView.defaultTextField.text else {return}
        guard let email = emailStackView.defaultTextField.text else {return}
        guard let password = passwordStackView.defaultTextField.text else {return}
        
        if emailStackView.defaultTextField.hasValidEmail == false {
            showAlert(title: "Registration Failed", message: "Sorry, we dont recognise this email address")
            return
        }
        
        SignUpViewModel.setDelegate(output: self)
        SignUpViewModel.signUpUser(fullName: userName, email: email, password: password)
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
        self.view.addSubview(loginView)
        loginView.addSubviews(mainStackView)
        mainStackView.addSubviews(usernameStackView,
                                  emailStackView,
                                  passwordStackView,
                                  passwordConfirmStackView,
                                  buttonLogin)
        
        
        
        let leftButtonImage = UIImage(named:"backWard")
        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor(hex: "FFFFFF")
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.titleView = lblSignUp
        layout()
        
    }
    
    //MARK: -- Layout
    
    private func layout() {
        loginView.snp.makeConstraints { view in
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
            view.top.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.85)
        }
        
        usernameStackView.snp.makeConstraints { view in
            view.top.equalTo(mainStackView.snp.top).offset(72)
            view.trailing.equalToSuperview().offset(-24)
            view.leading.equalToSuperview().offset(24)
            view.height.equalTo(74)
        }
        
        
        emailStackView.snp.makeConstraints { view in
            view.top.equalTo(usernameStackView.snp.bottom).offset(24)
            view.trailing.equalToSuperview().offset(-24)
            view.leading.equalToSuperview().offset(24)
            view.height.equalTo(74)
        }
        
        passwordStackView.snp.makeConstraints { view in
            view.top.equalTo(emailStackView.snp.bottom).offset(24)
            view.trailing.equalToSuperview().offset(-24)
            view.leading.equalToSuperview().offset(24)
            view.height.equalTo(74)
        }
        
        passwordConfirmStackView.snp.makeConstraints { view in
            view.top.equalTo(passwordStackView.snp.bottom).offset(24)
            view.trailing.equalToSuperview().offset(-24)
            view.leading.equalToSuperview().offset(24)
            view.height.equalTo(74)
        }
        
        buttonLogin.snp.makeConstraints { btn in
            btn.top.equalTo(passwordConfirmStackView.snp.bottom).offset(202)
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
        
        buttonLogin.isEnabled = isPasswordValid && isPasswordConfirmed && isAllFieldsFilled
        
        if buttonLogin.isEnabled {
            buttonLogin.backgroundColor = ButtonBackground.customgreen.backgroundColor
        } else {
            buttonLogin.backgroundColor = ButtonBackground.lightGray.backgroundColor
        }
    }
}
