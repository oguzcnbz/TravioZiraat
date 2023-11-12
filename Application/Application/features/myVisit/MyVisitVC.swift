import UIKit
import TinyConstraints
import SnapKit

protocol DataTransferDelegate:AnyObject {
    func getData(data:String)
    func getDataFromSignUp(params:PlacesModel)
    
}

extension DataTransferDelegate {
    func getData(data:String){ }
    func getDataFromSignUp(params:PlacesModel){ }
}


class MyVisitVC: UIViewController {
    
    var users: [PlacesModel] = [
        PlacesModel(image: UIImage(named: "süleymaniyeCamii"), name: "Süleymaniye Camii",place: "İstanbul"),
        PlacesModel(image: UIImage(named: "colleseum"), name: "Colleseum",place: "Rome"),
        PlacesModel(image: UIImage(named: "süleymaniyeCamii"), name: "Süleymaniye Camii",place: "İstanbul"),
        PlacesModel(image: UIImage(named: "süleymaniyeCamii"), name: "Süleymaniye Camii",place: "İstanbul")
  // isimleri veri ismiyle değiştirmeyi unutmaa!!!!!!
    ]
    
    
    private lazy var mainView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var collectionView:UICollectionView = {
       
        let lay = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lay)
        
        cv.register(MyVisitsCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 80
        cv.layoutIfNeeded()
        cv.layer.maskedCorners = [.layerMinXMinYCorner]
        cv.dataSource = self

        return cv
    }()

    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        self.view.backgroundColor = UIColor(hex: "38ada9")
        self.view.addSubviews(mainView)
        mainView.addSubview(collectionView)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
       
        setNavigationItems(leftBarButton: false, rightBarButton: nil, title: "My Visits")
        
        setupLayout()
        
    }
    
    private func setupLayout(){
        
    
        mainView.snp.makeConstraints { v in
            v.centerX.equalToSuperview()
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




extension MyVisitVC:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyVisitsCell
        let object = users[indexPath.row]
        cell.configure(object:object)
        
        return cell
    }
}


extension MyVisitVC {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
         
                return self?.makeListLayoutSection()
          
            
        }
    
         
       //return UICollectionViewCompositionalLayout(section: layoutType.layout)
        
    }
    
    
    
    func makeListLayoutSection() -> NSCollectionLayoutSection {
        

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0 , trailing: 0)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.34))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
//        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0 , trailing: 22)
       
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 45, leading: 24, bottom: 0, trailing: 22)
        layoutSection.interGroupSpacing = 16
        
        return layoutSection
    }
}
