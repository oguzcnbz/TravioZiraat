

import UIKit
import SnapKit
import MapKit

class PlaceDetailVC: UIViewController,PlaceDetailResponseDelegate {
    func placeDetailResponseGet(imageArr: [String]) {
        imagesUrlArr = imageArr
        pageControl.numberOfPages = imageArr.count
        self.collectionView.reloadData()
    }
    
    
    var placeModel:Place?
    
    //MARK: -- Properties
    var isPlaceSelected:Bool = false
    
    
//    var userss: [PlaceDetailModel] = [
//                                PlaceDetailModel(image: UIImage(named: "colleseum")),
//                                PlaceDetailModel(image: UIImage(named: "süleymaniyeCamii")),
//                                PlaceDetailModel(image: UIImage(named: "colleseum"))]
    
    var imagesUrlArr: [String] = []
    //lazy var placeDetailViewModel :PlaceDetailViewModel =
    
    //MARK: -- Views
    
    private lazy var pageControl: UIPageControl = {
           let pc = UIPageControl()
           pc.numberOfPages = imagesUrlArr.count
           pc.currentPage = 0
           pc.pageIndicatorTintColor = .gray
           pc.currentPageIndicatorTintColor = .black
           return pc
       }()
    
    private lazy var collectionView:UICollectionView = {
        
        let lay = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cv.register(PlaceDetailCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.contentInsetAdjustmentBehavior = .never
        cv.isScrollEnabled = false
        return cv
    }()
   
    
    private lazy var pageControlBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorStyle.background.color
        view.layer.cornerRadius = 12
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 20
        return view
    }()
    
