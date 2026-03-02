//
//  OrderListViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/3/2.
//

import UIKit
import SnapKit
import Kingfisher

class OrderListViewCell: UITableViewCell {
    
    var model: dipsiauousModel? {
        didSet{
            guard let model = model else { return }
            let logoUrl = model.adduous ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.shareian ?? ""
            
            let modelArray = model.singfy ?? []
            
            let oneModel = modelArray.first ?? singfyModel()
            let twoModel = modelArray.last ?? singfyModel()
            
            oneLabel.text = oneModel.herself ?? ""
            twoLabel.text = oneModel.tvarium ?? ""
            threeLabel.text = (twoModel.herself ?? "") + ": " + (twoModel.tvarium ?? "")
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#F6F7F9")
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
        nameLabel.textAlignment = .right
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#B2B3B4")
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hexString: "#000000")
        twoLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.textColor = UIColor.init(hexString: "#000000")
        threeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return threeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(logoImageView)
        bgView.addSubview(oneLabel)
        bgView.addSubview(twoLabel)
        bgView.addSubview(threeLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(136)
            make.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(15)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(nameLabel.snp.left).offset(-8)
            make.width.height.equalTo(24)
        }
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(20)
        }
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(30)
        }
        threeLabel.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
