import UIKit
import SnapKit
import TinyConstraints

class LoginVC: UIViewController {
    
    private lazy var loginView: DefaultView = {
            let scene = DefaultView()
            return scene
        }()
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var emailStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.backgroundColor = .white
        sv.layer.cornerRadius = 16
        sv.layer.borderColor = UIColor.black.cgColor
        sv.layer.shadowRadius = 20.0
        sv.layer.shadowOpacity = 0.15
        sv.spacing = 8
        return sv
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.backgroundColor = .white
        sv.layer.cornerRadius = 16
        sv.layer.borderColor = UIColor.black.cgColor
        sv.layer.shadowRadius = 20.0
        sv.layer.shadowOpacity = 0.15
        sv.spacing = 8
        return sv
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Travio")
        return imageView
    }()
    
    private lazy var lblTitle: DefaultLabel = {
        let label = DefaultLabel(text: "Welcome to Travio", fontStyle: .poppinsMedium(size: 24))
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
    
    private lazy var lblCheckSign: DefaultLabel = {
        let label = DefaultLabel(text: "Don’t have any account?",fontStyle: .poppinsSemiBold(size: 14))
        
        return label
    }()
    
    private lazy var txtEmail: DefaultTextField = {
        let txt = DefaultTextField(text: "developer@bilgeadam.com")
        return txt
    }()
    
    private lazy var txtPassword: DefaultTextField = {
        let txt = DefaultTextField(text: "************")
        return txt
    }()
    
    private lazy var buttonLogin: DefaultButton = {
        let btn = DefaultButton(title: "Login", background: .green)
        
        return btn
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = FontStyle.poppinsSemiBold(size: 14).font
        
        button.addTarget(self, action: #selector(btnSignTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func btnSignTapped() {
        let SignUpVC = SignUp()
        SignUpVC.modalPresentationStyle = .fullScreen
        self.present(SignUpVC, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
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
        
        emailStackView.addSubviews(lblEmail,
                                   txtEmail)
        
        passwordStackView.addSubviews(lblPassword,
                                      txtPassword)
        layout()
    }
    
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
        
        lblEmail.snp.makeConstraints { lbl in
            lbl.leading.equalTo(emailStackView.snp.leading).offset(12)
            lbl.trailing.equalTo(emailStackView.snp.trailing).offset(-291)
            lbl.top.equalTo(emailStackView.snp.top).offset(8)
            lbl.height.equalTo(21)
        }
        
        txtEmail.snp.makeConstraints({txt in
            txt.leading.equalTo(emailStackView.snp.leading).offset(12)
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
            lbl.trailing.equalTo(passwordStackView.snp.trailing).offset(-261)
            lbl.top.equalTo(passwordStackView.snp.top).offset(8)
            lbl.height.equalTo(21)
        }
        
        txtPassword.snp.makeConstraints({txt in
            txt.leading.equalTo(passwordStackView.snp.leading).offset(12)
            txt.top.equalTo(lblPassword.snp.bottom).offset(8)
            txt.height.equalTo(18)
        })

        
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

            btn.trailing.equalTo(mainStackView.snp.trailing).offset(-84)
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

        LoginVC().showPreview()
    }
}
#endif

