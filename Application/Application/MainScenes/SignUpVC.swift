
import UIKit
import SnapKit
import TinyConstraints
import IQKeyboardManagerSwift

class SignUpVC: UIViewController {

    
//MARK: -- Views
    
    private lazy var loginView: DefaultView = {
        let scene = DefaultView()
        return scene
    }()
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var usernameStackView: DefaultStackView = {
        let sv = DefaultStackView()
        
        return sv
    }()
    
    private lazy var emailStackView: DefaultStackView = {
        let sv = DefaultStackView()
        return sv
    }()
    
    private lazy var passwordStackView: DefaultStackView = {
        let sv = DefaultStackView()
        return sv
    }()
    
    private lazy var passwordConfirmStackView: DefaultStackView = {
        let sv = DefaultStackView()
        return sv
    }()
    
    
//MARK: -- Labels
    
    private lazy var lblSignUp: DefaultLabel = {
        let label = DefaultLabel(text: "Sign Up",fontStyle: .poppinsSemiBold(size: 36))
        label.textColor = UIColor(hex: "FFFFFF")
        label.sizeToFit()
        return label
    }()
    
    private lazy var lblUserName: DefaultLabel = {
        let label = DefaultLabel(text: "Username")
        return label
    }()
    
    private lazy var lblEmail: DefaultLabel = {
        let label = DefaultLabel(text: "Email")
        return label
    }()
    
    private lazy var lblPassword: DefaultLabel = {
        let label = DefaultLabel(text: "Password")
        return label
    }()
    
    private lazy var lblPasswordConfirm: DefaultLabel = {
        let label = DefaultLabel(text: "Password Confirm")
        return label
    }()
    
//MARK: -- TextFields
    
    private lazy var txtUsername: DefaultTextField = {
        let txt = DefaultTextField(text: "bilge_adam")
        txt.delegate = self
        return txt
    }()
    
    private lazy var txtEmail: DefaultTextField = {
        let txt = DefaultTextField(text: "developer@bilgeadam.com")
        txt.delegate = self
        return txt
    }()
    
    private lazy var txtPassword: DefaultTextField = {
        let txt = DefaultTextField(text: "")
        txt.delegate = self
        return txt
    }()
    
    private lazy var txtPasswordConfirm: DefaultTextField = {
        let txt = DefaultTextField(text: "")
        txt.delegate = self
        return txt
    }()
    
    
//MARK: -- Buttons
    
    private lazy var buttonLogin: DefaultButton = {
        let btn = DefaultButton(title: "Sign Up", background: .lightGray)
        return btn
    }()
    
    
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
   

   
//MARK: -- Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
       
       
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
        
        usernameStackView.addSubviews(lblUserName,txtUsername)
        emailStackView.addSubviews(lblEmail,txtEmail)
        passwordStackView.addSubviews(lblPassword,txtPassword)
        passwordConfirmStackView.addSubviews(lblPasswordConfirm,txtPasswordConfirm)
        
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
        
        lblUserName.snp.makeConstraints { lbl in
            lbl.leading.equalTo(usernameStackView.snp.leading).offset(12)
            lbl.trailing.equalTo(usernameStackView.snp.trailing).offset(0)
            lbl.top.equalTo(usernameStackView.snp.top).offset(8)
            lbl.height.equalTo(21)
        }
        
        txtUsername.snp.makeConstraints({txt in
            txt.leading.equalTo(usernameStackView.snp.leading).offset(12)
            txt.trailing.equalTo(usernameStackView.snp.trailing).offset(0)
            txt.top.equalTo(lblUserName.snp.bottom).offset(8)
            txt.height.equalTo(18)
        })
      
        emailStackView.snp.makeConstraints { view in
            view.top.equalTo(usernameStackView.snp.bottom).offset(24)
            view.trailing.equalToSuperview().offset(-24)
            view.leading.equalToSuperview().offset(24)
            view.height.equalTo(74)
        }
        
