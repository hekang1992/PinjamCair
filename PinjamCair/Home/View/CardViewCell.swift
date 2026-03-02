//
//  CardViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/3/2.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import Kingfisher

class CardViewCell: UITableViewCell {
    
    var model: notdropalityModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.adduous ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.shareian ?? ""
            
            listView.oneLabel.text = model.autoesque ?? ""
            listView.twoLabel.text = model.phrenious ?? ""
            
            let one = (model.townaire ?? "") + "    "
            let two = "    " + (model.nauo ?? "")
            listView.rateLabel.text = String(format: "%@|%@", one, two)
            
            applyBtn.setTitle(model.employeesome ?? "", for: .normal)
            
        }
    }
    
    var tapProductBlock: ((String) -> Void)?
    
    private let disposeBag = DisposeBag()

    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "td_home_me_image")
        oneImageView.contentMode = .scaleAspectFit
        return oneImageView
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
    
    lazy var listView: CardListView = {
        let listView = CardListView()
        return listView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        applyBtn.setBackgroundImage(UIImage(named: "app_home_me_image"), for: .normal)
        applyBtn.isUserInteractionEnabled = false
        applyBtn.titleEdgeInsets = UIEdgeInsets(top: 5.pix(), left: 0, bottom: 0, right: 0)
        return applyBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(oneImageView)
        oneImageView.addSubview(logoImageView)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(listView)
        oneImageView.addSubview(applyBtn)
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 308.pix()))
            make.bottom.equalToSuperview().offset(-12)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(60.pix())
            make.height.width.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        listView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(106.pix())
        }
        
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(listView.snp.bottom).offset(14.pix())
            make.size.equalTo(CGSize(width: 305.pix(), height: 64.pix()))
        }
        
        oneImageView
            .rx
            .tapGesture()
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .when(.recognized)
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
