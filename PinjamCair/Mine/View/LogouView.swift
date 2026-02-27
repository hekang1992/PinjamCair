//
//  LogouView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LogouView: BaseView {
        
    var cancelBlock: (() -> Void)?
    
    var sureBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: LocalStr("log_out_image"))
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.addSubview(threeBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 482.pix()))
        }
        
        oneBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(243.pix())
            make.left.right.equalToSuperview()
            make.height.equalTo(48.pix())
        }
        
        twoBtn.snp.makeConstraints { make in
            make.top.equalTo(oneBtn.snp.bottom).offset(24.pix())
            make.left.right.equalToSuperview()
            make.height.equalTo(48.pix())
        }
        
        threeBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(32.pix())
        }
        
        bindTap()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LogouView {
    
    private func bindTap() {
        
        oneBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cancelBlock?()
            }).disposed(by: disposeBag)
        
        twoBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.sureBlock?()
            }).disposed(by: disposeBag)
        
        threeBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cancelBlock?()
            }).disposed(by: disposeBag)
        
        
    }
    
}
