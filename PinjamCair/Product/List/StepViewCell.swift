//
//  StepViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import SnapKit
import Kingfisher

class StepViewCell: UITableViewCell {
    
    var model: mrerModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.systemeur ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.rusbadior ?? ""
            descLabel.text = model.larggovernmenton ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#1DBC79")
        return bgView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.layer.cornerRadius = 12
        whiteView.layer.masksToBounds = true
        whiteView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return whiteView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        logoImageView.backgroundColor = .systemPink
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#B2B2B2")
        descLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return descLabel
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .center
        typeLabel.textColor = UIColor.white
        typeLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        typeLabel.text = LocalStr("Go")
        return typeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(bgView)
        bgView.addSubview(whiteView)
        whiteView.addSubview(logoImageView)
        whiteView.addSubview(nameLabel)
        whiteView.addSubview(descLabel)
        bgView.addSubview(typeLabel)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 86.pix()))
            make.bottom.equalToSuperview().offset(-12)
        }
        whiteView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-64.pix())
        }
        typeLabel.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(whiteView.snp.right)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView).offset(1)
            make.left.equalTo(logoImageView.snp.right).offset(16)
            make.height.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(logoImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
