//
//  H5ViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import WebKit
import SnapKit
import RxSwift
import RxCocoa
import StoreKit

class H5ViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView(frame: .zero)
        return headView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "h5_head_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.progressTintColor = .systemBlue
        view.trackTintColor = .clear
        view.progress = 0
        return view
    }()
    
    private let locationManager = AppLocationManager()
    
    private let viewModel = AppViewModel()
    
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        userContentController.add(self, name: "acuarian")
        userContentController.add(self, name: "schemling")
        userContentController.add(self, name: "aud")
        userContentController.add(self, name: "passer")
        userContentController.add(self, name: "not")
        userContentController.add(self, name: "diation")
        
        config.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindWebView()
        loadURL()
    }
    
    @MainActor
    deinit {
        print("H5ViewController-----deinit")
    }
}

extension H5ViewController {
    
    private func setupUI() {
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(180.pix())
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

extension H5ViewController {
    
    private func bindWebView() {
        
        webView.rx.observe(String.self, "title")
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] title in
                self?.headView.nameLabel.text = title
            })
            .disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] progress in
                self?.progressView.alpha = 1
                self?.progressView.setProgress(Float(progress), animated: true)
                
                if progress >= 1.0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self?.progressView.alpha = 0
                        self?.progressView.progress = 0
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}

extension H5ViewController {
    
    private func loadURL() {
        if let url = URL(string: pageUrl.appendingQueryParameters(parameters: AppCommonParas.shared.toDictionary())) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

extension H5ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        
        switch message.name {
        case "acuarian":
            acuarian(message.body)
            
        case "schemling":
            schemling(message.body)
            
        case "aud":
            aud(message.body)
            
        case "passer":
            passer(message.body)
            
        case "not":
            not(message.body)
            
        case "diation":
            diation(message.body)
            
        default:
            break
        }
    }
}

extension H5ViewController {
    
    func acuarian(_ body: Any) {
        locationManager.requestLocation { result in }
        
        let listArray = body as? [String] ?? []
        let productID = listArray.first ?? ""
        let orderID = listArray.last ?? ""
        
        Task {
            do {
                let parameters = ["ennea": productID,
                                  "ticization": "9",
                                  "weightfier": orderID,
                                  "piain": String(Int(Date().timeIntervalSince1970)),
                                  "managementtic": String(Int(Date().timeIntervalSince1970))]
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                let _ = try await viewModel.uploadNamePointInfo(parameters: parameters)
            } catch {
                
            }
        }
        
    }
    
    func schemling(_ body: Any) {
        guard let pageUrl = body as? String, !pageUrl.isEmpty else {
            return
        }
        if pageUrl.contains(SchemeRouter.shared.schemeUrl) {
            SchemeRouter.shared.handle(urlString: pageUrl, vc: self)
        }else {
            let webVc = H5ViewController()
            webVc.pageUrl = pageUrl
            self.navigationController?.pushViewController(webVc, animated: true)
        }
    }
    
    func aud(_ body: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func passer(_ body: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
    }
    
    func not(_ body: Any) {
        guard let email = body as? String,
              !email.isEmpty else {
            return
        }
        
        let phone = LoginManager.shared.getPhone()
        let message = "Pinjam Cair: \(phone)"
        
        var components = URLComponents()
        components.scheme = "mailto"
        components.path = email
        components.queryItems = [
            URLQueryItem(name: "body", value: message)
        ]
        
        guard let url = components.url,
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    func diation(_ body: Any) {
        self.toRankAppStore()
    }
}

extension H5ViewController {
    
    func toRankAppStore() {
        guard #available(iOS 14.0, *),
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        SKStoreReviewController.requestReview(in: windowScene)
    }
    
}
