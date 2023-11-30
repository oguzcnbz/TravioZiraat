import UIKit
import TinyConstraints
import SnapKit


class SettingsVC: UIViewController,PreviousPageDelegate {
    
    // MARK: -- Delegete
    func didDismiss() {
        getProfilData()
    }
    
    // MARK: -- Properties
    
    private var userModel = SettingUser(imageUrl: "",name: "")
    var settingCells:[Settings] = [Settings(icon: UIImage(named: "user"), settingName: "Security Settings"),
                                   Settings(icon: UIImage(named: "binoculars"), settingName: "App Defaults"),
                                   Settings(icon: UIImage(named: "icMap"), settingName: "My Added Places"),
                                   Settings(icon: UIImage(named: "headPhone"), settingName: "Help&Support"),
                                   Settings(icon: UIImage(named: "info"), settingName: "About"),
                                   Settings(icon: UIImage(named: "hands"), settingName: "Terms of Use"),
    ]
    
    var profilModel:ProfileModel?
    
    lazy var editProfilViewModel: EditProfileViewModel = {
        return EditProfileViewModel()
    }()
    
    
    // MARK: -- Components
    
    private lazy var collectionView:UICollectionView = {
        
        let lay = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lay)
        
        cv.register(SettingCell.self, forCellWithReuseIdentifier: "cell")
        cv.register(SettingUserCell.self, forCellWithReuseIdentifier: "userCell")
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 80
        cv.layoutIfNeeded()
        cv.layer.maskedCorners = [.layerMinXMinYCorner]
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    // MARK: -- Private Methods
    
    private func getProfilData(){
        
        editProfilViewModel.getProfilData()
        editProfilViewModel.transferProfilData = { [weak self] () in
            
            let obj = self?.editProfilViewModel.profilModel
            
            self?.userModel.name = obj?.fullName
            self?.userModel.imageUrl = obj?.ppURL
            
            self?.collectionView.reloadData()
            
        }
    }
    
    // MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfilData()
        setupViews()
    }
    
    // MARK: -- View Model
    
    func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubviews(mainStackView)
        mainStackView.addSubview(collectionView)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "off"), style: .plain, target: self, action: #selector(rightbartapped))
        setNavigationItems(leftBarButton: false, rightBarButton: rightBarButton, title: "Settings")
        
        setupLayout()
    }
    
    @objc func rightbartapped(){
        KeychainHelper.shared.delete("user-key", account: "accessToken")
        KeychainHelper.shared.delete("user-key", account: "refreshToken")
        let loginVC = LoginVC()
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = navigationController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    // MARK: -- View Layout
    
    func setupLayout() {
        
        mainStackView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
        
        collectionView.snp.makeConstraints({cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.top.equalToSuperview()
            cv.bottom.equalToSuperview()
        })
    }
}

// MARK: -- Extensions

extension SettingsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                let vc = SecuritySettingsVC()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 1:
                let vc = AppDefaultsVC()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 2:
                let vc = MyAddedPlacesVC()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 3:
                let vc = HelpAndSupportVC()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 4:
                let vc = AboutVC()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 5:
                let vc = TermOfUseVC()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
}


extension SettingsVC:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return settingCells.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! SettingUserCell
            let object = userModel
            cell.configure(object:object)
            cell.closure = {
                
                let editProfileVC = EditProfileVC()
                editProfileVC.delegate = self
                let rootViewController = UINavigationController(rootViewController: editProfileVC)
                editProfileVC.modalPresentationStyle = .popover
                self.present(rootViewController, animated: true)
                
            }
            return cell
            
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SettingCell
            let object = settingCells[indexPath.row]
            cell.configure(object:object)
            return cell
            
        }
    }
    
}


extension SettingsVC {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            if sectionIndex == 0 {
                return self?.makeUserLayoutSection()
            } else {
                return self?.makeSettingsLayoutSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config
        return layout
    }
    
    
    func makeUserLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0 , bottom: 0 , trailing: 0)
        section.interGroupSpacing = 16
        return section
    }
    
    func makeSettingsLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.15))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
        
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading:16 , bottom:0 , trailing: 16)
        layoutSection.interGroupSpacing = 8
        
        
        return layoutSection
    }
}


