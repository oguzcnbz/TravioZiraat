import UIKit
import SnapKit
import TinyConstraints
import IQKeyboardManagerSwift

class SignUpVC: UIViewController,SignUpResponseDelegate {
    var onCompletion: ((String, String) -> Void)?
    
    //MARK: -- Components
    
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
    
    private lazy var passwordStackView: CustomPasswordTextField = {
        let sv = CustomPasswordTextField(labelText: "Password", textFieldPlaceholder: "")
        sv.defaultTextField.isSecureTextEntry = true
        
        return sv
    }()
    
    private lazy var passwordConfirmStackView: CustomPasswordTextField = {
        let sv = CustomPasswordTextField(labelText: "Password Confirm", textFieldPlaceholder: "")
        sv.defaultTextField.isSecureTextEntry = true
        
        return sv
    }()
    
    lazy var SignUpViewModel: SignUpViewModel = {
        return Application.SignUpViewModel()
    }()
    
    private lazy var lblSignUp: UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorStyle.white.color
        lbl.text = "Sign Up"
        lbl.font = FontStyle.h1.font
        lbl.sizeToFit()
        return lbl
    }()
    
    private lazy var buttonLogin: DefaultButton = {
        let btn = DefaultButton(title: "Sign Up", background: .greySpanish)
        btn.addTarget(self, action: #selector(btnSignTapped), for: .touchUpInside)
        return btn
    }()
    
    //MARK: -- Component Actions
    
    @objc func btnSignTapped() {
        if updateSignUpButtonState(){
           showLoadingIndicator()
            SignUpViewModel.setDelegate(output: self)
            SignUpViewModel.signUpUser(fullName: usernameStackView.defaultTextField.text, email: emailStackView.defaultTextField.text, password: passwordStackView.defaultTextField.text)
        }
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -- Private Methods
    
    func signUpResponseGet(isSignUp: Bool, message: String) {
       
       
        if isSignUp == false {
           
            hideLoadingIndicator()
            showAlert(title: "Registration Failed", message: message)
        }
        if isSignUp == true {

            
            onCompletion?(emailStackView.defaultTextField.text!, passwordStackView.defaultTextField.text!)
                  navigationController?.popViewController(animated: false)
           // let vc = MainTabbar()
           // self.navigationController?.pushViewController(vc, animated: true)
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
        setupSignUpButton()
        setupViews()
    }
    
    //MARK: -- Setup
    
    private func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubview(mainStackView)
        mainStackView.addSubviews(usernameStackView,
                                  emailStackView,
                                  passwordStackView,
                                  passwordConfirmStackView,
                                  buttonLogin)
        
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
    
    var isPasswordValid: Bool {
        return passwordStackView.defaultTextField.text?.count ?? 0 >= 6
    }
    
    var isUsernameValid: Bool {
        return usernameStackView.defaultTextField.text?.count ?? 0 >= 6
    }
    
    var isPasswordConfirmed: Bool {
        return passwordStackView.defaultTextField.text == passwordConfirmStackView.defaultTextField.text
    }
    
    var isAllFieldsFilled: Bool {
        return usernameStackView.defaultTextField.hasText &&
        emailStackView.defaultTextField.hasText &&
        passwordStackView.defaultTextField.hasText &&
        passwordConfirmStackView.defaultTextField.hasText
    }
    
    
    func setupSignUpButton() {
        
        let textFields = [usernameStackView.defaultTextField, emailStackView.defaultTextField, passwordStackView.defaultTextField, passwordConfirmStackView.defaultTextField]
        textFields.forEach {
            $0.addTarget(self, action: #selector(updateBtnColor), for: .editingChanged)
        }
        
    }
    
    @objc func updateSignUpButtonState()->Bool{
        
        if !isAllFieldsFilled{
            showAlert(title: "Error", message: "Please fill out all fields.")
            return false
        }else if !isUsernameValid{
            showAlert(title: "Error", message: "Username must be longer than 6 characters.")
            return false
        }else if !isPasswordValid{
            showAlert(title: "Error", message: "Password must be longer than 6 characters.")
            return false
        }else if !isPasswordConfirmed{
            showAlert(title: "Error", message: "Password and password confirm does not match.")
            return false
        }
        return true
    }
    
    @objc func updateBtnColor(){
        
        if isUsernameValid && isAllFieldsFilled && isPasswordValid && isPasswordConfirmed == true{
            buttonLogin.backgroundColor = ColorStyle.primary.color
        }else {
            buttonLogin.backgroundColor = ColorStyle.greySpanish.color
        }
    }
}
