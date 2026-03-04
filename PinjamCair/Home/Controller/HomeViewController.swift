//
//  HomeViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit
import MJRefresh
import AppTrackingTransparency
import FBSDKCoreKit
import DeviceKit
import CoreLocation

class HomeViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    private let languageCode = LanguageManager.shared.currentType
    
    private let judicianeity = "1001"
    private let crimeo = "1000"
    private let myrithoughtature = "1000"
    
    private let locationManager = AppLocationManager()
    
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
    
    lazy var maxView: EndMaxView = {
        let maxView = EndMaxView(frame: .zero)
        maxView.isHidden = true
        return maxView
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
        
        view.addSubview(maxView)
        maxView.snp.makeConstraints { make in
            make.top.equalTo(messageListView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        enView.tapProductBlock = { [weak self] productId in
            Task {
                await self?.clickCardProductInfo(productID: productId)
            }
        }
        
        enView.tapTermsBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if LoginManager.shared.isLoggedIn() {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }else {
                let loginVc = LoginViewController()
                let rootVc = AppNavigationController(rootViewController: loginVc)
                rootVc.modalPresentationStyle = .overFullScreen
                self.present(rootVc, animated: true)
            }
        }
        
        enView.privacyBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if LoginManager.shared.isLoggedIn() {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }else {
                let loginVc = LoginViewController()
                let rootVc = AppNavigationController(rootViewController: loginVc)
                rootVc.modalPresentationStyle = .overFullScreen
                self.present(rootVc, animated: true)
            }
        }
        
        enView.leftBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if LoginManager.shared.isLoggedIn() {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }else {
                let loginVc = LoginViewController()
                let rootVc = AppNavigationController(rootViewController: loginVc)
                rootVc.modalPresentationStyle = .overFullScreen
                self.present(rootVc, animated: true)
            }
        }
        
        enView.rightBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if LoginManager.shared.isLoggedIn() {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }else {
                let loginVc = LoginViewController()
                let rootVc = AppNavigationController(rootViewController: loginVc)
                rootVc.modalPresentationStyle = .overFullScreen
                self.present(rootVc, animated: true)
            }
        }
        
        
        endView.privacyBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if LoginManager.shared.isLoggedIn() {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }else {
                let loginVc = LoginViewController()
                let rootVc = AppNavigationController(rootViewController: loginVc)
                rootVc.modalPresentationStyle = .overFullScreen
                self.present(rootVc, animated: true)
            }
        }
        
        endView.leftBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if LoginManager.shared.isLoggedIn() {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }else {
                let loginVc = LoginViewController()
                let rootVc = AppNavigationController(rootViewController: loginVc)
                rootVc.modalPresentationStyle = .overFullScreen
                self.present(rootVc, animated: true)
            }
        }
        
        endView.rightBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if LoginManager.shared.isLoggedIn() {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }else {
                let loginVc = LoginViewController()
                let rootVc = AppNavigationController(rootViewController: loginVc)
                rootVc.modalPresentationStyle = .overFullScreen
                self.present(rootVc, animated: true)
            }
        }
        
        endView.tapProductBlock = { [weak self] productId in
            Task {
                await self?.clickCardProductInfo(productID: productId)
            }
        }
        
        maxView.tapProductBlock = { [weak self] productId in
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
        
        maxView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            Task { [weak self] in
                await self?.homeInfo()
            }
        })
        
        messageListView.serviceBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if LoginManager.shared.isLoggedIn() {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }else {
                let loginVc = LoginViewController()
                let rootVc = AppNavigationController(rootViewController: loginVc)
                rootVc.modalPresentationStyle = .overFullScreen
                self.present(rootVc, animated: true)
            }
        }
        
        maxView.tapBannerBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if pageUrl.contains(SchemeRouter.shared.schemeUrl) {
                SchemeRouter.shared.handle(urlString: pageUrl, vc: self)
            }else {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }
        }
        
        if LoginManager.shared.isLoggedIn() {
            locationManager.requestLocation { result in }
            
            let status = CLLocationManager().authorizationStatus
            if languageCode == .indonesian {
                if status == .restricted || status == .denied {
                    ShowAlertManager.showAlert()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { [weak self] in
            await self?.homeInfo()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            await self.getAppIDFA()
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
                self.maxView.tableView.mj_header?.endRefreshing()
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
                    self.maxView.isHidden = true
                    enView.isHidden = languageCode != .english
                    endView.isHidden = languageCode == .english
                }else if let _ = modelArray.first(where: { $0.emesive == "emetolawyeran" }) {
                    self.enView.isHidden = true
                    self.endView.isHidden = true
                    self.maxView.isHidden = false
                    self.maxView.model = model
                }
            }
        } catch {
            await MainActor.run {
                self.enView.scrollView.mj_header?.endRefreshing()
                self.endView.scrollView.mj_header?.endRefreshing()
                self.maxView.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
}

extension HomeViewController {
    
    private func clickCardProductInfo(productID: String) async {
        
        if LoginManager.shared.isLoggedIn() == false {
            let loginVc = LoginViewController()
            let rootVc = AppNavigationController(rootViewController: loginVc)
            rootVc.modalPresentationStyle = .overFullScreen
            self.present(rootVc, animated: true)
        }else {
            
            if languageCode == .indonesian {
                locationManager.requestLocation { [weak self] result in
                    
                    Task {
                        do {
                            let _ = try await self?.viewModel.uploadLocationInfo(parameters: result)
                        } catch {
                            
                        }
                    }
                    
                }
                
                DeviceInfoManager.shared.buildFullDeviceJSON { [weak self] json in
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                        let base64String = jsonData.base64EncodedString()
                        Task {
                            do {
                                let parameters = ["casia": base64String]
                                let _ = try await self?.viewModel.uploadDeviceInfo(parameters: parameters)
                            } catch {
                                
                            }
                        }
                    } catch {
                        print("JSON: \(error)")
                    }
                }
                
                Task {
                    let onetime = UserDefaults.standard.object(forKey: "onetime") as? String ?? ""
                    let twotime = UserDefaults.standard.object(forKey: "twotime") as? String ?? ""
                    
                    guard !onetime.isEmpty, !twotime.isEmpty else {
                        return
                    }
                    
                    do {
                        let parameters = ["ennea": "",
                                          "ticization": "1",
                                          "weightfier": "",
                                          "piain": onetime,
                                          "managementtic": twotime]
                        let model = try await self.viewModel.uploadNamePointInfo(parameters: parameters)
                        let ectopurposeess = model.ectopurposeess ?? ""
                        if ["0", "00"].contains(ectopurposeess) {
                            UserDefaults.standard.removeObject(forKey: "onetime")
                            UserDefaults.standard.removeObject(forKey: "twotime")
                        }
                    } catch {
                        
                    }
                }
                
            }
            
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
        
        
        
        //        let status = CLLocationManager().authorizationStatus
        //        if status == .notDetermined {
        //            locationManager.requestLocation { result in
        //                if LoginManager.shared.isLoggedIn() == false {
        //                    let loginVc = LoginViewController()
        //                    let rootVc = AppNavigationController(rootViewController: loginVc)
        //                    rootVc.modalPresentationStyle = .overFullScreen
        //                    self.present(rootVc, animated: true)
        //                }
        //            }
        //        }else {
        //            if LoginManager.shared.isLoggedIn() == false {
        //                let loginVc = LoginViewController()
        //                let rootVc = AppNavigationController(rootViewController: loginVc)
        //                rootVc.modalPresentationStyle = .overFullScreen
        //                self.present(rootVc, animated: true)
        //            }else {
        //                let status = CLLocationManager().authorizationStatus
        //                if languageCode == .indonesian {
        //                    if status == .restricted || status == .denied {
        //                        ShowAlertManager.showAlert()
        //                        return
        //                    }
        //                }
        //
        //                if languageCode == .indonesian {
        //                    locationManager.requestLocation { [weak self] result in
        //
        //                        Task {
        //                            do {
        //                                let _ = try await self?.viewModel.uploadLocationInfo(parameters: result)
        //                            } catch {
        //
        //                            }
        //                        }
        //
        //                    }
        //
        //                    DeviceInfoManager.shared.buildFullDeviceJSON { [weak self] json in
        //                        do {
        //                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        //                            let base64String = jsonData.base64EncodedString()
        //                            Task {
        //                                do {
        //                                    let parameters = ["casia": base64String]
        //                                    let _ = try await self?.viewModel.uploadDeviceInfo(parameters: parameters)
        //                                } catch {
        //
        //                                }
        //                            }
        //                        } catch {
        //                            print("JSON: \(error)")
        //                        }
        //                    }
        //
        //                    Task {
        //                        let onetime = UserDefaults.standard.object(forKey: "onetime") as? String ?? ""
        //                        let twotime = UserDefaults.standard.object(forKey: "twotime") as? String ?? ""
        //
        //                        guard !onetime.isEmpty, !twotime.isEmpty else {
        //                            return
        //                        }
        //
        //                        do {
        //                            let parameters = ["ennea": "",
        //                                              "ticization": "1",
        //                                              "weightfier": "",
        //                                              "piain": onetime,
        //                                              "managementtic": twotime]
        //                            let model = try await self.viewModel.uploadNamePointInfo(parameters: parameters)
        //                            let ectopurposeess = model.ectopurposeess ?? ""
        //                            if ["0", "00"].contains(ectopurposeess) {
        //                                UserDefaults.standard.removeObject(forKey: "onetime")
        //                                UserDefaults.standard.removeObject(forKey: "twotime")
        //                            }
        //                        } catch {
        //
        //                        }
        //                    }
        //
        //                }
        //
        //                do {
        //                    let parameters = ["judicianeity": judicianeity,
        //                                      "crimeo": crimeo,
        //                                      "myrithoughtature": myrithoughtature,
        //                                      "hoplcy": productID]
        //                    let model = try await viewModel.clickProductInfo(parameters: parameters)
        //                    let ectopurposeess = model.ectopurposeess ?? ""
        //                    if ["0", "00"].contains(ectopurposeess) {
        //                        let pageUrl = model.casia?.feliee ?? ""
        //                        if pageUrl.contains(SchemeRouter.shared.schemeUrl) {
        //                            SchemeRouter.shared.handle(urlString: pageUrl, vc: self)
        //                        }else {
        //                            let webVc = H5ViewController()
        //                            webVc.pageUrl = pageUrl
        //                            self.navigationController?.pushViewController(webVc, animated: true)
        //                        }
        //                    }else if ectopurposeess == "-2" {
        //                        await MainActor.run {
        //                            ToastManager.showLocalMessage(model.urgth ?? "")
        //                            LoginManager.shared.deleteLoginInfo()
        //                            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
        //                        }
        //                    }else {
        //                        ToastManager.showLocalMessage(model.urgth ?? "")
        //                    }
        //                } catch {
        //
        //                }
        //            }
        //        }
    }
    
}

extension HomeViewController {
    
    private func getAppIDFA() async {
        guard #available(iOS 14, *) else { return }
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let status = await ATTrackingManager.requestTrackingAuthorization()
        
        switch status {
        case .authorized, .denied, .notDetermined:
            Task {
                //                await uploadIDFAInfo()
            }
            
        case .restricted:
            break
            
        @unknown default:
            break
        }
        
    }
    
    private func uploadIDFAInfo() async {
        let idfaStr = IDFVKeychainManager.shared.getIDFA()
        let idfvStr = IDFVKeychainManager.shared.getIDFV()
        let itselfion = Device.current.cpu.description
        let parameters = ["healtheous": idfvStr, "animal": idfaStr, "itselfion": itselfion]
        do {
            let model = try await viewModel.uploadGoogleInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                if let sorbModel = model.casia?.sorb {
                    self.configFacebookSDK(with: sorbModel)
                }
            }
        } catch {
            
        }
    }
    
    func configFacebookSDK(with model: sorbModel) {
        Settings.shared.appID = model.hearability ?? ""
        Settings.shared.clientToken = model.narren ?? ""
        Settings.shared.displayName = model.subjectatory ?? ""
        Settings.shared.appURLSchemeSuffix = model.transress ?? ""
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
    }
    
}
