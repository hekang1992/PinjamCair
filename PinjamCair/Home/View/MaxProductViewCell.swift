//
//  MaxProductViewCell.swift
//  PinjamCair
//
//  Created by Ryan Thomas on 2026/3/2.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa
import RxGesture

class MaxProductViewCell: UITableViewCell {
    
    var model: notdropalityModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.adduous ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.shareian ?? ""
            
            oneLabel.text = model.phrenious ?? ""
            twoLabel.text = model.autoesque ?? ""
            
            let sense = model.sense ?? ""
            typeLabel.backgroundColor = UIColor.init(hexString: sense)
            typeLabel.text = model.employeesome ?? ""
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var tapProductBlock: ((String) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 8
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#000000")
        oneLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hexString: "#000000")
        twoLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return twoLabel
    }()
    
    lazy var typeLabel: PaddingLabel = {
        let typeLabel = PaddingLabel()
        typeLabel.textAlignment = .center
        typeLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        typeLabel.layer.cornerRadius = 20
        typeLabel.layer.masksToBounds = true
        return typeLabel
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(116)
            make.bottom.equalToSuperview().offset(-12)
        }
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(oneLabel)
        bgView.addSubview(twoLabel)
        bgView.addSubview(typeLabel)
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.height.equalTo(16)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(oneLabel.snp.bottom).offset(2)
            make.height.equalTo(20)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clickBtn
            .rx
            .tap
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let self = self, let model = model else { return }
                let productId = String(model.stochacity ?? 0)
                self.tapProductBlock?(productId)
            }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PaddingLabel: UILabel {
    
    var textInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + textInsets.left + textInsets.right
        let height = size.height + textInsets.top + textInsets.bottom
        return CGSize(width: width, height: height)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let sizeThatFits = super.sizeThatFits(size)
        let width = sizeThatFits.width + textInsets.left + textInsets.right
        let height = sizeThatFits.height + textInsets.top + textInsets.bottom
        return CGSize(width: width, height: height)
    }
}
