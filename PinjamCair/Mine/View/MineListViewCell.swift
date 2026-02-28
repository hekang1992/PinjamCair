//
//  MineListViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/26.
//

import UIKit
import SnapKit
import Kingfisher

class MineListViewCell: UITableViewCell {
    
    var model: dorsallyModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.genlike ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.rusbadior ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var aImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.image = UIImage(named: "cn_arrow_image")
        return aImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return nameLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(aImageView)
        bgView.addSubview(nameLabel)
        bgView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(44.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24.pix())
            make.left.equalToSuperview().offset(29)
        }
        aImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 9, height: 14))
            make.right.equalToSuperview().offset(-28)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
