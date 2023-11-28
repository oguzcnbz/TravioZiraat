import UIKit
import MapKit
import SnapKit


class MapVC: UIViewController {
    
    // MARK: - Properties
    
    var places: [Place] = []
    
    lazy var mapViewModel: MapViewModel = MapViewModel()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: view.bounds)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.overrideUserInterfaceStyle = .dark
        map.delegate = self
        return map
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(MapCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        cv.contentInsetAdjustmentBehavior = .never
        cv.isScrollEnabled = false
        return cv
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        return gesture
    }()
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupViews()
        
    }
    
    private func setupViews() {
        view.addSubviews(mapView, collectionView)
        mapView.addGestureRecognizer(longPressGesture)
        
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.bottom.equalToSuperview().offset(-10)
            cv.height.equalTo(220)
        }
    }
    
    // MARK: - Map Methods
    
    func addPinsToMap(array: [Place]) {
        for place in array {
            let location = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            let newAnnotation = CustomAnnotation(coordinate: location, title: place.title, subtitle: place.place)
            mapView.addAnnotation(newAnnotation)
        }
        
        if let firstPlace = array.first {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: firstPlace.latitude, longitude: firstPlace.longitude), latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
          
            let touchPoint = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

            
            let mapAddPlaceVC = MapAddPlaceVC()
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Hata: \(error)")
                } else if let placemark = placemarks?.first {
                    if let country = placemark.country, let city = placemark.locality {
                        let address = "\(country), \(city)"
                                           
                        mapAddPlaceVC.latitude = location.coordinate.latitude
                        mapAddPlaceVC.longitude = location.coordinate.longitude
                        mapAddPlaceVC.countryCity.defaultTextField.text = address
                        
                    
                       self.present(mapAddPlaceVC, animated: true, completion: nil)
                    }
                }
            }
           mapAddPlaceVC.hasMapAdedclosure =  {
               
                           let newAnnotation = CustomAnnotation(coordinate: coordinate, title: mapAddPlaceVC.placeName.defaultTextField.text, subtitle: mapAddPlaceVC.countryCity.defaultTextField.text)
               self.mapView.addAnnotation(newAnnotation)
               self.getData()
           }

        }
    }
    
    
    // MARK: - Data Methods
    
    private func getData() {
            mapViewModel.getAllPlace()
            mapViewModel.transferData = { [weak self] () in
                self?.addPinsToMap(array: [])
                let obj = self?.mapViewModel.allPlace
                self?.places = obj ?? []
                self?.collectionView.reloadData()
                self?.addPinsToMap(array: self!.places)
                print("pin ekledi")
            }
        }
    }

// MARK: - CollectionView DataSource
extension MapVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MapCell
        let object = places[indexPath.row]
        cell.configure(object: object)
        return cell
    }
}

// MARK: - CollectionView Layout
extension MapVC {
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] _, _ in
            return self?.makeSliderLayoutSection()
        }
    }
    
    func makeSliderLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.5))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        layoutSection.interGroupSpacing = 18
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        
        return layoutSection
    }
}

// MARK: - CollectionView Delegate
extension MapVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlace = places[indexPath.row]
        
        if let annotation = mapView.annotations.first(where: { $0.coordinate.latitude == selectedPlace.latitude && $0.coordinate.longitude == selectedPlace.longitude }) as? CustomAnnotation {
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
            mapView.selectAnnotation(annotation, animated: true)
        }
        let place = places[indexPath.row]
        let vc = PlaceDetailVC()
        vc.placeModel = place
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MapVC :MKMapViewDelegate{
    
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? CustomAnnotation,
           let index = places.firstIndex(where: { $0.latitude == annotation.coordinate.latitude && $0.longitude == annotation.coordinate.longitude }) {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }
    }
}