    private lazy var saveIconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorStyle.primary.color
        view.layer.cornerRadius = 12
        return view
    }()
    private lazy var colView: UIView = {
        let view = UIView()
        return view
    }()
    private let labelCity: UILabel = {
        let label = UILabel()
        label.textColor = .label
      
        label.font = FontStyle.poppinsSemiBold(size: 30).font
        
        return label
    }()
    private let labelDate: UILabel = {
        let label = UILabel()
       
        label.font = FontStyle.poppinsMedium(size: 14).font
        
        return label
    }()
    private let labelAdedPerson: UILabel = {
        let label = UILabel()
        label.textColor = ColorStyle.greySpanish.color
        label.font = FontStyle.poppinsLight(size: 12).font
        
        return label
    }()
    private let labelPlaceDetail: UILabel = {
        let label = UILabel()
        label.textColor = .label
        //label.textAlignment = .left
        label.font = FontStyle.poppinsLight(size: 14).font
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor =  ColorStyle.background.color
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = ColorStyle.background.color
        return v
    }()
    private let imageViews: [UIImageView] = {
        var imageViews: [UIImageView] = []
        for x in 1...5 {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.image = UIImage(named: "Travio")
            iv.clipsToBounds = true
            imageViews.append(iv)
        }
        return imageViews
    }()
    
     lazy var placeSaveButon: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 12
        b.backgroundColor = ColorStyle.primary.color
        b.tintColor = ColorStyle.white.color
        var image = UIImage(named:"icPlaceDetailSave")
        b.setImage(image, for: .normal)
        b.addTarget(self, action: #selector(btnPlaceSaveTapped), for: .touchUpInside)
        return b
    }()
    
    private lazy var backButon: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 25
        b.backgroundColor = UIColor(hex: "3D3D3D").withAlphaComponent(0.5)
        b.tintColor = ColorStyle.white.color
        var image = UIImage(named: "backWard")
        b.setImage(image, for: .normal)
        b.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        return b
    }()
    
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: view.bounds)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.overrideUserInterfaceStyle = .dark
        map.delegate = self
        map.layer.cornerRadius = 12
        map.isScrollEnabled = false
        return map
    }()
    lazy var placeDetailViewModel: PlaceDetailViewModel = {
        return PlaceDetailViewModel()
    }()
    
    lazy var myvisits: MyVisitVC = {
        return MyVisitVC()
    }()
    
    
    //MARK: -- Component Actions
    
    @objc func btnPlaceSaveTapped() {
        if placeSaveButon.currentImage == UIImage(named: "icPlaceDetailSave") {
            placeSaveButon.setImage(UIImage(named: "icPlaceDetailSaveFill"), for: .normal)
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
            let formattedDateString = dateFormatter.string(from: currentDate)

            placeDetailViewModel.visitPost(placeId: placeModel?.id, visitedAt: formattedDateString)
            
            
        }
       else if  placeSaveButon.currentImage == UIImage(named: "icPlaceDetailSaveFill"){
            placeSaveButon.setImage(UIImage(named: "icPlaceDetailSave"), for: .normal)
            placeDetailViewModel.visitDelete(placeId: placeModel!.id)
        }
    }
    @objc func btnBackTapped(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        getDataPlaceDetail()
       getImagesUrl()
        setupViews()
    }
    //MARK: -- Component Actions
    func addPinsToMap(place: Place) {
       
        let location = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let newAnnotation = CustomAnnotation(coordinate: location, title: place.title, subtitle: place.place)
            mapView.addAnnotation(newAnnotation)
        
        
      
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        
    }
    
    //MARK: -- Private Methods
    private func getImagesUrl (){
        
        placeDetailViewModel.setDelegat(output: self)
        placeDetailViewModel.getAllImages(placeId: placeModel?.id ?? "")

    }
    
    
    private func getDataPlaceDetail (){
        labelCity.text = placeModel?.place
      //  print(placeModel)
        
        if let date = convertStringToDate(placeModel?.updatedAt ?? "") {
        //    print("Converted Date: \(date)")
            
            labelDate.text = convertDateToString(date)
           
        } else {
            print("Failed to convert the date.")
        }
        
       
        labelAdedPerson.text = placeModel?.creator
        labelPlaceDetail.text = placeModel?.description
       
        
        
        self.addPinsToMap(place: placeModel!)
        
    }
  private  func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.locale = Locale(identifier: "tr")

        return dateFormatter.date(from: dateString)
    }



    private func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "tr")

        return dateFormatter.string(from: date)
    }

    //MARK: -- UI Methods
    func setupViews() {
        self.view.backgroundColor = ColorStyle.background.color
        
        self.view.addSubview(colView)
        colView.addSubviews(collectionView,pageControlBackgroundView,placeSaveButon,backButon)
        pageControlBackgroundView.addSubview(pageControl)
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        contentView.addSubviews(labelCity,labelDate,labelAdedPerson,mapView,labelPlaceDetail)
        
        setupLayout()
    }
   
    
    private func setupLayout(){
        
        colView.snp.makeConstraints { cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.top.equalToSuperview()
            cv.height.equalToSuperview().multipliedBy(0.3)
        }
        collectionView.snp.makeConstraints { cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.top.equalToSuperview()
            cv.bottom.equalToSuperview()
          
        }
        

        pageControlBackgroundView.snp.makeConstraints { pcBgView in
                 pcBgView.centerX.equalToSuperview()
                pcBgView.bottom.equalToSuperview().offset(-30)
                pcBgView.height.equalTo(24)
                pcBgView.width.equalTo(64)
            }

            pageControl.snp.makeConstraints { pc in
                pc.center.equalTo(pageControlBackgroundView) // pageControl'ü arka planın ortasına hizaladık
            }
        
        placeSaveButon.snp.makeConstraints { pcBgView in
                
                pcBgView.top.equalToSuperview().offset(50)
            pcBgView.trailing.equalToSuperview().offset(-20)
                pcBgView.width.equalTo(50)
            pcBgView.height.equalTo(50)
            }
        backButon.snp.makeConstraints({ make in
        
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
            make.width.equalTo(50)
        make.height.equalTo(50)
            
            
            
        })
        
        
        
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(colView.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }
        
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(self.view)
        }
        
        labelCity.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        
        }
       
        labelDate.snp.makeConstraints { make in
            make.top.equalTo(labelCity.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        
        }
   
        labelAdedPerson.snp.makeConstraints { make in
            make.top.equalTo(labelDate.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        
        }
        mapView.snp.makeConstraints({mv in
            mv.top.equalTo(labelAdedPerson.snp.bottom).offset(9)
            mv.leading.equalToSuperview().offset(16)
            mv.trailing.equalToSuperview().offset(-16)
            mv.height.equalTo(227)
        })
        
        labelPlaceDetail.snp.makeConstraints({make in
            make.top.equalTo(mapView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(contentView)
            
            
        })
        
        
        
        
//        for (index, imageView) in imageViews.enumerated() {
//            contentView.addSubview(imageView)
//            imageView.snp.makeConstraints { make in
//                make.leading.trailing.equalTo(contentView).inset(10)
//                make.height.equalTo(300)
//                if index == 0 {
//                    make.top.equalTo(contentView)
//                } else {
//                    make.top.equalTo(imageViews[index - 1].snp.bottom)
//                }
//                if index == imageViews.count - 1 {
//                    make.bottom.equalTo(contentView)
//                }
//            }
//        }
        
        
    }
}

    
extension PlaceDetailVC:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUrlArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlaceDetailCell
        let object = imagesUrlArr[indexPath.row]
        cell.configure(object:object)
        
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
      //  printContent(currentIndex)
        pageControl.currentPage = currentIndex
        
    }
}
extension PlaceDetailVC {
    func didChangeCollectionViewPage() {
        
        
    }
    
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
        
        layoutSection.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
                guard let self = self,
                      let itemWidth = items.last?.bounds.width else { return }
                let page = round(offset.x / (itemWidth + layoutSection.interGroupSpacing))
                
            pageControl.currentPage = Int(page)
            }
        
        
        
        
        return layoutSection
    }
}


extension PlaceDetailVC :MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let customAnnotation = annotation as? CustomAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomAnnotation")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: customAnnotation, reuseIdentifier: "CustomAnnotation")
            annotationView!.canShowCallout = true
        }
        
        annotationView!.image = UIImage(named: "pin")
        return annotationView
    }
    
    
}
