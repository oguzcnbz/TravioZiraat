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
    

    var populerArr: [Place] = []
    var lastArr: [Place] = []
    var userArr: [Place] = []
    
    
    //MARK: -- Views
    
    private lazy var containerView:UIView = {
        let v = UIView()
        v.backgroundColor = ColorStyle.background.color
        v.clipsToBounds = true
        v.layer.cornerRadius = 80
        v.layer.maskedCorners = [.layerMinXMinYCorner]
        return v
    }()
    private lazy var logoImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "homeLogo")
        return iv
        
        
    }()
    
 
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
        return cv
    }()
   
    
    
    //MARK: -- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
getPopulerPlaceData()
        getLastPlaceData ()
        getUserPlaceData ()
           
       setupViews()
   
        
    }
   
    //MARK: -- Component Actions
   
    
    //MARK: -- Private Methods
    private func getPopulerPlaceData (){
       
        
        homeViewModel.getPopulerPlaceParam()
        homeViewModel.transferPopulerData = { [weak self] () in
            let obj = self?.homeViewModel.populerPlace
            self?.populerArr = obj ?? []
          
           self?.collectionView.reloadData()

        }
        
     
    }
    private func getLastPlaceData (){
        homeViewModel.getLastParam()
        homeViewModel.transferLastData = { [weak self] () in
            let obj = self?.homeViewModel.lastPlace
            self?.lastArr = obj ?? []
            

            self?.collectionView.reloadData()

        }
    }
    private func getUserPlaceData (){
        homeViewModel.getUserPlace()
        homeViewModel.transferUserData = { [weak self] () in
            let obj = self?.homeViewModel.userPlace
            self?.userArr = obj ?? []
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
       
        logoImageView.topToSuperview(offset: 60)
        logoImageView.leadingToSuperview(offset: 20)
        logoImageView.height(24)
       
        
        
        containerView.edgesToSuperview(excluding: .top)
        containerView.heightToSuperview(multiplier: 0.85)
        
        collectionView.snp.makeConstraints { view in
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
            view.height.equalToSuperview().offset(-30)
        }

    }
  
}



extension HomeVC:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return populerArr.count }
        
        else if section == 1{ return lastArr.count}
        
        else{
            return userArr.count
            
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCell
        if indexPath.section == 0 {
            
            let object = populerArr[indexPath.row]
            cell.configure(object:object)
            return cell
        }else if indexPath.section == 1{
            let object = lastArr[indexPath.row]
            cell.configure(object:object)
            return cell
        }else {
            let object = userArr[indexPath.row]
            cell.configure(object:object)
            return cell
            
        }
        
        
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: "section-header-element-kind",
                withReuseIdentifier: HomeHeaderCell.reuseIdentifier ,
                for: indexPath) as? HomeHeaderCell else { fatalError("Cannot create new supplementary")
            }
            supplementaryView.configure(title: "Populer Place")
            
            supplementaryView.closure = {
                let vc = HomeDetailPlacesVC()
                vc.titleHeader = "Populer Place"
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return supplementaryView
        }
        else if indexPath.section == 1 {
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: "section-header-element-kind",
                withReuseIdentifier: HomeHeaderCell.reuseIdentifier ,
                for: indexPath) as? HomeHeaderCell else { fatalError("Cannot create new supplementary")
            }
            supplementaryView.configure(title: "Last Place")
            
            supplementaryView.closure = {
                let vc = HomeDetailPlacesVC()
                vc.titleHeader = "Last Place"
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return supplementaryView
        }else {
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: "section-header-element-kind",
                withReuseIdentifier: HomeHeaderCell.reuseIdentifier ,
                for: indexPath) as? HomeHeaderCell else { fatalError("Cannot create new supplementary")
            }
            supplementaryView.configure(title: "My Added Place")
            
            supplementaryView.closure = {
                let vc = HomeDetailPlacesVC()
                vc.titleHeader = "My Added Place"
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return supplementaryView
            
        }
     
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
