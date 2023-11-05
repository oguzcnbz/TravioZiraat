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
<<<<<<< HEAD
  
    ]
    
    
    private lazy var mainView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(hex: "F8F8F8")
        sv.layer.cornerRadius = 80
        sv.layoutIfNeeded()
        sv.layer.maskedCorners = [.layerMinXMinYCorner]
=======
  // isimleri veri ismiyle değiştirmeyi unutmaa!!!!!!
    ]
    
    
    private lazy var mainView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
>>>>>>> sprint2/myVisit2
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

<<<<<<< HEAD
    private lazy var headLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "My Visits"
        lbl.font = FontStyle.poppinsSemiBold(size: 36).font
        lbl.textColor = .white
        return lbl
    }()
    
    
=======
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
>>>>>>> sprint2/myVisit2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        self.view.backgroundColor = UIColor(hex: "38ada9")
<<<<<<< HEAD
        self.view.addSubviews(headLbl,mainView)
        mainView.addSubview(collectionView)
=======
        self.view.addSubviews(mainView)
        mainView.addSubview(collectionView)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let leftButtonImage = UIImage(named:"backWard")
        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor(hex: "FFFFFF")
        self.navigationItem.leftBarButtonItem = leftBarButton
        setNavigationItems(leftBarButton: false, rightBarButton: nil, title: "My Visits")
        
>>>>>>> sprint2/myVisit2
        setupLayout()
        
    }
    
    private func setupLayout(){
        
    
<<<<<<< HEAD
        headLbl.snp.makeConstraints({ lbl in
            lbl.leading.equalToSuperview().offset(24)
            lbl.top.equalToSuperview().offset(48)
        })


        mainView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.85)
=======
        mainView.snp.makeConstraints { v in
            v.centerX.equalToSuperview()
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
>>>>>>> sprint2/myVisit2
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
        
        
<<<<<<< HEAD
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
=======
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.34))
>>>>>>> sprint2/myVisit2
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
//        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0 , trailing: 22)
       
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 45, leading: 24, bottom: 0, trailing: 22)
        layoutSection.interGroupSpacing = 16
        
        return layoutSection
    }
}
