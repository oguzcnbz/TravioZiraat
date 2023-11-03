import UIKit
import SnapKit
import TinyConstraints

class LoginVC: UIViewController,LoginResponseDelegate {

    func loginResponseGet(isLogin: Bool) {
       print("sonuc \(isLogin ?? false)")
        if isLogin == false {
            print("hatali giris")
            showAlert(title: "Giris Yapilamadi",message: "Bilgiler uyusmuyor")
        }
        if isLogin == true{
            print("Giris  delegate dogru")
            let vc = MainTabbar()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func showAlert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let btnCancel = UIAlertAction(title: "Vazgeç", style: .destructive)
        let btnRetry = UIAlertAction(title: "Yeniden Dene", style: .default, handler: { action in
            self.showAlert(title: "Hata", message: "Yine olmadı")
        })
        
        alert.addAction(btnCancel)
        alert.addAction(btnRetry)
        
        self.present(alert, animated: true)
    }
    
//MARK: -- Views-StackViews

    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var emailStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Email", textFieldPlaceholder: "developer@bilgeadam.com")
        return sv
    }()
    
    private lazy var passwordStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Password", textFieldPlaceholder: "************")
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
    
//MARK: -- Labels
    
    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome to Travio"
        lbl.font = FontStyle.poppinsSemiBold(size: 24).font
        lbl.textColor = UIColor(hex: "3D3D3D")
        lbl.numberOfLines = 1
        return lbl
    }()

    private lazy var lblCheckSign: UILabel = {
        let lbl = UILabel()
        lbl.text = "Don’t have  any account?"
        lbl.font = FontStyle.poppinsSemiBold(size: 14).font
        lbl.textColor = UIColor(hex: "3D3D3D")
        lbl.numberOfLines = 1
        return lbl
    }()
    

//MARK: -- Buttons
    
    private lazy var buttonLogin: DefaultButton = {
        let btn = DefaultButton(title: "Login", background: .customgreen)
        btn.addTarget(self, action: #selector(btnLoginTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func btnLoginTapped() {
        guard let email = emailStackView.defaultTextField.text else {return}
        guard let password = passwordStackView.defaultTextField.text else {return}
        
        loginViewModel.setDelegate(output: self)
        loginViewModel.loginUser(email: email, password: password)
    }
    private lazy var signButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = FontStyle.poppinsSemiBold(size: 14).font
        
        button.addTarget(self, action: #selector(btnSignTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func btnSignTapped() {
        let SignUpVC = SignUpVC()
        self.navigationController?.pushViewController(SignUpVC, animated: true)
    }
    
//MARK: -- Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

//MARK: -- SetUpViews
    
    private func setupViews() {
        self.view.backgroundColor = UIColor(hex: "38ada9")
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

    

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeVC_Preview: PreviewProvider {
    static var previews: some View{

        SignUpVC().showPreview()
    }
}
#endif
