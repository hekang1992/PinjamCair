//
//  KtpView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class KtpView: BaseView {
    
    var cancelBlock: (() -> Void)?
    
    var sureBlock: (() -> Void)?
    
    var timeBlock: ((UITextField) -> Void)?
    
    var model: casiaModel? {
        didSet {
            guard let model = model else { return }
            oneFiled.text = model.throwality ?? ""
            twoFiled.text = model.languageate ?? ""
            var time = model.supportsion ?? ""
            threeFiled.text = time == "//" ? "" : time
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "ktp_ale_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = LocalStr("Confirm again")
        nameLabel.textColor = UIColor.init(hexString: "#0B3F29")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.text = LocalStr("Real name")
        oneLabel.textColor = UIColor.init(hexString: "#333332")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return oneLabel
    }()
    
    lazy var oneFiled: UITextField = {
        let oneFiled = UITextField()
        oneFiled.backgroundColor = UIColor.init(hexString: "#F6F7F9")
        oneFiled.placeholder = LocalStr("Real name")
        oneFiled.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        oneFiled.textColor = UIColor.init(hexString: "#333332")
        oneFiled.layer.cornerRadius = 24
        oneFiled.layer.masksToBounds = true
        oneFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 10))
        oneFiled.leftViewMode = .always
        return oneFiled
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.text = LocalStr("PAN number")
        twoLabel.textColor = UIColor.init(hexString: "#333332")
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return twoLabel
    }()
    
    lazy var twoFiled: UITextField = {
        let twoFiled = UITextField()
        twoFiled.backgroundColor = UIColor.init(hexString: "#F6F7F9")
        twoFiled.placeholder = LocalStr("PAN number")
        twoFiled.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        twoFiled.textColor = UIColor.init(hexString: "#333332")
        twoFiled.layer.cornerRadius = 24
        twoFiled.layer.masksToBounds = true
        twoFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 10))
        twoFiled.leftViewMode = .always
        return twoFiled
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.text = LocalStr("Date of birth")
        threeLabel.textColor = UIColor.init(hexString: "#333332")
        threeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return threeLabel
    }()
    
    lazy var threeFiled: UITextField = {
        let threeFiled = UITextField()
        threeFiled.backgroundColor = UIColor.init(hexString: "#F6F7F9")
        threeFiled.placeholder = LocalStr("Date of birth")
        threeFiled.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        threeFiled.textColor = UIColor.init(hexString: "#333332")
        threeFiled.layer.cornerRadius = 24
        threeFiled.layer.masksToBounds = true
        threeFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 10))
        threeFiled.leftViewMode = .always
        threeFiled.isEnabled = false
        return threeFiled
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.setTitle(LocalStr("Confirm"), for: .normal)
        confirmBtn.setTitleColor(.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        confirmBtn.backgroundColor = UIColor.init(hexString: "#1DBC79")
        confirmBtn.layer.cornerRadius = 24
        confirmBtn.layer.masksToBounds = true
        return confirmBtn
    }()
    
    lazy var timeBtn: UIButton = {
        let timeBtn = UIButton(type: .custom)
        return timeBtn
    }()
    
    lazy var aImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.image = UIImage(named: "bl_a_ar_image")
        return aImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(cancelBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 552.pix()))
        }
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(34.pix())
        }
        
        bgImageView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(31.pix())
            make.left.equalToSuperview().inset(24)
        }
        
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(oneFiled)
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(41.pix())
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        oneFiled.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(oneLabel)
            make.top.equalTo(oneLabel.snp.bottom).offset(12.pix())
            make.height.equalTo(48)
        }
        
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(twoFiled)
        
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneFiled.snp.bottom).offset(16.pix())
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        twoFiled.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(oneFiled)
            make.top.equalTo(twoLabel.snp.bottom).offset(12.pix())
            make.height.equalTo(48)
        }
        
        bgImageView.addSubview(threeLabel)
        bgImageView.addSubview(threeFiled)
        
        threeLabel.snp.makeConstraints { make in
            make.top.equalTo(twoFiled.snp.bottom).offset(16.pix())
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        threeFiled.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(oneFiled)
            make.top.equalTo(threeLabel.snp.bottom).offset(12.pix())
            make.height.equalTo(48)
        }
        
        bgImageView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { make in
            make.top.equalTo(threeFiled.snp.bottom).offset(42.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 283.pix(), height: 48))
        }
        
        threeFiled.addSubview(aImageView)
        aImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
            make.right.equalToSuperview().offset(-20)
        }
        
        bgImageView.addSubview(timeBtn)
        timeBtn.snp.makeConstraints { make in
            make.edges.equalTo(threeFiled)
        }
        
        bindTap()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension KtpView {
    
    private func bindTap() {
        
        cancelBtn
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cancelBlock?()
            }).disposed(by: disposeBag)
        
        confirmBtn
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.sureBlock?()
            }).disposed(by: disposeBag)
        
        timeBtn
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.timeBlock?(threeFiled)
            }).disposed(by: disposeBag)
    }
}
