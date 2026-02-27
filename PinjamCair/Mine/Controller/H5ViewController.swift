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
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindWebView()
        loadURL()
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

extension H5ViewController: WKNavigationDelegate {
    
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
        // TODO: 实现
    }
    
    func schemling(_ body: Any) {
        // TODO: 实现
    }
    
    func aud(_ body: Any) {
        // TODO: 实现
    }
    
    func passer(_ body: Any) {
        // TODO: 实现
    }
    
    func not(_ body: Any) {
        // TODO: 实现
    }
    
    func diation(_ body: Any) {
        // TODO: 实现
    }
}
