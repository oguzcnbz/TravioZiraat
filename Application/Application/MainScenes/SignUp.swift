
import UIKit
import SnapKit
import TinyConstraints

class SignUp: UIViewController {

    private lazy var loginView: DefaultView = {
        let scene = DefaultView()
        return scene
    }()
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var lbSignUp: DefaultLabel = {
        let label = DefaultLabel(text: "Sign Up",fontStyle: .poppinsSemiBold(size: 36))
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
    
    private lazy var txtUsername: DefaultTextField = {
        let txt = DefaultTextField(text: "bilge_adam")
        return txt
    }()
    
    private lazy var txtEmail: DefaultTextField = {
        let txt = DefaultTextField(text: "developer@bilgeadam.com")
        return txt
    }()
    
    private lazy var txtPassword: DefaultTextField = {
        let txt = DefaultTextField()
        return txt
    }()
    
    private lazy var txtPasswordConfirm: DefaultTextField = {
        let txt = DefaultTextField()
        return txt
    }()
    
    private lazy var buttonLogin: DefaultButton = {
        let btn = DefaultButton(title: "Sign Up", background: .lightGray)
        return btn
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func backButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
       
    }
    
    private func setupViews() {
        self.view.addSubview(loginView)
        loginView.addSubviews(backButton,mainStackView)
        layout()
        
    }
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
        
        backButton.snp.makeConstraints({btn in
            btn.leading.equalTo(loginView.snp.leading).offset(24)
            btn.top.equalTo(loginView.snp.top).offset(32)
        })
        
    }

}
