import UIKit
import TinyConstraints
import SnapKit


class HomeDetailPlacesVC: UIViewController {
    
    var titleHeader: String?
    var detailArr: [Place] = []

    //MARK: -- Properties
    lazy var homeViewModel: HomeViewModel = {
        return HomeViewModel()
    }()
   
    private lazy var collectionView:UICollectionView = {
       
        let lay = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lay)
        
        cv.register(HomeDetailPlacesCell.self, forCellWithReuseIdentifier: "cell")
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
    
    private lazy var headLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = ColorStyle.white.color
        lbl.text = "Popular Places"
        lbl.font = FontStyle.h1.font
        lbl.sizeToFit()
        return lbl
    }()
    
    private lazy var sortButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "sortSB"), for: .normal)
        b.addTarget(self, action: #selector(btnSortTapped), for: .touchUpInside)
        return b
    }()
    
    @objc func btnSortTapped() {
        if sortButton.currentImage == UIImage(named: "sortSB") {
            detailArr.sort { $0.title ?? "" < $1.title ?? "" }
            sortButton.setImage(UIImage(named: "sortBS"), for: .normal)
            
        } else {
            
            detailArr.sort { $0.title ?? "" > $1.title ?? "" }
            sortButton.setImage(UIImage(named: "sortSB"), for: .normal)
        }
        collectionView.reloadData()
    }

    //MARK: -- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetail()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    func checkVisit(placeId: String, place:Place){
        let vc = PlaceDetailVC()
        vc.placeDetailViewModel.visitByPlaceIdCheck(placeId: placeId)
        vc.placeDetailViewModel.checkclosure = {[weak self] status in
            if status == "success" {
                vc.placeSaveButton.setImage(UIImage(named: "icPlaceDetailSaveFill"), for: .normal)
            }
            else{
                vc.placeSaveButton.setImage(UIImage(named: "icPlaceDetailSave"), for: .normal)
            }
            vc.placeModel = place
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //MARK: -- UI Methods
    func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubview(mainStackView)
        mainStackView.addSubviews(sortButton,collectionView)
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: titleHeader)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        setupLayout()
        
    }
    
    @objc func rightbartapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getDetail (){
        if titleHeader == "Populer Place" { 
            homeViewModel.getPopulerPlace()
            homeViewModel.transferPopulerData = { [weak self] () in
                let obj = self?.homeViewModel.populerPlace
                self?.detailArr = obj ?? []
                print(self?.detailArr.count)
                print("======")
                self?.collectionView.reloadData()
            }
            
        }else if titleHeader == "Last Place"  {
            homeViewModel.getLastPlace()
            homeViewModel.transferLastData = { [weak self] () in
                let obj = self?.homeViewModel.lastPlace
                self?.detailArr = obj ?? []
                print(self?.detailArr.count)
                print("======")
                self?.collectionView.reloadData()
            }
            
        }else {
            homeViewModel.getUserPlace()
            homeViewModel.transferUserData = { [weak self] () in
                let obj = self?.homeViewModel.userPlace
                self?.detailArr = obj ?? []
                print(self?.detailArr.count)
                print("======")
                self?.collectionView.reloadData()
            }
        }
    }

    
    func setupLayout() {
        
        mainStackView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
        
        sortButton.snp.makeConstraints({btn in
            btn.trailing.equalTo(mainStackView.snp.trailing).offset(-24)
            btn.top.equalTo(mainStackView.snp.top).offset(24)
        })
        
        collectionView.snp.makeConstraints({cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.top.equalToSuperview()
            cv.bottom.equalToSuperview()
        })
        
        mainStackView.bringSubviewToFront(sortButton)
    }
}


extension HomeDetailPlacesVC:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeDetailPlacesCell
        let object = detailArr[indexPath.row]
        cell.configure(object:object)
        return cell
    }
}


extension HomeDetailPlacesVC:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = detailArr[indexPath.row]
        self.checkVisit(placeId: place.id, place: place)
    }
}


extension HomeDetailPlacesVC {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
         
                return self?.makeListLayoutSection()
        }
    }
    
    
    func makeListLayoutSection() -> NSCollectionLayoutSection {
        

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.125))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
       
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 70, leading: 24, bottom: 0, trailing: 22)
        layoutSection.interGroupSpacing = 16
        
        
        return layoutSection
    }
}
