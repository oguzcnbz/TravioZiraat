

import UIKit
import SnapKit

class PlaceDetailVC: UIViewController {
    
    
    var userss: [PlaceDetailModel] = [
                                PlaceDetailModel(image: UIImage(named: "colleseumMini")),
                                PlaceDetailModel(image: UIImage(named: "süleymaniyeCamii")),
                                PlaceDetailModel(image: UIImage(named: "colleseumMini"))]
    
    private lazy var collectionView:UICollectionView = {
        
        let lay = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cv.register(PlaceDetailCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        cv.dataSource = self
        
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    func setupViews() {
        self.view.backgroundColor = UIColor(hex: "F8F8F8")
        self.view.addSubviews(collectionView)
        setupLayout()
    }
    
    private func setupLayout(){
        
        collectionView.snp.makeConstraints { cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.top.equalToSuperview()
            cv.height.equalTo(249)
        }
    }
}

    
extension PlaceDetailVC:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userss.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlaceDetailCell
        let object = userss[indexPath.row]
        cell.configure(object:object)
        
        return cell
    }
}
extension PlaceDetailVC {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
         
                return self?.makeListLayoutSection()
        }
    }
    
    
    func makeListLayoutSection() -> NSCollectionLayoutSection {
        

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
       
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.interGroupSpacing = 16
        
        
        return layoutSection
    }
}


