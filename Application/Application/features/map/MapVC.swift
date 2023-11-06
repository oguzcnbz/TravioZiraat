import UIKit
import MapKit
import SnapKit

class MapVC: UIViewController {

    
    var users: [PlacesModel] = [
        PlacesModel(image: UIImage(named: "süleymaniyeCamii"), name: "Süleymaniye Camii",place: "İstanbul"),
        PlacesModel(image: UIImage(named: "colleseum"), name: "Colleseum",place: "Rome"),
        PlacesModel(image: UIImage(named: "süleymaniyeCamii"), name: "Süleymaniye Camii",place: "İstanbul"),
        PlacesModel(image: UIImage(named: "süleymaniyeCamii"), name: "Süleymaniye Camii",place: "İstanbul")
  // isimleri veri ismiyle değiştirmeyi unutmaa!!!!!!
    ]
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.overrideUserInterfaceStyle = .dark
        return mapView
    }()
    
    private lazy var collectionView:UICollectionView = {
        let lay = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cv.backgroundColor = .clear
        cv.register(MapCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self

        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews(){
        self.view.addSubviews(mapView)
        mapView.addSubview(collectionView)
        
        setupLayout()
        
    }
    
    func setupLayout() {
    
        mapView.snp.makeConstraints { mv in
            mv.top.equalToSuperview()
            mv.leading.equalToSuperview()
            mv.bottom.equalToSuperview()
            mv.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints({cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.top.equalToSuperview().offset(565)
            cv.bottom.equalToSuperview().offset(-101)
           
        })
        
    }
}


extension MapVC:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MapCell
        let object = users[indexPath.row]
        cell.configure(object:object)
        
        cell.closure = {
            self.navigationController?.pushViewController(MapAddPlaceVC(), animated: true)
        }
        return cell
    }
}

extension MapVC{
    
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
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        layoutSection.interGroupSpacing = 18
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return layoutSection
    }
}
