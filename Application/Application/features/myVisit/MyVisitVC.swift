import UIKit
import TinyConstraints
import SnapKit


class MyVisitVC: UIViewController {
    
    // MARK: -- Properties
    
    var visits: [MyVisits] = []
    lazy var visitViewModel: MyVisitsViewModel = MyVisitsViewModel()
    
    // MARK: -- Components
    
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
        cv.delegate = self
        return cv
    }()
    
    // MARK: -- Private Methods
    
    func getData() {
        visitViewModel.visitsGet()
        visitViewModel.transferData = { [weak self] () in
            let obj = self?.visitViewModel.visitPlaces
            self?.visits = obj ?? []
            self?.collectionView.reloadData()
        }
        showResult()
    }
    
    
    func showResult(){
        visitViewModel.showAlertClosure = {message in
            self.resultAlert(title: message.0, message: message.1)
        }
    }
    
    // MARK: -- Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupViews()
    }
    
    // MARK: -- View Setup
    
    private func setupViews(){
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubviews(mainView)
        mainView.addSubview(collectionView)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        setNavigationItems(leftBarButton: false, rightBarButton: nil, title: "My Visits")
        setupLayout()
    }
    
    // MARK: -- View Layout
    
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

// MARK: -- Extension
extension MyVisitVC:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyVisitsCell
        let object = visits[indexPath.row]
        cell.configure(object:object)
        
        return cell
    }
    
}

extension MyVisitVC:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = visits[indexPath.row].place
        let vc = PlaceDetailVC()
        vc.placeModel = place
        self.navigationController?.pushViewController(vc, animated: true)}
}

extension MyVisitVC {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            
            return self?.makeListLayoutSection()
        }
    }
    
    
    
    func makeListLayoutSection() -> NSCollectionLayoutSection {
        
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.57))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
        
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 45, leading: 16, bottom: 0, trailing: 16)
        layoutSection.interGroupSpacing = 16
        
        return layoutSection
    }
}
