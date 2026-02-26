//
//  LoginViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit
import FBSDKCoreKit
import AppTrackingTransparency
import DeviceKit

class LoginViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var loginView: LoginView = {
        let loginView = LoginView(frame: .zero)
        return loginView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            await self.getAppIDFA()
        }
    }
    
}

extension LoginViewController {
    
    private func getAppIDFA() async {
        guard #available(iOS 14, *) else { return }
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let status = await ATTrackingManager.requestTrackingAuthorization()
        
        switch status {
        case .authorized, .denied, .notDetermined:
            Task {
                await uploadIDFAInfo()
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
