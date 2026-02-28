//
//  LoginView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginView: BaseView {
    
    var codeBlock: ((UIButton) -> Void)?
    
    var loginBlock: (() -> Void)?
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "login_head_image")
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "login_desc_image")
        descImageView.contentMode = .scaleAspectFit
        return descImageView
    }()
    
    lazy var enImageView: UIImageView = {
        let enImageView = UIImageView()
        let imageStr = LocalStr("login_en_desc_image")
        enImageView.image = UIImage(named: imageStr)
        enImageView.contentMode = .scaleAspectFit
        return enImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = LocalStr("Phone number")
        nameLabel.textColor = UIColor.init(hexString: "##333332")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return nameLabel
    }()
    
    lazy var phoneView: UIView = {
        let phoneView = UIView()
        phoneView.backgroundColor = UIColor.init(hexString: "#F6F7F9")
        phoneView.layer.cornerRadius = 28
        phoneView.layer.masksToBounds = true
        return phoneView
    }()
    
    lazy var phoneImageView: UIImageView = {
        let phoneImageView = UIImageView()
        let imageStr = LocalStr("login_en_phone_image")
        phoneImageView.image = UIImage(named: imageStr)
        phoneImageView.contentMode = .scaleAspectFit
        return phoneImageView
    }()
    
    lazy var phoneFiled: UITextField = {
        let phoneFiled = UITextField()
        phoneFiled.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: LocalStr("Enter phone number"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#ACACAE") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ])
        phoneFiled.attributedPlaceholder = attrString
        phoneFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        phoneFiled.textColor = UIColor.init(hexString: "#333332")
        phoneFiled.text = LoginManager.shared.getPhone()
        return phoneFiled
    }()
    
    lazy var codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.textAlignment = .left
        codeLabel.text = LocalStr("Verification code")
        codeLabel.textColor = UIColor.init(hexString: "##333332")
        codeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return codeLabel
    }()
    
    lazy var codeView: UIView = {
        let codeView = UIView()
        codeView.backgroundColor = UIColor.init(hexString: "#F6F7F9")
        codeView.layer.cornerRadius = 28
        codeView.layer.masksToBounds = true
        return codeView
    }()
    
    lazy var codeFiled: UITextField = {
        let codeFiled = UITextField()
        codeFiled.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: LocalStr("Enter verification code"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#ACACAE") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ])
        codeFiled.attributedPlaceholder = attrString
        codeFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        codeFiled.textColor = UIColor.init(hexString: "#333332")
        return codeFiled
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle(LocalStr("Get code"), for: .normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        codeBtn.backgroundColor = UIColor.init(hexString: "#1DBC79")
        codeBtn.layer.cornerRadius = 20
        codeBtn.layer.masksToBounds = true
        return codeBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle(LocalStr("Log in"), for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        loginBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        return loginBtn
    }()
    
    lazy var sureAgmBtn: UIButton = {
        let sureAgmBtn = UIButton(type: .custom)
        sureAgmBtn.isSelected = true
        sureAgmBtn.setImage(UIImage(named: "login_nor_btn_image"), for: .normal)
        sureAgmBtn.setImage(UIImage(named: "login_sel_btn_image"), for: .selected)
        return sureAgmBtn
    }()
    
    lazy var clickMentBtn: UIButton = {
        let clickMentBtn = UIButton(type: .custom)
        let imageStr = LocalStr("login_en_pr_image")
        clickMentBtn.setImage(UIImage(named: imageStr), for: .normal)
        clickMentBtn.adjustsImageWhenHighlighted = false
        return clickMentBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headImageView)
        addSubview(descImageView)
        addSubview(enImageView)
        addSubview(bgView)
        
        // MARK: - PHONE_VIEW
        bgView.addSubview(nameLabel)
        bgView.addSubview(phoneView)
        phoneView.addSubview(phoneImageView)
        phoneView.addSubview(phoneFiled)
        
        // MARK: - CODE_VIEW
        bgView.addSubview(codeLabel)
        bgView.addSubview(codeView)
        codeView.addSubview(codeFiled)
        codeView.addSubview(codeBtn)
        
        bgView.addSubview(loginBtn)
        bgView.addSubview(sureAgmBtn)
        bgView.addSubview(clickMentBtn)
        
        headImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(280.pix())
        }
        descImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25.pix())
            make.size.equalTo(CGSize(width: 318.pix(), height: 117.pix()))
        }
        enImageView.snp.makeConstraints { make in
            make.top.equalTo(descImageView.snp.bottom).offset(14.pix())
            make.centerX.equalToSuperview()
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(enImageView.snp.bottom).offset(16.pix())
            make.left.right.bottom.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        phoneView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.height.equalTo(52)
        }
        phoneImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 46, height: 20))
        }
        phoneFiled.snp.makeConstraints { make in
            make.left.equalTo(phoneImageView.snp.right).offset(12)
            make.right.bottom.top.equalToSuperview().inset(5)
        }
        
        codeLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        codeView.snp.makeConstraints { make in
            make.left.equalTo(codeLabel)
            make.centerX.equalToSuperview()
            make.top.equalTo(codeLabel.snp.bottom).offset(15)
            make.height.equalTo(52)
        }
        codeFiled.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-90)
        }
        codeBtn.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview().inset(6)
            make.width.equalTo(80.pix())
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeView.snp.bottom).offset(40)
            make.size.equalTo(CGSize(width: 327.pix(), height: 52.pix()))
        }
        
        sureAgmBtn.snp.makeConstraints { make in
            make.width.height.equalTo(14.pix())
            make.top.equalTo(loginBtn.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(24)
        }
        clickMentBtn.snp.makeConstraints { make in
            make.centerY.equalTo(sureAgmBtn)
            make.left.equalTo(sureAgmBtn.snp.right).offset(5)
        }
        
        sureAgmBtn
            .rx
            .tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                sureAgmBtn.isSelected.toggle()
            }).disposed(by: disposeBag)
        
        clickMentBtn
            .rx
            .tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                ToastManager.showLocalMessage("123")
            }).disposed(by: disposeBag)
        
        codeBtn
            .rx
            .tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.codeBlock?(codeBtn)
            }).disposed(by: disposeBag)
        
        loginBtn
            .rx
            .tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.loginBlock?()
            }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
