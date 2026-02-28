//
//  CoachViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CoachViewCell: UITableViewCell {
    
    var model: dieModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.rusbadior ?? ""
            oneFiled.placeholder = model.larggovernmenton ?? ""
            
            let name = model.tvarium ?? ""
            oneFiled.text = name
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
        
        oneFiled.addSubview(aImageView)
        contentView.addSubview(clickBtn)
        
        aImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
            make.right.equalToSuperview().offset(-20)
        }
        
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clickBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.clickTapBlock?()
            }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
