//
//  CardListView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import SnapKit

class CardListView: UIView {
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#000000")
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hexString: "#0B3F29")
        twoLabel.font = UIFont.systemFont(ofSize: 36, weight: .black)
        return twoLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 16
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#E7FDE3")
        return bgView
    }()
    
    lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        rateLabel.textAlignment = .center
        rateLabel.textColor = UIColor.init(hexString: "#1DBC79")
        rateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return rateLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneLabel)
        addSubview(twoLabel)
        addSubview(bgView)
        bgView.addSubview(rateLabel)
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel)
            make.top.equalTo(oneLabel.snp.bottom).offset(4)
            make.height.equalTo(44)
        }
        
        bgView.snp.makeConstraints { make in
            make.left.equalTo(oneLabel)
            make.top.equalTo(twoLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 200.pix(), height: 32.pix()))
        }
        
        rateLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
