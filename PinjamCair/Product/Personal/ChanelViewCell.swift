//
//  ChanelViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
import SnapKit

class ChanelViewCell: UITableViewCell {
    
    var textChangedBlock: ((String) -> Void)?
    
    var model: dieModel? {
        didSet {
            guard let model = model else { return }
            
            oneLabel.text = model.rusbadior ?? ""
            oneFiled.placeholder = model.larggovernmenton ?? ""
            
            let name = model.tvarium ?? ""
            oneFiled.text = name
            
            let autoivity = model.autoivity ?? ""
            oneFiled.keyboardType = autoivity == "1" ? .numberPad : .default
        }
    }
    
    lazy var oneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#000000")
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    lazy var oneFiled: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(hexString: "#F6F7F9")
        textField.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        textField.textColor = UIColor(hexString: "#000000")
        textField.layer.cornerRadius = 24
        textField.layer.masksToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        textField.leftViewMode = .always
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(oneLabel)
        contentView.addSubview(oneFiled)
        
        oneFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        
        oneFiled.snp.makeConstraints { make in
            make.left.equalTo(oneLabel)
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(oneLabel.snp.bottom).offset(8)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        model?.tvarium = text
        
        model?.emesive = text
        
        textChangedBlock?(text)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        oneFiled.text = nil
        textChangedBlock = nil
    }
}
