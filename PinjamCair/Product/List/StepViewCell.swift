//
//  StepViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import SnapKit

class StepViewCell: UITableViewCell {
    
    var model: mrerModel? {
        didSet {
            guard let model = model else { return }
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#1DBC79")
        return bgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 86.pix()))
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
