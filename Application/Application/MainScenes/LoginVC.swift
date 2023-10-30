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
            let vc = HomeVC()
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
    
    private lazy var loginView: DefaultView = {
            let scene = DefaultView()
            return scene
        }()
    
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
        self.view.addSubview(loginView)
        
        loginView.addSubviews(imageView,
                              mainStackView)
        
        mainStackView.addSubviews(lblTitle,
                                  emailStackView,
                                  passwordStackView,
                                  buttonLogin,
                                  lblCheckSign,
                                  signButton)
        
        
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
        
        imageView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.bottom.equalTo(mainStackView.snp.top).offset(-24)
        }
        
        mainStackView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.7)
        }
        
        lblTitle.snp.makeConstraints { lbl in
            lbl.leading.equalToSuperview().offset(82)
            lbl.trailing.equalToSuperview().offset(-82)
            lbl.top.equalTo(mainStackView.snp.top).offset(64)
            lbl.height.equalTo(36)
        }
        
        emailStackView.snp.makeConstraints { view in
            view.top.equalTo(lblTitle.snp.bottom).offset(44)
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

        buttonLogin.snp.makeConstraints { btn in
            btn.top.equalTo(passwordStackView.snp.bottom).offset(48)
            btn.trailing.equalToSuperview().offset(-24)
            btn.leading.equalToSuperview().offset(24)
            btn.height.equalTo(54)
        }
        
        lblCheckSign.snp.makeConstraints { lbl in
            lbl.top.equalTo(buttonLogin.snp.bottom).offset(141)
            lbl.leading.equalTo(mainStackView.snp.leading).offset(78)
            lbl.bottom.equalTo(mainStackView.snp.bottom).offset(-21)
        }

        signButton.snp.makeConstraints({btn in
            btn.trailing.equalTo(mainStackView.snp.trailing).offset(-81)
            btn.leading.equalTo(lblCheckSign.snp.trailing).offset(2)
            btn.top.equalTo(buttonLogin.snp.bottom).offset(141)
            btn.centerY.equalTo(lblCheckSign)
         
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
