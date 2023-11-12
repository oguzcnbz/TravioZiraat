
import UIKit
import TinyConstraints
import SnapKit



class MyAddedPlacesVC: UIViewController {
    
    
    var userss: [PlacesModel] = [
        PlacesModel(image: UIImage(named: "colleseumMini"), name: "Selimiye Camii",place: "Rome"),
        PlacesModel(image: UIImage(named: "süleymaniyeCamii"), name: "Süleymaniye Camii",place: "Rome"),
        PlacesModel(image: UIImage(named: "colleseumMini"), name: "Fatih Camii",place: "Rome"),
        PlacesModel(image: UIImage(named: "colleseumMini"), name: "Colleseum",place: "Rome"),
        PlacesModel(image: UIImage(named: "colleseumMini"), name: "Colleseum",place: "Rome"),
        PlacesModel(image: UIImage(named: "colleseumMini"), name: "Colleseum",place: "Rome"),
        PlacesModel(image: UIImage(named: "colleseumMini"), name: "Colleseum",place: "Rome"),
        PlacesModel(image: UIImage(named: "colleseumMini"), name: "Colleseum",place: "Rome")]
    
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

        return cv
    }()
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var headLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hex: "FFFFFF")
        lbl.text = "Popular Places"
        lbl.font = FontStyle.poppinsSemiBold(size: 36).font
        lbl.sizeToFit()
        return lbl
    }()
    
    private lazy var sortButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "sortAZ"), for: .normal)
        b.addTarget(self, action: #selector(btnSortTapped), for: .touchUpInside)
        return b
    }()
    
    @objc func btnSortTapped() {
        if sortButton.currentImage == UIImage(named: "sortAZ") {
            detailArr.sort { $0.title < $1.title }
            sortButton.setImage(UIImage(named: "sortZA"), for: .normal)
            
        } else {
            detailArr.sort { $0.title > $1.title }
            sortButton.setImage(UIImage(named: "sortAZ"), for: .normal)
        }
        collectionView.reloadData()
    }

    //MARK: -- Views
   
    
    //MARK: -- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetail()
       setupViews()
    }
    
  
    
    //MARK: -- UI Methods
    func setupViews() {
        self.view.backgroundColor = UIColor(hex: "38ada9")
        self.view.addSubview(mainStackView)
        mainStackView.addSubviews(sortButton,collectionView)
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: "My Added Places")
     
        setupLayout()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

      
    }
    @objc func rightbartapped(){
        self.navigationController?.popViewController(animated: true)
    }
    private func getDetail (){
       
        
        homeViewModel.getPopulerPlace()
        homeViewModel.transferData = { [weak self] () in
            let obj = self?.homeViewModel.populerPlace
            self?.detailArr = obj ?? []
            print(self?.detailArr.count)
            print("======")
            self?.collectionView.reloadData()

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



extension MyAddedPlacesVC:UICollectionViewDataSource {
    
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


extension MyAddedPlacesVC {
    
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

