//
//  ImageCarouselCell.swift
//  PinjamCair
//
//  Created by Ryan Thomas on 2026/3/4.
//

import UIKit
import SnapKit
import FSPagerView

class ImageCarouselCell: FSPagerViewCell {
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.init(hexString: "#000000")
        label.numberOfLines = 2
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "bl_a_ar_image")
        return logoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        
        addSubview(contentLabel)
        addSubview(logoImageView)
        
        contentLabel.snp.makeConstraints { make in
            make.left.bottom.top.equalToSuperview()
            make.right.equalToSuperview().offset(-40)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Configure
    func configure(with model: notdropalityModel) {
        contentLabel.text = model.urgth ?? ""
        
    }
}
