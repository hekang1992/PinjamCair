//
//  OrderView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OrderListView: BaseView {
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        return nameLabel
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    var tapClick: ((UILabel) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView)
        addSubview(nameLabel)
        addSubview(clickBtn)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(48)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.height.equalTo(16)
        }
        clickBtn.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(70)
            make.bottom.equalToSuperview()
        }
        
        bindTap()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OrderListView {
    
    private func bindTap() {
        clickBtn
            .rx
            .tap
            .throttle(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.tapClick?(nameLabel)
            }).disposed(by: disposeBag)
    }
    
}
