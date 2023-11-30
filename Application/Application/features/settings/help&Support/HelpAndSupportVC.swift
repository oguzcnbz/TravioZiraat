import UIKit
import SnapKit

class HelpAndSupportVC: UIViewController {
    
    var cells:[HelpAndSupportModel] = []
    var helpSupportModel = HelpSupportViewModel()
    
    //MARK: -- Components
    
    private lazy var mainStackView: DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var faqLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "FAQ"
        lbl.textColor = ColorStyle.primary.color
        lbl.font = FontStyle.h4.font
        return lbl
    }()
    
    private lazy var tableView:UITableView = {
        let tw = UITableView()
        tw.backgroundColor = .clear
        tw.separatorStyle = .none
        tw.register(HelpAndSupportCell.self, forCellReuseIdentifier: "HelpAndSupportCell")
        tw.dataSource = self
        tw.delegate = self
        tw.layer.cornerRadius = 80
        tw.layoutIfNeeded()
        tw.layer.maskedCorners = [.layerMinXMinYCorner]
        return tw
    }()
    
    
    //MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cells = helpSupportModel.getArr()
        setupViews()
        
        
        
    }
    
    //MARK: -- Setup
    
    func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubview(mainStackView)
        mainStackView.addSubviews(tableView)
        tableView.addSubview(faqLbl)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: "Help&Support")
        
        setupLayout()
    }
    
    //MARK: -- Layout
    
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
        
        tableView.snp.makeConstraints({cv in
            cv.leading.equalToSuperview()
            cv.trailing.equalToSuperview()
            cv.top.equalToSuperview()
            cv.bottom.equalToSuperview()
        })
        
    }
}

//MARK: -- Extensions

extension HelpAndSupportVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"HelpAndSupportCell", for: indexPath) as? HelpAndSupportCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let object = cells[indexPath.row]
        cell.configure(object: object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
}

extension HelpAndSupportVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return faqLbl
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cells[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
