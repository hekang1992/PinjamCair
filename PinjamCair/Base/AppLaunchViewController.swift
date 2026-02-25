//
//  AppLaunchViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import DeviceKit
import SnapKit
import RxCocoa
import RxSwift

class AppLaunchViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var tryBtn: UIButton = {
        let tryBtn = UIButton(type: .custom)
        tryBtn.isHidden = true
        let imageStr = LanguageManager.shared.currentType == .indonesian ? "try_id_image" : "try_en_image"
        tryBtn.setBackgroundImage(UIImage(named: imageStr), for: .normal)
        return tryBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(tryBtn)
        tryBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.size.equalTo(CGSize(width: 200, height: 48))
        }
        
        tryBtn
            .rx
            .tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.getDoubleInfo()
            }).disposed(by: disposeBag)
        
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
//                    await self.getAddressInfo()
                }
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
                await MainActor.run {
                    NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
                }
            }else {
                self.tryBtn.isHidden = false
            }
        } catch {
            self.tryBtn.isHidden = false
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