        lblEmail.snp.makeConstraints { lbl in
            lbl.leading.equalTo(emailStackView.snp.leading).offset(12)
            lbl.trailing.equalTo(emailStackView.snp.trailing).offset(0)
            lbl.top.equalTo(emailStackView.snp.top).offset(8)
            lbl.height.equalTo(21)
        }
        
        txtEmail.snp.makeConstraints({txt in
            txt.leading.equalTo(emailStackView.snp.leading).offset(12)
            txt.trailing.equalTo(emailStackView.snp.trailing).offset(0)
            txt.top.equalTo(lblEmail.snp.bottom).offset(8)
            txt.height.equalTo(18)
        })
        
        passwordStackView.snp.makeConstraints { view in
            view.top.equalTo(emailStackView.snp.bottom).offset(24)
            view.trailing.equalToSuperview().offset(-24)
            view.leading.equalToSuperview().offset(24)
            view.height.equalTo(74)
        }
        
        lblPassword.snp.makeConstraints { lbl in
            lbl.leading.equalTo(passwordStackView.snp.leading).offset(12)
            lbl.trailing.equalTo(passwordStackView.snp.trailing).offset(0)
            lbl.top.equalTo(passwordStackView.snp.top).offset(8)
            lbl.height.equalTo(21)
        }
        
        txtPassword.snp.makeConstraints({txt in
            txt.leading.equalTo(passwordStackView.snp.leading).offset(12)
            txt.trailing.equalTo(passwordStackView.snp.trailing).offset(0)
            txt.top.equalTo(lblPassword.snp.bottom).offset(8)
            txt.height.equalTo(18)
        })
        
        passwordConfirmStackView.snp.makeConstraints { view in
            view.top.equalTo(passwordStackView.snp.bottom).offset(24)
            view.trailing.equalToSuperview().offset(-24)
            view.leading.equalToSuperview().offset(24)
            view.height.equalTo(74)
        }
        
        lblPasswordConfirm.snp.makeConstraints { lbl in
            lbl.leading.equalTo(passwordConfirmStackView.snp.leading).offset(12)
            lbl.trailing.equalTo(passwordConfirmStackView.snp.trailing).offset(0)
            lbl.top.equalTo(passwordConfirmStackView.snp.top).offset(8)
            lbl.height.equalTo(21)
        }
        
        txtPasswordConfirm.snp.makeConstraints({txt in
            txt.leading.equalTo(passwordConfirmStackView.snp.leading).offset(12)
            txt.trailing.equalTo(passwordConfirmStackView.snp.trailing).offset(0)
            txt.top.equalTo(lblPasswordConfirm.snp.bottom).offset(8)
            txt.height.equalTo(18)
        })
        
        buttonLogin.snp.makeConstraints { btn in
            btn.top.equalTo(passwordConfirmStackView.snp.bottom).offset(202)
            btn.trailing.equalToSuperview().offset(-24)
            btn.leading.equalToSuperview().offset(24)
            btn.height.equalTo(54)
        }
        
    }
    
    private var isPasswordValid: Bool = false
    private var isPasswordConfirmValid: Bool = false
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            if textField == txtPassword {
                if let text = textField.text, text.count >= 6 {
                    isPasswordValid = true
                } else {
                    isPasswordValid = false
                }
            
            }
        if textField == txtPasswordConfirm {
                if let password = txtPassword.text, let passwordConfirm = txtPasswordConfirm.text, password == passwordConfirm {
                    isPasswordConfirmValid = true
                } else {
                    isPasswordConfirmValid = false
                }
            }
            
            updateButtonState()
        }
        
        func updateButtonState() {
            if isPasswordValid && isPasswordConfirmValid && !txtUsername.text!.isEmpty && !txtEmail.text!.isEmpty {
                buttonLogin.isEnabled = true
                buttonLogin.backgroundColor = ButtonBackground.customgreen.backgroundColor
            } else {
                buttonLogin.isEnabled = false
                buttonLogin.backgroundColor = .lightGray
            }
        }

}


//MARK: -- Extensions

extension SignUpVC: UITextFieldDelegate {
    
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


extension UIViewController {
    func setupDismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


