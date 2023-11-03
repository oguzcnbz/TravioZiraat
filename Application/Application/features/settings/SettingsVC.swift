import UIKit
import TinyConstraints
import SnapKit

class SettingsVC: UIViewController {

    var usersss:[SettingUser] = [SettingUser(image: UIImage(named: "face"), name: "Bruce Wills")]

    var settingCells:[Settings] = [Settings(icon: UIImage(named: "user"), settingName: "Security Settings"),
                                      Settings(icon: UIImage(named: "binoculars"), settingName: "App Defaults"),
                                      Settings(icon: UIImage(named: "icMap"), settingName: "My Added Places"),
                                      Settings(icon: UIImage(named: "headPhone"), settingName: "Help&Support"),
                                      Settings(icon: UIImage(named: "info"), settingName: "About"),
                                      Settings(icon: UIImage(named: "hands"), settingName: "Terms of Use"),
    ]

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

        return cv
    }()

    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        
       setupViews()

    }


    func setupViews() {
        self.view.backgroundColor = UIColor(hex: "38ADA9")
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

    }
   

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
            let object = usersss[indexPath.row]
            cell.configure(object:object)
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
        return layout
    }

    func makeUserLayoutSection() -> NSCollectionLayoutSection {
        // Define layout for the user section
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0 , bottom: 0 , trailing: 0)

        return section
    }

    func makeSettingsLayoutSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0 , trailing: 0)


        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.078))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
//        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0 , trailing: 22)


        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 12, leading:16 , bottom:0 , trailing: 16)
        layoutSection.interGroupSpacing = 8


        return layoutSection
    }
}


