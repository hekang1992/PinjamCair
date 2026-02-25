//
//  AppLaunchViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import DeviceKit

class AppLaunchViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task { [weak self] in
            await self?.getAppLaunchInfo()
        }
    }
    
}

extension AppLaunchViewController {
    
    private func getAppLaunchInfo() async {
        do {
            let parameters = ["size": String(Device.current.diagonal),
                              "pallioacle": "1"]
            let model = try await viewModel.getAppLaunchInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                let languaceCode = model.casia?.sagacain ?? ""
                LanguageManager.setLanguage(from: languaceCode)
            }
        } catch {
            
        }
    }
    
}
