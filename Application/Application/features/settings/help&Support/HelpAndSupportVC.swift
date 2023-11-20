import UIKit
import SnapKit

class HelpAndSupportVC: UIViewController {
    
    private var selectedIndexPath: IndexPath?
    private var isExpanded: Bool = false
    
    private lazy var expandedHeight: CGFloat = 160
    private lazy var collapsedHeight: CGFloat = 60

    var cells:[HelpAndSupportModel] = [HelpAndSupportModel(questionLbl: "How can I create a new account on Travio?", answerLbl: ""),
                                       HelpAndSupportModel(questionLbl: "How can I create a new account on Travio?", answerLbl: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                                       HelpAndSupportModel(questionLbl: "How does Travio work?", answerLbl: ""),
                                       HelpAndSupportModel(questionLbl: "How does Travio work?", answerLbl: ""),
                                       HelpAndSupportModel(questionLbl: "How does Travio work?", answerLbl: ""),
                                       HelpAndSupportModel(questionLbl: "How does Travio work?", answerLbl: "")]
    
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var faqLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "FAQ"
        lbl.textColor = ColorStyle.primary.color
        lbl.font = FontStyle.poppinsSemiBold(size: 24).font
        return lbl
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
       
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 85, left: 24, bottom: 0, right: 24)
        cv.register(HelpAndSupportCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 80
        cv.layoutIfNeeded()
        cv.layer.maskedCorners = [.layerMinXMinYCorner]
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       setupViews()

    }

    func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubview(mainStackView)
        mainStackView.addSubviews(faqLbl,collectionView)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: "Help&Support")
        
        setupLayout()
    }
      func setupLayout(){
          
          mainStackView.snp.makeConstraints { v in
              v.leading.equalToSuperview()
              v.trailing.equalToSuperview()
              v.bottom.equalToSuperview()
              v.height.equalToSuperview().multipliedBy(0.82)
          }
          
          faqLbl.snp.makeConstraints({lbl in
              lbl.top.equalToSuperview().offset(44)
              lbl.leading.equalToSuperview().offset(24)
          })

          collectionView.snp.makeConstraints({cv in
              cv.leading.equalToSuperview()
              cv.trailing.equalToSuperview()
              cv.top.equalToSuperview()
              cv.bottom.equalToSuperview()
          })

        }
}

extension HelpAndSupportVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            let isExpanded = selectedIndexPath == indexPath
        return CGSize(width: (collectionView.bounds.width - 48), height: isExpanded  ? expandedHeight : collapsedHeight)
           
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HelpAndSupportCell
           
           if let selectedIndexPath = selectedIndexPath, selectedIndexPath != indexPath {
           let previousCell = collectionView.cellForItem(at: selectedIndexPath) as? HelpAndSupportCell
           previousCell?.updateVector(imageName: "arrowGreenDown")
           }

           if selectedIndexPath == indexPath {
              
               selectedIndexPath = nil
               cell?.updateVector(imageName: "arrowGreenDown")
           } else {

               selectedIndexPath = indexPath
               cell?.updateVector(imageName: "arrowGreenUp")
           }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    
}
extension HelpAndSupportVC:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HelpAndSupportCell
        
        let object = cells[indexPath.row]
            cell.configure(object:object)
            return cell
        }
}





