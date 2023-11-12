//
//  
//  HomeVCVC.swift
//  Application
//
//  Created by Ada on 26.10.2023.
//
//
import UIKit
import TinyConstraints
import SnapKit





class HomeVC: UIViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"


    //MARK: -- Properties
    
    lazy var homeViewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    
//    var users: [PlacesModel] = [
//        PlacesModel(image: UIImage(named: "SüleymaniyeCamii"), name: "SüleymaniyeCamii",place: "İstanbul"),
//        PlacesModel(image: UIImage(named: "Colleseum"), name: "Colleseum",place: "Rome"),
//        PlacesModel(image: UIImage(named: "SüleymaniyeCamii"), name: "Süleymaniye Camii",place: "İstanbul"),
//  
//    ]
    var populerArr: [Place] = []
    
    
    //MARK: -- Views
    
    private lazy var containerView:UIView = {
        let v = UIView()
        v.backgroundColor = ColorStyle.background.color
        v.clipsToBounds = true
        v.layer.cornerRadius = 80
        v.layer.maskedCorners = [.layerMinXMinYCorner] // Top right corner, Top left corner respectively Top right corner, Top left corner respectively
        return v
    }()
    private lazy var logoImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "homeLogo")
        return iv
        
        
    }()
    
 

    
//    private lazy var View: DefaultView = {
//        let scene = DefaultView()
//        return scene
//    }()
    
//    private lazy var mainStackView: DefaultMainStackView = {
//        let sv = DefaultMainStackView()
//        return sv
//    }()
    
    private lazy var collectionView:UICollectionView = {

        let lay = makeCollectionViewLayout()
       

        let cv = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cv.backgroundColor = .clear
        cv.register(HomeCell.self, forCellWithReuseIdentifier: "cell")
     
        cv.register(
            HomeHeaderCell.self,
            forSupplementaryViewOfKind: HomeVC.sectionHeaderElementKind,
            withReuseIdentifier: HomeHeaderCell.reuseIdentifier)
       
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
   
    
    
    //MARK: -- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        
        
       setupViews()
   
        
    }
   
    //MARK: -- Component Actions
   
    
    //MARK: -- Private Methods
    private func getData (){
       
        
        homeViewModel.getPopulerPlaceParam()
        homeViewModel.transferData = { [weak self] () in
            let obj = self?.homeViewModel.populerPlace
            self?.populerArr = obj ?? []
//            print(self?.populerArr.count)
//            print("======")
            self?.collectionView.reloadData()

        }
    }
    
    
    //MARK: -- UI Methods
    func setupViews() {
        // Add here the setup for the UI
        let leftBarButton = UIBarButtonItem()
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubview(logoImageView)
        self.view.addSubview(containerView)
        
        containerView.addSubview(collectionView)
        
        self.view.addSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        // Add here the setup for layout
        logoImageView.topToSuperview(offset: 60)
        logoImageView.leadingToSuperview(offset: 20)
        logoImageView.height(24)
        //logoImageView.horizontalToSuperview(.left(20))
        //logoImageView.centerXToSuperview()
       // logoImageView.topToSuperview(offset: 5,usingSafeArea: true)
        
       // logoImageView.height(50)
        
        
        containerView.edgesToSuperview(excluding: .top)
        containerView.heightToSuperview(multiplier: 0.85)
        
        collectionView.snp.makeConstraints { view in
           // view.centerX.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
            view.height.equalToSuperview().offset(-30)
        }
       
        
        
      
       
    }
  
}
extension HomeVC:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //print(indexPath)
    }
    /*
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         return
     }
     */
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: (collectionView.frame.width - 20), height: (collectionView.frame.height-10))
    }
}


extension HomeVC:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //guard let tempValue = pageOptional else {return}
        return populerArr.count
        //MARK: todo
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCell
        let object = populerArr[indexPath.row]
        cell.configure(object:object)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: "section-header-element-kind",
            withReuseIdentifier: HomeHeaderCell.reuseIdentifier ,
            for: indexPath) as? HomeHeaderCell else { fatalError("Cannot create new supplementary")
        }
        
        supplementaryView.closure = {
            let vc = HomeDetailPlacesVC()
            self.navigationController?.pushViewController(vc, animated: true)
//            let navigationController = UINavigationController(rootViewController: vc)
//
//            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//                sceneDelegate.window?.rootViewController = navigationController
//                sceneDelegate.window?.makeKeyAndVisible()
//            }
            
        }
        return supplementaryView
    }
    

       
    
   
}


extension HomeVC {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            
            return self?.makeSliderLayoutSection()

            
            
            
        }
    
        
    
        
    }
    
    func makeSliderLayoutSection() -> NSCollectionLayoutSection {
    
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(0.30))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [item] )
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: HomeVC.sectionHeaderElementKind, alignment: .top)
        layoutSection.boundarySupplementaryItems = [sectionHeader]
        return layoutSection
    }
}





#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeVCVC_Preview: PreviewProvider {
    static var previews: some View{
         
        HomeVC().showPreview()
    }
}
#endif
