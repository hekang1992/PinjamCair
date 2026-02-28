//
//  AuthListViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
import SnapKit

class AuthListViewCell: UITableViewCell {
    
    var model: drawieModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.throwality ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 24
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#F6F7F9")
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgView)
        bgView.addSubview(nameLabel)
        
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-18)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedState(_ isSelected: Bool) {
        bgView.backgroundColor = isSelected ? UIColor.init(hexString: "#E7FDE3") : UIColor.init(hexString: "#F6F7F9")
        
        nameLabel.font = isSelected ? UIFont.systemFont(ofSize: 15, weight: .bold) : UIFont.systemFont(ofSize: 15, weight: .regular)
    }
}
