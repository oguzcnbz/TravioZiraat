//
//  
//  EditProfileVC.swift
//  Application
//
//  Created by Ada on 7.11.2023.
//
//
import UIKit
import TinyConstraints
import SnapKit

class EditProfileVC: UIViewController {
    
    //MARK: -- Properties
    
    
    //MARK: -- Views
    
//    private lazy var mainStackView: DefaultMainStackView = {
//        let sv = DefaultMainStackView()
//        return sv
//    }()
    
    private lazy var containerView:UIView = {
        let v = UIView()
        v.backgroundColor = kcBackgroundColor
        v.clipsToBounds = true
        v.layer.cornerRadius = 80
        v.layer.maskedCorners = [.layerMinXMinYCorner]
        return v
    }()
    
    private lazy var usernameStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Fullname", textFieldPlaceholder: "bilge_adam")
        
        return sv
    }()
    
    private lazy var emailStackView: CustomTextField = {
        let sv = CustomTextField(labelText: "Email", textFieldPlaceholder: "developer@bilgeadam.com")
        return sv
    }()
    
    private lazy var photoView:UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 260
        return v
    }()
    
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsSemiBold(size: 30).font
        return lbl
    }()
    
    
    
    private lazy var editProfileBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Photo", for: .normal)
        btn.titleLabel?.font = FontStyle.poppinsLight(size: 12).font
        btn.setTitleColor(kcBlueRaspberryColor, for: .normal)
        btn.addTarget(self, action: #selector(changePhotofunc), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        //btn.backgroundColor = kcBlueRaspberryColor
        return btn
    }()
    
    private lazy var dateStackView: UIStackView = CsStackView()
    
    
    private lazy var icEdit:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icEditDate")
        return img
    }()
    private lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsMedium(size: 14).font
        return lbl
    }()
    private lazy var userTypeStackView: UIStackView = CsStackView()
    
    private lazy var icAdmin:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icAdmin")
        return img
    }()
    private lazy var userTypeLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = FontStyle.poppinsMedium(size: 14).font
        return lbl
    }()
    private lazy var buttonSave: DefaultButton = {
        let btn = DefaultButton(title: "Save", background: .customgreen)
        btn.addTarget(self, action: #selector(btnLoginTapped), for: .touchUpInside)
        return btn
    }()
    @objc func btnLoginTapped() {
//        guard let email = emailStackView.defaultTextField.text else {return}
//        guard let password = passwordStackView.defaultTextField.text else {return}
        
       // loginViewModel.setDelegate(output: self)
      //  loginViewModel.loginUser(email: email, password: password)
    }

    
    //MARK: -- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = "Bruce Villiam"
        photoView.image = UIImage(named: "face")
        dateLbl.text = "30 Ağustos 2023"
        userTypeLbl.text = "Admin"
       setupViews()
       
    }
    
    //MARK: -- Component Actions
    @objc func rightbartapped(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func changePhotofunc(){
    }
    //MARK: -- Private Methods
    
    
    //MARK: -- UI Methods
    func setupViews() {
       
        self.view.backgroundColor = kcPrimaryColor
        self.view.addSubview(containerView)
        
        containerView.addSubviews(photoView,nameLbl,editProfileBtn,dateStackView,userTypeStackView, usernameStackView,emailStackView,buttonSave)
        dateStackView.addSubviews(icEdit,dateLbl)
        userTypeStackView.addSubviews(icAdmin,userTypeLbl)
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(rightbartapped))
        setNavigationItems(leftBarButton: false, rightBarButton: rightBarButton, title: "Edit Profile")
        setupLayout()
    }
    
    func setupLayout() {
        containerView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
        
        photoView.snp.makeConstraints({imgv in
            imgv.top.equalToSuperview().offset(24)
            imgv.centerX.equalToSuperview()
            imgv.width.equalTo(120)
        })
        editProfileBtn.snp.makeConstraints({btn in
            btn.top.equalTo(photoView.snp.bottom).offset(8)
          
            btn.centerX.equalToSuperview()
        })
        
        nameLbl.snp.makeConstraints({lbl in
            lbl.top.equalTo(editProfileBtn.snp.bottom)
        
            lbl.centerX.equalToSuperview()
        })
        dateStackView.snp.makeConstraints { v in
            v.top.equalTo(nameLbl.snp.bottom).offset(30)
           
            v.leading.equalToSuperview().offset(24)
            v.width.equalTo(usernameStackView).multipliedBy(0.5).offset(-5)
            v.height.equalTo(52)
        }
        icEdit.snp.makeConstraints({item in
           // item.centerY.equalToSuperview()
            item.leading.equalToSuperview().offset(16)
            
            item.top.equalToSuperview().offset(18)
            item.bottom.equalToSuperview().offset(-16)
            item.width.equalTo(20)
            
            
        })
        dateLbl.snp.makeConstraints({item in
          
            item.leading.equalTo(icEdit.snp.trailing).offset(8)
            
            item.top.equalToSuperview().offset(16)
            item.bottom.equalToSuperview().offset(-16)
            item.trailing.equalToSuperview().offset(5)
            
        })
        
        userTypeStackView.snp.makeConstraints { v in
            v.top.equalTo(nameLbl.snp.bottom).offset(30)
           
            v.leading.equalTo(dateStackView.snp.trailing).offset(10)
            v.width.equalTo(usernameStackView).multipliedBy(0.5).offset(-5)
            v.height.equalTo(52)
        }
        icAdmin.snp.makeConstraints({item in
           // item.centerY.equalToSuperview()
            item.leading.equalToSuperview().offset(16)
            
            item.top.equalToSuperview().offset(16)
            item.bottom.equalToSuperview().offset(-16)
           // item.width.equalTo(20)
            
            
        })
        userTypeLbl.snp.makeConstraints({item in
           
            item.leading.equalTo(icAdmin.snp.trailing).offset(10)
            
            item.top.equalToSuperview().offset(16)
            item.bottom.equalToSuperview().offset(-16)
            item.trailing.equalToSuperview().offset(5)
            //item.height.equalTo(12)
        })
        
        
        
        usernameStackView.snp.makeConstraints { v in
            v.top.equalTo(dateStackView.snp.bottom).offset(20)
            v.trailing.equalToSuperview().offset(-24)
            v.leading.equalToSuperview().offset(24)
            v.height.equalTo(74)
        }
        emailStackView.snp.makeConstraints { v in
            v.top.equalTo(usernameStackView.snp.bottom).offset(15)
            v.trailing.equalToSuperview().offset(-24)
            v.leading.equalToSuperview().offset(24)
            v.height.equalTo(74)
        }
        
        buttonSave.snp.makeConstraints { v in
            v.bottom.equalToSuperview().offset(-30)
            v.trailing.equalToSuperview().offset(-24)
            v.leading.equalToSuperview().offset(24)
            v.height.equalTo(54)
        }
        
       
    }
  
}
extension EditProfileVC {
    private func CsTxtLabel(title:String) ->UILabel{
        let l = UILabel()
        l.numberOfLines = 0
        l.text = title
        l.height(24)
        return l
    }
    private func CsStackView() -> UIStackView{
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 16
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.shadowOpacity = 0.15
        stack.layer.shadowRadius = 20
    
        return stack
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct EditProfileVC_Preview: PreviewProvider {
    static var previews: some View{
         
        EditProfileVC().showPreview()
    }
}
#endif
