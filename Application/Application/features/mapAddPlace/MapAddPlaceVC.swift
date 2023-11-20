
import UIKit
import SnapKit

protocol Deneme:AnyObject{
    func deneme(title: String, message: String)
}

class MapAddPlaceVC: UIViewController {
    var latitude:Double?
    var longitude: Double?
    
    var imageArray: [UIImage?] = [nil,nil,nil]
    let hasImgArr:[Bool] = [false,false,false]
    
    var hasMapAdedclosure: ((Bool)->Void)?
    private var hasLoading = false
    
    
    
    private lazy var stick: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "D9D9D9")
        v.layer.cornerRadius = 6
        return v
    }()
    
     lazy var placeName: CustomTextField = {
        let sv = CustomTextField(labelText: "Place Name", textFieldPlaceholder: "Please write a place name")
        return sv
    }()
    
     lazy var visitDescription: CustomTextView = {
        let sv = CustomTextView(labelText:"Visit Description", textViewPlaceholder:"Please write a visit description" )
        return sv
    }()
    
     lazy var countryCity: CustomTextField = {
        let sv = CustomTextField(labelText: "Country,City", textFieldPlaceholder: "Please write country and city")
        return sv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MapAddPlaceCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.dataSource = self
        return cv
    }()
    
    private lazy var btnaddPlace: DefaultButton = {
        let btn = DefaultButton(title: "Add Place", background: .primary)
        btn.addTarget(self, action: #selector(btnAddPlaceTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func btnAddPlaceTapped() {
        let placePostModel = PlacePostModel(place: countryCity.defaultTextField.text ?? "", title: placeName.defaultTextField.text ?? "", description: visitDescription.defaultTextView.text, coverImageURL: "", latitude: latitude ?? 0, longitude: longitude ?? 0)
        
        
        print(placePostModel)
        let filterImg = imageArray.compactMap(({ $0 }))
       // print(filterImg.count)
        
        if filterImg.count > 0 { 
            let mapAddPlaceViewModel = MapAddPlaceViewModel()
             mapAddPlaceViewModel.addPlace(imageArray: filterImg,model: placePostModel)
            self.dismiss(animated: true, completion: {
             //   print("Bu sayfa kapatıldı.")
            })
        }
        
        
     //   let mapAddPlaceViewModel = MapAddPlaceViewModel()
//        mapAddPlaceViewModel.placeCreate(model: placePostModel, imgUrl: "https://storage.googleapis.com/travio/1700048457958660859.jpg")
         
    }
    
    func showControlAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
            self.dismiss(animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor(hex: "F8F8F8")
        self.view.layer.cornerRadius = 24
        view.addSubviews(stick,placeName,visitDescription,countryCity, collectionView,btnaddPlace)
        setupLayout()
    }
    
    func deneme(){
        
    }
    
    private func setupLayout() {
        
        stick.snp.makeConstraints({s in
            s.centerX.equalToSuperview()
            s.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            s.width.equalTo(70)
            s.height.equalTo(8)
        })
        
        placeName.snp.makeConstraints {sv in
            sv.leading.equalToSuperview().offset(23)
            sv.trailing.equalToSuperview().offset(-25)
            sv.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
            sv.height.equalTo(74)
        }
        
        visitDescription.snp.makeConstraints {sv in
            sv.leading.equalToSuperview().offset(23)
            sv.trailing.equalToSuperview().offset(-25)
            sv.top.equalTo(placeName.snp.bottom).offset(16)
            sv.height.equalTo(215)
        }
        
        countryCity.snp.makeConstraints {sv in
            sv.leading.equalToSuperview().offset(23)
            sv.trailing.equalToSuperview().offset(-25)
            sv.top.equalTo(visitDescription.snp.bottom).offset(16)
            sv.height.equalTo(74)
        }
        
        collectionView.snp.makeConstraints { cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.height.equalTo(275)
            cv.top.equalTo(countryCity.snp.bottom).offset(-20)
        }
        
        btnaddPlace.snp.makeConstraints({btn in
            btn.leading.equalToSuperview().offset(23)
            btn.trailing.equalToSuperview().offset(-25)
            btn.bottom.equalToSuperview().offset(-24)
            btn.height.equalTo(54)
        })
    }

   
}

extension MapAddPlaceVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MapAddPlaceCell
        cell.delegate = self
      
        cell.closure = { image in
            self.imageArray[indexPath.row] = image
      
          
        }
       
    
        return cell
    }
}

extension MapAddPlaceVC {
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            return self?.makeSliderLayoutSection()
        }
    }
    
    func makeSliderLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 36, leading: 24, bottom: 40, trailing: 18)
        layoutSection.interGroupSpacing = 18
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        
        return layoutSection
    }
}

extension MapAddPlaceVC:Deneme{
    func deneme(title: String, message: String) {
        self.showControlAlert(title: title, message: message)
    }
}

