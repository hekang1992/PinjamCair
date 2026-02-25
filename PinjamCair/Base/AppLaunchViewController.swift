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
        
        NetworkMonitor.shared.startListening()
        
        NotificationCenter.default.addObserver(forName: .networkChanged, object: nil, queue: .main) { notification in
            if let type = notification.userInfo?["type"] as? NetworkMonitor.ConnectionType {
                switch type {
                case .wifi, .cellular:
                    self.getDoubleInfo()
                    
                case .unavailable:
                    print("NONE=======")
                }
            }
        }
        
    }
    
}

extension AppLaunchViewController {
    
    private func getDoubleInfo() {
        Task { [weak self] in
            guard let self = self else { return }
            
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await self.getAppLaunchInfo()
                }
                group.addTask {
                    await self.getAddressInfo()
                }
            }
            
            await MainActor.run {
                NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
            }
        }
    }
    
    private func getAppLaunchInfo() async {
        do {
            let parameters = ["size": String(Device.current.diagonal),
                              "pallioacle": "1"]
            let model = try await viewModel.getAppLaunchInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                let languaceCode = model.casia?.sagacain ?? ""
                LanguageManager.shared.configure(with: languaceCode)
            }
        } catch {
            
        }
    }
    
    private func getAddressInfo() async {
        do {
            let model = try await viewModel.getAddressInfo()
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                
            }
        } catch {
            
        }
    }
    
}

