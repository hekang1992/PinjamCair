//
//  SettingViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import TYAlertController

class SettingViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "h5_head_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView(frame: .zero)
        headView.nameLabel.text = LocalStr("Settings")
        return headView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "cn_slo_image")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "Pinjam Cair"
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return nameLabel
    }()
    
    lazy var vLabel: UILabel = {
        let vLabel = UILabel()
        vLabel.textAlignment = .left
        let vStr = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        vLabel.text = "\(LocalStr("Version")): \(vStr)"
        vLabel.textColor = UIColor.init(hexString: "#000000")
        vLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return vLabel
    }()
    
    lazy var grayView: UIView = {
        let grayView = UIView()
        grayView.backgroundColor = UIColor.init(hexString: "#F6F7F9")
        grayView.layer.cornerRadius = 22
        grayView.layer.masksToBounds = true
        grayView.isUserInteractionEnabled = true
        return grayView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.text = LocalStr("Log out")
        descLabel.textColor = UIColor.init(hexString: "#333332")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return descLabel
    }()
    
    lazy var aImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.image = UIImage(named: "cn_arrow_image")
        aImageView.contentMode = .scaleAspectFit
        return aImageView
    }()
    
    lazy var deleteLabel: UILabel = {
        let deleteLabel = UILabel()
        deleteLabel.textAlignment = .center
        deleteLabel.text = "Cancel account"
        deleteLabel.textColor = UIColor.init(hexString: "#000000")
        deleteLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        deleteLabel.isUserInteractionEnabled = true
        return deleteLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 1
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = UIColor.init(hexString: "#000000")
        return lineView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
        
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(60)
        }
        
        bgView.addSubview(nameLabel)
        bgView.addSubview(vLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(16)
            make.top.equalTo(logoImageView).offset(5)
            make.height.equalTo(20)
        }
        
        vLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(16)
            make.bottom.equalTo(logoImageView).offset(-5)
            make.height.equalTo(20)
        }
        
        view.addSubview(grayView)
        grayView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 50.pix()))
        }
        
        grayView.addSubview(descLabel)
        grayView.addSubview(aImageView)
        
        descLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(40)
        }
        
        aImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
            make.size.equalTo(CGSize(width: 9, height: 14))
        }
        
        view.addSubview(deleteLabel)
        deleteLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(18)
        }
        
        deleteLabel.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        headView.backBlock = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        deleteLabel.isHidden = LanguageManager.shared.currentType == .indonesian
        
        bindTap()
    }
    
}

extension SettingViewController {
    
    private func bindTap() {
        
        grayView
            .rx
            .tapGesture()
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.logoutInfo()
            }).disposed(by: disposeBag)
        
        deleteLabel
            .rx
            .tapGesture()
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.deleteInfo()
            }).disposed(by: disposeBag)
        
    }
    
}

extension SettingViewController {
    
    private func logoutInfo() {
        let logoutView = LogouView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: logoutView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        logoutView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        logoutView.sureBlock = { [weak self] in
            guard let self = self else { return }
            Task { [weak self] in
                do {
                    let model = try await self?.viewModel.logoutInfo()
                    let ectopurposeess = model?.ectopurposeess ?? ""
                    if ["0", "00"].contains(ectopurposeess) {
                        self?.dismiss(animated: true)
                        LoginManager.shared.deleteLoginInfo()
                        await MainActor.run {
                            ToastManager.showLocalMessage(model?.urgth ?? "")
                            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
                        }
                    }
                } catch {
                    
                }
            }
        }
        
        
    }
    
    private func deleteInfo() {
        let deleteView = DeleteView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: deleteView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        deleteView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        deleteView.sureBlock = { [weak self] in
            guard let self = self else { return }
            if deleteView.sureAgmBtn.isSelected == false {
                ToastManager.showLocalMessage("Please read and confirm the agreement first")
                return
            }
            
            Task { [weak self] in
                do {
                    let model = try await self?.viewModel.deleteInfo()
                    let ectopurposeess = model?.ectopurposeess ?? ""
                    if ["0", "00"].contains(ectopurposeess) {
                        self?.dismiss(animated: true)
                        LoginManager.shared.deleteLoginInfo()
                        await MainActor.run {
                            ToastManager.showLocalMessage(model?.urgth ?? "")
                            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
                        }
                    }
                } catch {
                    
                }
            }
        }
    }
    
}
