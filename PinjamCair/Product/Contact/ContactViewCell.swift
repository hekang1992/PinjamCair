//
//  ContactViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ContactViewCell: UITableViewCell {

    var model: dipsiauousModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.herself ?? ""
            oneFiled.placeholder = model.relationship_placeholder ?? ""
            twoFiled.placeholder = model.contact_placeholder ?? ""
            
        }
    }
    
    private let disposeBag = DisposeBag()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#000000")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return oneLabel
    }()
    
    lazy var oneFiled: UITextField = {
        let oneFiled = UITextField()
        oneFiled.backgroundColor = UIColor.init(hexString: "#F6F7F9")
        oneFiled.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        oneFiled.textColor = UIColor.init(hexString: "#000000")
        oneFiled.layer.cornerRadius = 24
        oneFiled.layer.masksToBounds = true
        oneFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 10))
        oneFiled.leftViewMode = .always
        oneFiled.isSelected = false
        return oneFiled
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    lazy var aImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.image = UIImage(named: "bl_a_ar_image")
        return aImageView
    }()
    
    var clickTapBlock: (() -> Void)?
    
    lazy var twoFiled: UITextField = {
        let twoFiled = UITextField()
        twoFiled.backgroundColor = UIColor.init(hexString: "#F6F7F9")
        twoFiled.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        twoFiled.textColor = UIColor.init(hexString: "#000000")
        twoFiled.layer.cornerRadius = 24
        twoFiled.layer.masksToBounds = true
        twoFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 10))
        twoFiled.leftViewMode = .always
        twoFiled.isSelected = false
        return twoFiled
    }()
    
    lazy var clickTwoBtn: UIButton = {
        let clickTwoBtn = UIButton(type: .custom)
        return clickTwoBtn
    }()
    
    lazy var bImageView: UIImageView = {
        let bImageView = UIImageView()
        bImageView.image = UIImage(named: "two_ph_a_image")
        return bImageView
    }()
    
    var clickTwoTapBlock: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(oneLabel)
        contentView.addSubview(oneFiled)
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(14)
        }
        oneFiled.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(oneLabel.snp.bottom).offset(12.pix())
            make.height.equalTo(48)
        }
        
        oneFiled.addSubview(aImageView)
        contentView.addSubview(clickBtn)
        
        aImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
            make.right.equalToSuperview().offset(-20)
        }
        
        clickBtn.snp.makeConstraints { make in
            make.top.equalTo(oneLabel)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(oneFiled)
        }
        
        contentView.addSubview(twoFiled)
        twoFiled.addSubview(bImageView)
        contentView.addSubview(clickTwoBtn)
        
        twoFiled.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(oneFiled)
            make.top.equalTo(oneFiled.snp.bottom).offset(12.pix())
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        bImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
            make.right.equalToSuperview().offset(-20)
        }
        
        clickTwoBtn.snp.makeConstraints { make in
            make.top.equalTo(oneFiled.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(twoFiled)
        }
        
        bindTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ContactViewCell {
    
    private func bindTap() {
        
        clickBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.clickTapBlock?()
            }).disposed(by: disposeBag)
        
        clickTwoBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.clickTwoTapBlock?()
            }).disposed(by: disposeBag)
        
    }
    
}
