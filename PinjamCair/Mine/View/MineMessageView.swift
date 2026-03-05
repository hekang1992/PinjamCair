//
//  MineMessageView.swift
//  PinjamCair
//
//  Created by Ryan Thomas on 2026/2/26.
//

import UIKit
import SnapKit

class MineMessageView: BaseView {
    
    var serviceBlock: ((String) -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "cn_p_logo_image")
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        let phone = desensitizePhoneSimple(LoginManager.shared.getPhone())
        let token = LoginManager.shared.getToken()
        nameLabel.text = "\(LocalStr("Hi"))，\(token.isEmpty ? LocalStr("Please log in") : phone)"
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.text = LocalStr("Secure loan services")
        descLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return descLabel
    }()
    
    lazy var serviceBtn: UIButton = {
        let serviceBtn = UIButton(type: .custom)
        serviceBtn.setBackgroundImage(UIImage(named: "cn_ser_image"), for: .normal)
        serviceBtn.addTarget(self, action: #selector(serviceBtnClick), for: .touchUpInside)
        return serviceBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(nameLabel)
        addSubview(descLabel)
        addSubview(serviceBtn)
        bgImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(55)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(bgImageView).offset(5)
            make.left.equalTo(bgImageView.snp.right).offset(12)
            make.height.equalTo(20)
        }
        descLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-2)
            make.left.equalTo(nameLabel)
            make.height.equalTo(20)
        }
        serviceBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MineMessageView {
    
    @objc func serviceBtnClick() {
        self.serviceBlock?(base_h5_url + "/cephalward")
    }
    
}
