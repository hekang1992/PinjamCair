//
//  LoginViewController.swift
//  PinjamCair
//
//  Created by Ryan Thomas on 2026/2/24.
//

import UIKit
import SnapKit
import DeviceKit

class LoginViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    private var countdownTimer: DispatchSourceTimer?
    
    private var remainingSeconds: Int = 60
    
    private let locationManager = AppLocationManager()
    
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
        
        loginView.codeBlock = { [weak self] codeBtn in
            guard let self = self else { return }
            self.clickCode(codeBtn: codeBtn)
        }
        
        loginView.loginBlock = { [weak self] in
            guard let self = self else { return }
            Task { [weak self] in
                await self?.login()
            }
        }
        
        loginView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        loginView.oneBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            let webVc = H5ViewController()
            webVc.pageUrl = pageUrl
            self.navigationController?.pushViewController(webVc, animated: true)
        }
        
        let onetime = String(Int(Date().timeIntervalSince1970))
        UserDefaults.standard.set(onetime, forKey: "onetime")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginView.phoneFiled.becomeFirstResponder()
        Task {
            try await Task.sleep(nanoseconds: 300_000_000)
            locationManager.requestLocation { result in }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.loginView.codeFiled.resignFirstResponder()
        self.loginView.phoneFiled.resignFirstResponder()
    }
    
    @MainActor
    deinit {
        countdownTimer?.cancel()
        countdownTimer = nil
    }
    
}

// MARK: - LOGIN_INFO
extension LoginViewController {
    
    private func login() async {
        let twotime = String(Int(Date().timeIntervalSince1970))
        UserDefaults.standard.set(twotime, forKey: "twotime")
        
        let phone = self.loginView.phoneFiled.text ?? ""
        let code = self.loginView.codeFiled.text ?? ""
        let isGrand = self.loginView.sureAgmBtn.isSelected
        self.loginView.phoneFiled.resignFirstResponder()
        self.loginView.codeFiled.resignFirstResponder()
        if phone.isEmpty {
            ToastManager.showLocalMessage("Enter phone number")
            return
        }
        
        if code.isEmpty {
            ToastManager.showLocalMessage("Enter verification code")
            return
        }
        
        if isGrand == false {
            ToastManager.showLocalMessage("Please read and confirm the agreement")
            return
        }
        
        do {
            let parameters = ["station": phone,
                              "omphalacle": code,
                              "ogile": Device.current.description]
            let model = try await viewModel.toLoginInfo(parameters: parameters)
            await MainActor.run {
                ToastManager.showLocalMessage(model.urgth ?? "")
            }
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                let phone = model.casia?.station ?? ""
                let token = model.casia?.maliion ?? ""
                LoginManager.shared.saveLoginInfo(phone: phone, token: token)
                NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
            }
        } catch {
            
        }
    }
    
    private func clickCode(codeBtn: UIButton) {
        let phone = self.loginView.phoneFiled.text ?? ""
        
        if phone.isEmpty {
            ToastManager.showLocalMessage("Enter phone number")
            return
        }
        
        Task { [weak self] in
            let parameters = ["exoality": phone]
            await self?.getCodeInfo(parameters: parameters, codeBtn: codeBtn)
        }
        
    }
    
    private func getCodeInfo(parameters: [String: String], codeBtn: UIButton) async {
        do {
            let model = try await viewModel.getCodeInfo(parameters: parameters)
            ToastManager.showLocalMessage(model.urgth ?? "")
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                self.sucCodeInfo(codeBtn: codeBtn)
            }
        } catch {
            
        }
    }
    
    private func sucCodeInfo(codeBtn: UIButton) {
        self.loginView.codeFiled.becomeFirstResponder()
        codeBtn.isEnabled = false
        remainingSeconds = 60
        codeBtn.setTitle("\(remainingSeconds)s", for: .normal)
        
        countdownTimer?.cancel()
        countdownTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        
        countdownTimer?.schedule(deadline: .now(), repeating: 1.0)
        
        countdownTimer?.setEventHandler { [weak self, weak codeBtn] in
            guard let self = self else { return }
            
            if self.remainingSeconds <= 0 {
                self.countdownTimer?.cancel()
                self.countdownTimer = nil
                
                DispatchQueue.main.async {
                    codeBtn?.isEnabled = true
                    codeBtn?.setTitle(LocalStr("Get code"), for: .normal)
                }
            } else {
                self.remainingSeconds -= 1
                
                DispatchQueue.main.async {
                    codeBtn?.setTitle("\(self.remainingSeconds)s", for: .normal)
                }
            }
        }
        
        countdownTimer?.resume()
    }
    
}
