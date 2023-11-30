import UIKit
import TinyConstraints
import SnapKit
import WebKit


class AboutVC: UIViewController {
    
    //MARK: -- Components
    
    private lazy var mainStackView:DefaultMainStackView = {
        let sv = DefaultMainStackView()
        return sv
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.layer.cornerRadius = 80
        webView.layoutIfNeeded()
        webView.layer.maskedCorners = [.layerMinXMinYCorner]
        webView.layer.masksToBounds = true
        webView.navigationDelegate = self
        return webView
    }()
    
    //MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadWebViewContent()
    }
    
    //MARK: -- Private Methods
    
    func loadWebViewContent() {
        if let url = URL(string: "https://api.iosclass.live/about") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    //MARK: -- Setup
    
    func setupViews() {
        self.view.backgroundColor = ColorStyle.primary.color
        self.view.addSubviews(mainStackView)
        mainStackView.addSubview(webView)
        setupLayout()
        setNavigationItems(leftBarButton: true, rightBarButton: nil, title: "About Us")
    }
    
    //MARK: -- Layout
    
    func setupLayout() {
        mainStackView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.bottom.equalToSuperview()
            v.height.equalToSuperview().multipliedBy(0.82)
        }
        
        webView.snp.makeConstraints { v in
            v.leading.equalToSuperview()
            v.trailing.equalToSuperview()
            v.top.equalToSuperview()
            v.bottom.equalToSuperview()
            
        }
    }
}

//MARK: -- Extensions

extension AboutVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let backgroundColorCode = "document.body.style.backgroundColor = '#FFFFFF';"
        webView.evaluateJavaScript(backgroundColorCode)
        
        let jsCode = """
            var style = document.createElement('style');
            style.innerHTML = 'body { font-family: "Poppins", sans-serif; padding-top: 24px; }';
            document.head.appendChild(style);
        """
        webView.evaluateJavaScript(jsCode)
        
        let h1Styles = """
            var h1Elements = document.querySelectorAll('h1');
            for (var i = 0; i < h1Elements.length; i++) {
                h1Elements[i].style.fontFamily = 'Poppins-Bold, sans-serif';
                h1Elements[i].style.fontSize = '28px';
                h1Elements[i].style.color = 'black';
            }
        """
        webView.evaluateJavaScript(h1Styles)
        
        let pStyles = """
            var pElements = document.querySelectorAll('p');
            for (var i = 0; i < pElements.length; i++) {
                pElements[i].style.fontFamily = 'Poppins-Regular, sans-serif';
                pElements[i].style.fontSize = '16px';
                pElements[i].style.color = 'black';
            }
        """
        webView.evaluateJavaScript(pStyles)
    }
}
