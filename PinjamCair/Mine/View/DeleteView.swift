//
//  DeleteView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DeleteView: BaseView {
        
    var cancelBlock: (() -> Void)?
    
    var sureBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "mine_del_image")
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
    
    lazy var sureAgmBtn: UIButton = {
        let sureAgmBtn = UIButton(type: .custom)
        sureAgmBtn.setImage(UIImage(named: "login_nor_btn_image"), for: .normal)
        sureAgmBtn.setImage(UIImage(named: "login_sel_btn_image"), for: .selected)
        return sureAgmBtn
    }()
    
    lazy var mentLabel: UILabel = {
        let mentLabel = UILabel()
        mentLabel.textAlignment = .left
        mentLabel.text = "I have read and agree to the above"
        mentLabel.textColor = UIColor.init(hexString: "#000000")
        mentLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return mentLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(sureAgmBtn)
        bgImageView.addSubview(mentLabel)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.addSubview(threeBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 525.pix()))
        }
        
        sureAgmBtn.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(262.pix())
        }
        
        mentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sureAgmBtn)
            make.left.equalTo(sureAgmBtn.snp.right).offset(8)
            make.height.equalTo(20)
        }
        
        oneBtn.snp.makeConstraints { make in
            make.top.equalTo(mentLabel.snp.bottom).offset(16.pix())
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

extension DeleteView {
    
    private func bindTap() {
        
        sureAgmBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                sureAgmBtn.isSelected.toggle()
            }).disposed(by: disposeBag)
        
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
