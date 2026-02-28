//
//  ChanelViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
import SnapKit

class ChanelViewCell: UITableViewCell {
    
    var model: dieModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.rusbadior ?? ""
            oneFiled.placeholder = model.larggovernmenton ?? ""
        }
    }

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
        return oneFiled
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(oneLabel)
        contentView.addSubview(oneFiled)
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        oneFiled.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(oneLabel)
            make.top.equalTo(oneLabel.snp.bottom).offset(8.pix())
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
