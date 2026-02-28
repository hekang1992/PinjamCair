//
//  HomeViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit
import MJRefresh

class HomeViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    private let languageCode = LanguageManager.shared.currentType
    
    private let judicianeity = "1001"
    private let crimeo = "1000"
    private let myrithoughtature = "1000"
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "home_head_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var messageListView: MineMessageView = {
        let messageListView = MineMessageView()
        messageListView.nameLabel.textColor = .black
        messageListView.descLabel.textColor = UIColor.init(hexString: "#AAAAAA")
        if let image = UIImage(named: "cn_ser_image") {
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            messageListView.serviceBtn.setImage(tintedImage, for: .normal)
            messageListView.serviceBtn.tintColor = .black
        }
        return messageListView
    }()
    
    lazy var enView: EnView = {
        let enView = EnView(frame: .zero)
        enView.isHidden = true
        return enView
    }()
    
    lazy var endView: EndView = {
        let endView = EndView(frame: .zero)
        endView.isHidden = true
        return endView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "#E7FDE3")
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(282.pix())
        }
        
        view.addSubview(messageListView)
        messageListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
        view.addSubview(enView)
        enView.snp.makeConstraints { make in
            make.top.equalTo(messageListView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(endView)
        endView.snp.makeConstraints { make in
            make.top.equalTo(messageListView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        enView.isHidden = languageCode != .english
        endView.isHidden = languageCode == .english
        
        enView.tapProductBlock = { [weak self] productId in
            Task {
                await self?.clickCardProductInfo(productID: productId)
            }
        }
        
        endView.tapProductBlock = { [weak self] productId in
            Task {
                await self?.clickCardProductInfo(productID: productId)
            }
        }
        
        enView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            Task { [weak self] in
                await self?.homeInfo()
            }
        })
        
        endView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            Task { [weak self] in
                await self?.homeInfo()
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { [weak self] in
            await self?.homeInfo()
        }
    }
    
}

extension HomeViewController {
    
    private func homeInfo() async {
        do {
            let model = try await viewModel.getHomeInfo()
            await MainActor.run {
                self.enView.scrollView.mj_header?.endRefreshing()
                self.endView.scrollView.mj_header?.endRefreshing()
            }
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                let modelArray = model.casia?.dipsiauous ?? []
                if let oneModel = modelArray.first(where: { $0.emesive == "supraal" }) {
                    if languageCode == .english {
                        enView.model = oneModel.notdropality?.first
                    }else {
                        endView.model = oneModel.notdropality?.first
                    }
                    return
                }
            }
        } catch {
            await MainActor.run {
                self.enView.scrollView.mj_header?.endRefreshing()
                self.endView.scrollView.mj_header?.endRefreshing()
            }
        }
    }
    
}

extension HomeViewController {
    
    private func clickCardProductInfo(productID: String) async {
        do {
            let parameters = ["judicianeity": judicianeity,
                              "crimeo": crimeo,
                              "myrithoughtature": myrithoughtature,
                              "hoplcy": productID]
            let model = try await viewModel.clickProductInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                let pageUrl = model.casia?.feliee ?? ""
                if pageUrl.contains(SchemeRouter.shared.schemeUrl) {
                    SchemeRouter.shared.handle(urlString: pageUrl, vc: self)
                }else {
                    let webVc = H5ViewController()
                    webVc.pageUrl = pageUrl
                    self.navigationController?.pushViewController(webVc, animated: true)
                }
            }else if ectopurposeess == "-2" {
                await MainActor.run {
                    ToastManager.showLocalMessage(model.urgth ?? "")
                    LoginManager.shared.deleteLoginInfo()
                    NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
                }
            }else {
                ToastManager.showLocalMessage(model.urgth ?? "")
            }
        } catch {
            
        }
    }
    
}
