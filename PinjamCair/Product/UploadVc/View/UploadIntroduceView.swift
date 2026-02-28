//
//  UploadIntroduceView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class UploadIntroduceView: BaseView {
    
    var cancelBlock: (() -> Void)?
    var sureBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        return sureBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        return cancelBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 512.pix()))
        }
        
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(sureBtn)
        
        cancelBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.height.equalTo(32.pix())
        }
        sureBtn.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.bottom.equalTo(cancelBtn.snp.top)
        }
        
        bindTap()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UploadIntroduceView {
    
    private func bindTap() {
        cancelBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.cancelBlock?()
        }).disposed(by: disposeBag)
        
        sureBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.sureBlock?()
        }).disposed(by: disposeBag)
    }
    
}
